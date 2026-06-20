#!/bin/bash
if [ -f /tmp/workmode-enabled ]; then
    echo "#[reverse bold fg=colour15,bg=black]"
else
    echo "#[bold fg=colour15,bg=default]"
fi
