bold="$(tput bold)"
light="$(tput setaf 3)"
dark="$(tput setaf 8)"
neutral="$(tput setaf 7)"
reset="$(tput sgr0)"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    printf '   '
    exit 0
}

gst="$(git status --porcelain=2 --branch 2>/dev/null)"

if printf '%s\n' "$gst" | grep -Eq '^(1|2|u|\?) '; then
    printf "%s%s%s" "$bold" "$light" "$reset"
    branch=$(git branch --show-current 2>/dev/null)
    printf ' %s%s' "$neutral" "$branch"
    exit 0
fi

if printf '%s\n' "$gst" | grep -Eq '^# branch\.ab \+[1-9][0-9]* -[0-9]+|^# branch\.ab \+[0-9]+ -[1-9][0-9]*'; then
    printf "%s%s%s" "$bold" "$light" "$reset"
    branch=$(git branch --show-current 2>/dev/null)
    printf ' %s%s' "$neutral" "$branch"
    exit 0
fi

printf "%s%s%s" "$bold" "$dark" "$reset"
branch=$(git branch --show-current 2>/dev/null)
printf ' %s%s' "$neutral" "$branch"
