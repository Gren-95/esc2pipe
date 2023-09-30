#! bash oh-my-bash.module

function _omb_plugin_pipe__is_inserted {
  [[ "$READLINE_LINE" = '| '* ]]
}

function _omb_plugin_pipe_add_pipe {
  if [[ -z $READLINE_LINE ]]; then
    READLINE_LINE="$(fc -ln -1 | command sed 's/^[[:space:]]\{1,\}//')"
    READLINE_POINT=${#READLINE_LINE}
    _omb_plugin_pipe__is_inserted && return
  fi
  if _omb_plugin_pipe__is_inserted; then
    READLINE_LINE="${READLINE_LINE%|}"
    ((READLINE_POINT -= 1))
  else
    READLINE_LINE="$READLINE_LINE |"
    ((READLINE_POINT += 2))
  fi
  ((READLINE_POINT < 0)) && READLINE_POINT=0
}

bind -m emacs -x '"\e[18~": _omb_plugin_pipe_add_pipe'
bind -m vi-insert -x '"\e[18~": _omb_plugin_pipe_add_pipe'
bind -m vi-command -x '"\e[18~": _omb_plugin_pipe_add_pipe'

