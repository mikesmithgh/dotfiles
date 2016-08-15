set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Fugitive GIT plugin
Plugin 'tpope/vim-fugitive'

" GIT gutter
Plugin 'airblade/vim-gitgutter'

" NERDTree sidebar
Bundle 'scrooloose/nerdtree'

" NERDCommenter
Plugin 'scrooloose/nerdcommenter'

" Syntax Checker
Plugin 'scrooloose/syntastic'

" CtrlP Fuzzy Search
Plugin 'ctrlpvim/ctrlp.vim'

" Vim Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" JSBeautify
Plugin 'maksimr/vim-jsbeautify'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable
set t_Co=256
set background=dark
colorscheme distinguished
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
set mouse=a " Enable mouse use in all modes

" map jj to Esc
imap jj <Esc>

" change leader key from \ to ,
let mapleader=","

" do not let read only files to be  modified
" autocmd BufRead * let &modifiable = !&readonly

" NERDTree 
" map ctl+n to toggler nerd tree sidebar
map <C-n> :NERDTreeToggle<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp' " Set cache directory
let g:ctrlp_working_path_mode = 0               " Search from current directory instead of project root
let g:ctrlp_clear_cache_on_exit = 0             " Do not clear cache between sessions
" Use ag to search if installed to improve performance
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" VIM airline
let g:airline#extensions#tabline#enabled = 1     " enable airline by default
let g:airline#extensions#tabline#fnamemod = ':t' " only display file name instead of file path
set laststatus=2                                 " always show status line
set noshowmode                                   " disable show mode in favor of airline status line

" NERDCommenter
let g:NERDSpaceDelims = 1 " add space before comment
au FileType * set fo-=r   " disable auto insert comment leader after <Enter> in insert mode

" Fugitive add branch name to status line
set statusline+=%{fugitive#statusline()}

" Syntastic
let g:syntastic_javascript_checkers = ['eslint'] " javascript eslinter

" add linter info to status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1 " populate the location list with errors from linters
let g:syntastic_auto_loc_list = 0            " do not automatically open location list
let g:syntastic_check_on_open = 0            " do not check for errors on open to improve performance
let g:syntastic_check_on_wq = 0              " do not check for errors when saving to improve performance
let g:syntastic_loc_list_height = 3          " height of location list

" JSBeautify
map <c-f> :call JsBeautify()<cr>

" GIT Gutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
