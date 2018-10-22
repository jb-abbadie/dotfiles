let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

let g:neomake_python_enabled_makers = ['python', 'pylint', 'flake8']
let g:syntastic_python_python_exec = 'python'
let g:ycm_python_binary_path = 'python'
let test#python#pytest#options = '-s'
call neomake#configure#automake('nrw', 750)
let g:deoplete#enable_at_startup = 1
