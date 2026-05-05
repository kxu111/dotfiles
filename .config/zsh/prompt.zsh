PROMPT='%~ $ '

# color change for vi mode
function zle-keymap-select { 
    if [[ ${KEYMAP} == vicmd ]]; then
        PROMPT='%F{magenta}%~ $ %f'
    else
        PROMPT='%F{white}%~ $ %f'
    fi
    zle reset-prompt
}

zle -N zle-keymap-select

