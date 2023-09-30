# ~/.oh-my-zsh/custom/plugins/pipe_plugin/pipe_plugin.plugin.zsh

# Custom key binding to insert a pipe symbol on Esc
insert_pipe_on_esc() {
  BUFFER=" |$BUFFER"
  CURSOR=$((CURSOR + 2))
}

bindkey -s '\e' ' |'

