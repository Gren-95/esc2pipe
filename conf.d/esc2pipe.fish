# ~/.config/fish/conf.d/esc2pipe.fish

function insert_pipe_on_esc
    commandline -i " |"
end

bind \e 'insert_pipe_on_esc'
