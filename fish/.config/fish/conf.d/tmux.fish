function tmux_pane_title --on-event fish_prompt
    if set -q TMUX
        printf "\033k"(prompt_pwd)"\033"
    end
end

function tmux_exec --on-event fish_preexec
    if set -q TMUX
        printf "\033k"$argv"\033"
    end
end

