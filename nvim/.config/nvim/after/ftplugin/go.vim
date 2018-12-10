" Go Stuff
" ============
let g:LanguageClient_serverCommands = {
    \ 'go': ['~/prog/go/bin/go-langserver'],
    \ }


let $GOPATH = '/home/jb/prog/go'
let g:go_fmt_command = 'goimports'
map <leader>r :GoRun <CR>
call neomake#configure#automake('rw', 500)
