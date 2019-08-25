let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

let g:syntastic_python_python_exec = 'python'
let g:ycm_python_binary_path = 'python'
let test#python#pytest#options = '-s'
let g:deoplete#enable_at_startup = 1
