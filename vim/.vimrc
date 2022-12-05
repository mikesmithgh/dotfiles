"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Sections:
"    -> vim-plug configuration
"    -> General
"    -> VIMUserInterface
"    -> Colors and Fonts
"    -> TextRelated
"    -> gruvbox configuration
"    -> Status line
"    -> Spell checking
"    -> ctrlp.vim configuration
"    -> The NERD Tree commenter configuration
"    -> NERDCommenterConfiguration
"    -> VimWiki configuration
"    -> vim-airline configuration
"    -> vim-gitgutter configuration
"    -> Asynchronous Lint Engine configuration
"    -> Filetype configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plugin configuration https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Project Drawer
Plug 'https://github.com/scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind'] }

" Code commenter
Plug 'https://github.com/preservim/nerdcommenter'

" Git integration
Plug 'https://github.com/tpope/vim-fugitive'

" Git browser integration
Plug 'https://github.com/tpope/vim-rhubarb'

" Git diff in sign column
Plug 'https://github.com/airblade/vim-gitgutter'

" Theme, fork of morhetz/gruvbox
Plug 'https://github.com/mikesmithgh/gruvbox', { 'branch': 'feat-palette-overrides' }

" Not sure if I use this besides yaml?
" Asynchronous Lint Engine https://github.com/dense-analysis/ale
" Plug 'dense-analysis/ale'

" statusline and tabline
Plug 'https://github.com/vim-airline/vim-airline'
" I might switch to https://github.com/itchyny/lightline.vim

" VimWiki https://github.com/vimwiki/vimwiki
Plug 'vimwiki/vimwiki'

" I haven't been using this
" EditorConfig Vim Plugin
" Plug 'editorconfig/editorconfig-vim'

" Improved keybindings
Plug 'tpope/vim-unimpaired'

" Improved repeatable commands
Plug 'tpope/vim-repeat'

" Disable hybrid line numbers for non-active buffers
Plug 'https://github.com/jeffkreeftmeijer/vim-numbertoggle'

" Improved parenthesis matching
Plug 'https://github.com/adelarsq/vim-matchit'

" Fuzzy Finder
Plug 'https://github.com/junegunn/fzf'

" Fuzzy Finder vim commands
Plug 'https://github.com/junegunn/fzf.vim'

" Code completion and LSP support
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}

" https://github.com/:uiiaoo/java-syntax.vim
Plug 'https://github.com/uiiaoo/java-syntax.vim', { 'for': 'java' }

" Kinesis Advantage configuration syntax highlighting
Plug 'https://github.com/arjenl/vim-kinesis'

" Pointless plugin
Plug 'https://github.com/mikesmithgh/ugbi', { 'branch': 'main' }

" Misc
" Plug 'powerman/vim-plugin-AnsiEsc'
" Plug 'chrisbra/Colorizer'

" initialize plugin systems
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" Sets how many lines of history VIM has to remember
set history=500

" enable mouse use in all modes
set mouse=a


" change leader key from \ to space
nnoremap <SPACE> <Nop>
let mapleader=' '

" map jj to Esc
inoremap jj <Esc>

" toggle highlight
nnoremap <leader>/ :set hlsearch! <cr>

" Toggle list characters
nmap <leader>l :set list!<cr>

" highlight then enter search mode
nnoremap / :set hlsearch<cr>/
nnoremap ? :set hlsearch<cr>?
nnoremap * :set hlsearch<cr>*
nnoremap # :set hlsearch<cr>#
nnoremap g* :set hlsearch<cr>g*
nnoremap g# :set hlsearch<cr>g#
augroup unhighlight
    autocmd!
    autocmd CursorHold * set nohlsearch
    autocmd InsertEnter * set nohlsearch
augroup end


" if bufwinnr(1)
" " resize vertical split window
" nnoremap <silent> <C-H> :vertical resize -5<CR>
" nnoremap <silent> <C-L> :vertical resize +5<CR>
" " resize horzontal split window
" nnoremap <silent> <C-J> :resize -5<CR>
" nnoremap <silent> <C-K> :resize +5<CR>
" endif

" yank/put copy/paste mappings
nnoremap Y y$
nnoremap pp :put<CR>
nnoremap PP :.-1put<CR>

vnoremap <leader>Y "+Y
vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>Y "+y$
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>p "+p<CR>
nnoremap <leader>pp :put +<CR>
nnoremap <leader>P "+P<CR>
nnoremap <leader>PP :.-1put +<CR>
" todo zyzp mappings

" Automatically reload file if an external change is detected
set autoread

" Persistent undo
set undodir=~/.vim/undo
set undofile

cmap w!! w !sudo tee > /dev/null %


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIMUserInterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines visible above/below the cursor
set scrolloff=7

" Ignore case when searching
set ignorecase

" Case sensitive when searching with at least one uppcase letter
set smartcase

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
" set timeoutlen=500 "" TODO check if I want this or not

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Show matching brackets when text indicator is over them
set showmatch

" Show hybrid line numbers, the current line is absolute line number and all other
" will be relative line numbers
set number relativenumber

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
" => gruvbox configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gruvbox options should be defined before setting colorscheme, see: https://github.com/morhetz/gruvbox/wiki/Configuration#options
let g:gruvbox_bold = 1
" italic must be enabled before setting colorscheme, see issue: https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
let g:gruvbox_italic = 1
let g:gruvbox_transparent_bg = 0
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_inverse = 1
let g:gruvbox_termcolors = 256
" gruvbox color palette: https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim#L86
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_hls_cursor = 'bright_purple'
let g:gruvbox_number_column = 'black1'
let g:gruvbox_sign_column = 'black2'
let g:gruvbox_color_column = 'black1'
let g:gruvbox_vert_split = 'black3'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 0
let g:gruvbox_invert_selection  = 0
let g:gruvbox_invert_signs = 0
let g:gruvbox_invert_indent_guides = 0
let g:gruvbox_invert_tabline = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 0
let g:gruvbox_palette_overrides = {
            \ 'black': ['#000000', 0],
            \ 'black1': ['#070707', 0],
            \ 'black2': ['#0d0d0d', 0],
            \ 'black3': ['#1a1a1a', 0],
            \ 'bright_green': ['#b5cea8', 142],
            \ 'bright_yellow': ['#f0d961', 214]
            \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable undercurl
let &t_Cs = "\e[4:3m" " start
let &t_Ce = "\e[4:0m" " end

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette
set t_Co=256

" Enables 24-bit color, i.e., 8*8*8=512 instead of 8-bit 256 color, see issue: https://github.com/morhetz/gruvbox/wiki/Terminal-specific#2-colors-are-off
set termguicolors

if has ('gui_running')
    set guioptions-=L
    set guifont=Hack\ Nerd\ Font:h16
endif

" Details on why highlight commands should be in an augroup:
" - https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
" - https://www.reddit.com/r/vim/wiki/vimrctips/#wiki_put_your_highlight_commands_in_an_autocmd
augroup BlackBackground
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=Black
    autocmd ColorScheme * highlight Normal guibg=#070707
augroup end

colorscheme gruvbox
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TextRelated
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
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
" let g:github_enterprise_urls = ['']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sa zg
map <leader>s? z=




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The NERD Tree configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-n> <Nop>
nnoremap <C-n>n :NERDTreeToggle<CR>
nnoremap <expr> <C-n><C-n> &filetype == 'nerdtree' ? '<C-w><C-p>' : ':silent NERDTreeFind \| NERDTreeFocus<CR>'
nnoremap <C-n><C-q> :copen<CR>
nnoremap <C-n>q :cclose<CR>
nnoremap <C-n><C-l> :lopen<CR>
nnoremap <C-n>l :lclose<CR>
let NERDTreeShowHidden=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenterConfiguration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1 " add space before comment
let g:NERDDefaultAlign = 'start' " comments start at beginning of line instead of word
let g:NERDCommentEmptyLines = 1
let g:NERDMenuMode = 0 " no menu
let g:NERDToggleCheckAllLines = 1
augroup NERDCommenter
  " disable auto insert comment leader after <Enter> in insert mode
  autocmd!
  autocmd FileType * set fo-=ro
augroup end

" See https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
" C-_ is C-/
nnoremap <C-_> <Plug>NERDCommenterToggle
vnoremap <C-_> <Plug>NERDCommenterToggle
nnoremap <C-?> <Plug>NERDCommenterSexy
vnoremap <C-?> <Plug>NERDCommenterSexy
" vnoremap <C-_> :execute "normal ".(line("'>") - line("'<") + 1)."\<Plug>NERDCommenterToggle"<CR>

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
let g:airline#extensions#fzf#enabled = 1
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
            \ 'yaml': ['yamlfix'],
            \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup FileTypeConfigs
    autocmd!
    autocmd BufNewFile,BufRead ~/.aws/config set filetype=toml
    autocmd BufNewFile,BufRead ~/.aws/credentials set filetype=toml
    autocmd BufNewFile,BufRead *.pipeline set filetype=json
    autocmd BufNewFile,BufRead *.pipeline set filetype=json
    " for fc commands
    autocmd BufNewFile,BufRead bash-fc.* silent! !rm %
    autocmd FileChangedShell bash-fc.* 5echowindow "To execute the command you must write the buffer contents."
augroup end


" See https://github.com/vim/vim/blob/f220643c260d55d21a841a3c4032daadc41bc50b/runtime/defaults.vim#L140
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.

" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
