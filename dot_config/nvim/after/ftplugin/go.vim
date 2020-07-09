" Go Stuff
" ============
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ }


let $GOPATH = '/home/jb/prog/go'
let g:go_fmt_command = 'goimports'
map <leader>r :GoRun <CR>
