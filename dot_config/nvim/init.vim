set shell=bash
set shellpipe=2>/dev/null>

" ============
" Plugins here
" =============
call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'ryanoasis/vim-devicons'

" Language
Plug 'janko-m/vim-test'
Plug 'towolf/vim-helm'

" Misc
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'

" LSP/treesitter
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()




" ==============
" General Config
" ==============

let mapleader=','               " I just use the default Leader
let g:mapleader=','             " I just use the default Leader
set number                      " Line numbers are nice
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set autoread                    " Reload files changed outside vim
set laststatus=2                " Always show status line
set hidden                      " Buffers can exist in the background
set splitright                  " Opens vertical split right of current window
set splitbelow                  " Opens horizontal split below current window
set shortmess=filnxtToOI        " see :help shortmess
set clipboard+=unnamedplus

nnoremap k gk
nnoremap j gj

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Appearance
" ==========
syntax enable
set background=dark
set termguicolors
colorscheme solarized8
let g:rainbow_active = 1

set noshowmode                                  " Let airline handle the mode display

" Leader commands
" ===============

nmap <leader>w :w!<cr>
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

map <silent> <leader><cr> :noh<cr>

" Search Settings
" ===============

set ignorecase
set smartcase
set incsearch        " Find the next match as we type the search
set hlsearch         " Highlight searches by default
set viminfo='100,f1  " Save up to 100 marks, enable capital marks

" Turn Off Swap Files
" ===================
set noswapfile
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" Indentation and Display
" =======================
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set list listchars=tab:\›\ ,trail:·   " Display tabs and trailing spaces visually
set wrap                              " wrap lines

" Python config
" =============
let g:python3_host_prog = '/home/jb/.pyenv/versions/pynvim/bin/python'
let g:python_host_prog = '/home/jb/.pyenv/versions/py2_pynvim/bin/python'


" Folds
" =====
set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Don't fold by default

" Scrolling
" =========
" Start scrolling when we're getting close to margins
set scrolloff=10
set sidescrolloff=15
set sidescroll=1


" Filetype
" ========
"
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *gotmpl set ft=helm




" ==============
" Plugin Options
" ==============

" vim-test
" ========
let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" NerdTree
" ========
map <C-n> :NERDTreeToggle<CR>

" FZF
" ===
map <C-p> :FZF<CR>

" Grepper
" =======
map <C-r> :Grepper<CR>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" Airline options
" ===============
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'


" nvim-compe
" ==========
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

lua << EOF

require'lspconfig'.gopls.setup{}
require'lspconfig'.rls.setup{}
require'lspconfig'.terraformls.setup{}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    }
}

EOF
