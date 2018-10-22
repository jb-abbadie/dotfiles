" Go Stuff
" ============
let $GOPATH = '/home/jb/prog/go'
let g:go_fmt_command = 'goimports'
map <leader>r :GoRun <CR>
call neomake#configure#automake('rw', 500)
