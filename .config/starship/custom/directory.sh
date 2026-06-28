dark="$(tput setaf 8)"
light="$(tput setaf 4)"
reset="$(tput sgr0)"
italic="$(tput sitm)"

home="${HOME%/}"
pwd="${PWD%/}"

if [ "$pwd" = "$home" ]; then
    display="~"
elif [ "${pwd#"$home"/}" != "$pwd" ]; then
    display="~/${pwd#"$home"/}"
else
    display="$pwd"
fi

parent="${display%/*}"
base="${display##*/}"

if [ "$display" = "/" ] || [ "$display" = "~" ] || [ "$parent" = "$display" ]; then
    printf "%s%s%s%s\n" "$italic" "$dark" "$display" "$reset"
else
    printf "%s%s%s/%s%s%s\n" "$italic" "$dark" "$parent" "$light" "$base" "$reset"
fi
