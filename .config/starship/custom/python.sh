active="$(tput setaf 3)"
inactive="$(tput setaf 8)"
reset="$(tput sgr0)"

dir="$PWD"
venv=""

while :; do
    if [ -d "$dir.venv" ]; then
        venv="$dir.venv"
        break
    fi
    if [ -d "$dir/.venv" ]; then
        venv="$dir/.venv"
        break
    fi
    [ "$dir" = "/" ] && break
    dir="${dir%/*}"
    [ -z "$dir" ] && dir="/"
done

if [ -z "$venv" ]; then
    printf '   '
    exit 0
fi

if [ -n "$VIRTUAL_ENV" ] && [ "$VIRTUAL_ENV" = "$venv" ]; then
    printf "%s%s%s" "$active" "$active" "$reset"
else
    printf "%s%s%s" "$inactive" "$inactive" "$reset"
fi
