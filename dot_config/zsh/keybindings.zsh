# Native ZLE bindings; do not replace or chain terminal-owned line-init hooks.
[[ ${TERM:-dumb} != dumb ]] && () {
  local key widget capability

  # Ctrl-arrows and Option/Alt-arrows, including Kitty's enhanced keyboard mode.
  for key in $'\e[1;5D' $'\e[5D' $'\e\e[D' $'\eOd' $'\eOD' $'\e[1;3D'; do
    bindkey "$key" backward-word
  done
  for key in $'\e[1;5C' $'\e[5C' $'\e\e[C' $'\eOc' $'\eOC' $'\e[1;3C'; do
    bindkey "$key" forward-word
  done

  # Accept both normal and application-mode sequences without switching modes.
  local -A bindings=(
    $'\e[A' up-line-or-history    $'\eOA' up-line-or-history
    $'\e[B' down-line-or-history  $'\eOB' down-line-or-history
    $'\e[C' forward-char          $'\eOC' forward-char
    $'\e[D' backward-char         $'\eOD' backward-char
    $'\e[H' beginning-of-line     $'\eOH' beginning-of-line
    $'\e[F' end-of-line           $'\eOF' end-of-line
    $'\e[1~' beginning-of-line    $'\e[4~' end-of-line
    $'\e[7~' beginning-of-line    $'\e[8~' end-of-line
    $'\e[2~' overwrite-mode       $'\e[3~' delete-char
    $'\e[5~' up-line-or-history   $'\e[6~' down-line-or-history
    $'\e[Z' reverse-menu-complete
  )
  for key widget in "${(@kv)bindings}"; do
    bindkey "$key" "$widget"
  done

  # Also honor terminal-specific encodings advertised by terminfo.
  if zmodload zsh/terminfo; then
    for capability widget in \
      kcuu1 up-line-or-history kcud1 down-line-or-history \
      kcuf1 forward-char kcub1 backward-char \
      khome beginning-of-line kend end-of-line \
      kich1 overwrite-mode kdch1 delete-char \
      kpp up-line-or-history knp down-line-or-history \
      kcbt reverse-menu-complete; do
      [[ -n ${terminfo[$capability]:-} ]] && bindkey "${terminfo[$capability]}" "$widget"
    done
  fi

  bindkey '^?' backward-delete-char
  bindkey ' ' magic-space
  bindkey $'\e.' insert-last-word
  bindkey $'\e_' insert-last-word

  autoload -Uz edit-command-line bracketed-paste-url-magic url-quote-magic
  zle -N edit-command-line
  bindkey '^X^E' edit-command-line
  zle -N bracketed-paste bracketed-paste-url-magic
  zle -N self-insert url-quote-magic

  # Defined in ~/.zsh_functions; keep these ahead of plugin widget wrapping.
  zle -N skim-history-widget
  bindkey '^R' skim-history-widget
  zle -N skim-cd-widget
  bindkey '^S' skim-cd-widget
}
