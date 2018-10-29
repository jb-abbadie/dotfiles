if status --is-interactive
   keychain --eval --quiet --systemd | source
end

function fish_greeting
end

function tmux_pane_title --on-event fish_prompt
    printf "\033k"(prompt_pwd)"\033\\"
end

function tmux_exec --on-event fish_preexec
    printf "\033k"$argv"\033\\"
end
