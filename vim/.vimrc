"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Sections:
"    -> vim-plug configuration
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Text, tab and indent related
"    -> Status line
"    -> grubbox configuration
"    -> ctrlp.vim configuration
"    -> The NERD Tree commenter configuration
"    -> NERD commenter configuration
"    -> VimWiki configuration
"    -> vim-airline configuration
"    -> vim-gitgutter configuration
"    -> Asynchronous Lint Engine configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plugin configuration https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" specify a directory for plugins
call plug#begin('~/.vim/plugged')

" The NERDTree https://github.com/preservim/nerdtree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }

" NERD commenter https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'

" ctrlp.vim https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" fugitive.vim https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

" vim-gitgutter https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" gruvbox https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'

" Asynchronous Lint Engine https://github.com/dense-analysis/ale
Plug 'dense-analysis/ale'

" vim-airline https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" vim-airline-themes https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" VimWiki https://github.com/vimwiki/vimwiki
Plug 'vimwiki/vimwiki'

" initialize plugin systems
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

" enable mouse use in all modes
set mouse=a

" Enable filetype plugins
filetype plugin on
filetype indent on

" change leader key from \ to ,
let mapleader=','

" map jj to Esc
imap jj <Esc>

" toggle highlight
nmap <Leader>/ :set hls! <cr>

" Toggle list characters
nmap <leader>l :set list!<cr>

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines visible above/below the cursor
set scrolloff=7

" Ignore case when searching
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Show matching brackets when text indicator is over them
set showmatch

" Show line numbers
set number


" Turn on the Wild menu
set wildmenu
set wildmode=longest:full,full

" Highlight current line
set cursorline

" Improve popup completion menu
set completeopt=longest,menuone

" Whitespace characters
set listchars=eol:↲,tab:▸\ ,trail:·,extends:»,precedes:«,space:·


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette
set t_Co=256

set termguicolors

if has ('gui_running')
  set guioptions-=L
  set guifont=Hack\ Nerd\ Font:h16
endif

try
    colorscheme gruvbox
catch
endtry

" Black background
autocmd ColorScheme * highlight Normal ctermbg=Black
autocmd ColorScheme * highlight Normal guibg=Black
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=0

set autoindent " Auto indent
set smartindent " Smart indent
set nowrap " Disable wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" disable show mode in favor of airline status line
set noshowmode

" Fugitive add branch name to status line
set statusline+=%{fugitive#statusline()}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => grubbox configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp.vim configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The NERD Tree commenter configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map ctl+n to toggle nerd tree sidebar
map <C-n> :NERDTreeToggle<CR>
" show hidden files
let NERDTreeShowHidden=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERD commenter configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add space before comment
let g:NERDSpaceDelims = 1
" disable auto insert comment leader after <Enter> in insert mode
autocmd FileType * set fo-=r


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/Documents/notes/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
au BufNewFile ~/Documents/notes/wiki/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" assumption font-hack-nerd-font installed, see https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
let g:airline_powerline_fonts = 1                " enable powerline fonts
let g:airline#extensions#tabline#enabled = 1     " enable airline by default
let g:airline#extensions#tabline#fnamemod = ':t' " only display file name instead of file path
" see https://github.com/ryanoasis/powerline-extra-symbols
let g:airline_left_alt_sep = "\uE0B5"
let g:airline_left_sep = "\uE0B4"
let g:airline_right_alt_sep = "\uE0B7"
let g:airline_right_sep = "\uE0B6"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-gitgutter configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Asynchronous Lint Engine configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_fixers = {
\   'yaml': ['yamlfix'],
\}

