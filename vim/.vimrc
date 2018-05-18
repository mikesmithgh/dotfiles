"-------------------
"-- plugin config --
"-------------------

"specify a directory for plugins
call plug#begin('~/.vim/plugged')
"nerdtree sidebar
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }
" nerdcommenter
Plug 'scrooloose/nerdcommenter'
" ctrlp fuzzy search
Plug 'ctrlpvim/ctrlp.vim'

" Others
Plug 'majutsushi/tagbar'

" Java development
Plug 'artur-shaik/vim-javacomplete2'
Plug 'ajh17/Spacegray.vim'

" fugitive git plugin
Plug 'tpope/vim-fugitive'
" gitgutter
Plug 'airblade/vim-gitgutter'

" color schemes
" Plug 'freeo/vim-kalisi'
" Plug 'mhartington/oceanic-next'
" Plug 'zandrmartin/vim-distill'
" Plug 'adelarsq/vim-grimmjow'
Plug 'morhetz/gruvbox'
" Plug 'rakr/vim-one'
" Plug 'Reewr/vim-monokai-phoenix'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'
"

" Linter
" Plug 'w0rp/ale'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" initialize plugin systems
call plug#end()


"----------------
"-- vim config --
"----------------
syntax enable
set t_Co=256
set termguicolors

let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_hls_cursor = 'purple'
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_color_column = 'bg1'
let g:gruvbox_vert_split = 'bg0'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 0
let g:gruvbox_invert_selection  = 1
let g:gruvbox_invert_signs = 0
let g:gruvbox_invert_indent_guides = 0
let g:gruvbox_invert_tabline = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 0

colorscheme gruvbox
set background=dark
set hlsearch
set incsearch
set ignorecase
set backspace=indent,eol,start
set ruler
set autoindent
set number
set cursorline
set showmatch
set encoding=utf8
set expandtab
set wildmenu
set wildmode=longest:full,full
" enable mouse use in all modes
set mouse=a
set completeopt=longest,menuone


"------------------
"-- vim mappings --
"------------------
" map jj to Esc
imap jj <Esc>
" change leader key from \ to ,
let mapleader=','
" toggle highlight 
nmap <Leader>/ :set hls! <cr>
" highlight then enter search mode
nnoremap / :set hls<cr>/

if bufwinnr(1)
  " resize vertical split window
  noremap <silent> <C-H> :vertical resize -5<CR>
  noremap <silent> <C-L> :vertical resize +5<CR>
  " resize horzontal split window
  noremap <silent> <C-J> :resize -5<CR>
  noremap <silent> <C-K> :resize +5<CR>
endif

" nnoremap : q:i
" nnoremap / q/i
" nnoremap ? q?i


"-----------
"-- ctrlp --
"-----------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" set cache directory
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp' 
" search from current directory instead of project root
let g:ctrlp_working_path_mode = 0               
" do not clear cache between sessions
let g:ctrlp_clear_cache_on_exit = 0             
" use ag to search if installed to improve performance
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


"--------------
"-- nerdtree --
"--------------
" map ctl+n to toggle nerd tree sidebar
map <C-n> :NERDTreeToggle<CR>
" start up, call nerd tree when no args provided
" if 0 == argc()
  " au VimEnter * NERDTree | wincmd p
" end


"-------------------
"-- nerdcommenter --
"-------------------
" add space before comment
let g:NERDSpaceDelims = 1
" disable auto insert comment leader after <Enter> in insert mode
au FileType * set fo-=r

"""""""""""""""""""""""""
""""    deoplete     """"
"""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#file#enable_buffer_path = 1


"""""""""""""""""""""""""
""""  Java Complete  """"
"""""""""""""""""""""""""
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" airline
let g:airline_powerline_fonts = 1                " enable powerline fonts
let g:airline#extensions#tabline#enabled = 1     " enable airline by default
let g:airline#extensions#tabline#fnamemod = ':t' " only display file name instead of file path
set laststatus=2                                 " always show status line
set noshowmode                                   " disable show mode in favor of airline status line
" Fugitive add branch name to status line
set statusline+=%{fugitive#statusline()}

" GIT Gutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Black bg
autocmd ColorScheme * highlight Normal ctermbg=Black
" autocmd ColorScheme * highlight NonText ctermbg=Black
autocmd ColorScheme * highlight Normal guibg=Black
" autocmd ColorScheme * highlight NonText guibg=Black
