""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
if has('nvim') 
  echo 'this vimrc is not meant for nvim, please use vim'
  quit
else
  let data_dir = '~/.config/vim'

  " Install vim-plug if not found
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif


  " do not recreate function if we are sourcing the file
  if exists("*ReloadVimrc") == 0
    function! ReloadVimrc(timer_id)
      defer execute('source $MYVIMRC | PlugStatus')
    endfunction
  endif

  function! PlugInstallAndSource()
    PlugInstall --sync
    call timer_start(0, 'ReloadVimrc')
  endfunction

  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| call PlugInstallAndSource()
  \| endif

endif

" specify a directory for plugins
call plug#begin('~/.local/share/vim/plugged')

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
Plug 'mikesmithgh/ugbi'

" Misc
" Plug 'powerman/vim-plugin-AnsiEsc'
" Plug 'chrisbra/Colorizer'
Plug 'ludovicchabant/vim-gutentags'

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
" nnoremap yyy :%y<CR>
" nnoremap pp :put<CR> already done by vim unimpaired
" nnoremap PP :.-1put<CR>

vnoremap <leader>Y "+Y
vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>Y "+y$
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy
" nnoremap <leader>yyy :%y+<CR>
nnoremap <leader>p "+p<CR>
nnoremap <leader>P "+P<CR>

" todo zy and zp mappings

" Automatically reload file if an external change is detected
set autoread

" Persistent undo
if has('nvim')
  " default nvim directory
  set undodir=~/.local/state/nvim/undo
else
  set undodir=~/.vim/undo
endif
set undofile

cmap w!! w !sudo tee > /dev/null %


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIMUserInterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scroll=5
augroup scroll
    autocmd!    
    autocmd BufNewFile,BufRead * set scroll=5
augroup end

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
nnoremap <C-h> 3h
nnoremap <C-j> 5j
nnoremap <C-k> 5k
nnoremap <C-l> 3l
vnoremap <C-h> 3h
vnoremap <C-j> 5j
vnoremap <C-k> 5k
vnoremap <C-l> 3l

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

" hide insert autocomplete messages and while scanning for completion items
" set shortmess+=cC
" enable spell check completion
set complete+=kspell

" Improve popup completion menu
set completeopt=longest,menuone

" Whitespace characters
set listchars=eol:↲,tab:▸\ ,trail:·,extends:»,precedes:«,space:·


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gruvbox configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gruvbox options should be defined before setting colorscheme, see: https://github.com/morhetz/gruvbox/wiki/Configuration#options
let g:gruvbox_undercurl = 1
let g:gruvbox_underline = 1
let g:gruvbox_bold = 1
" italic must be enabled before setting colorscheme, see issue: https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
let g:gruvbox_italic = 1
let g:gruvbox_invert_selection  = 0
let g:gruvbox_invert_signs = 0
let g:gruvbox_invert_tabline = 0
let g:gruvbox_invert_indent_guides = 0
let g:gruvbox_inverse = 1
let g:gruvbox_transparent_bg = 0
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_termcolors = 256
" gruvbox color palette: https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim#L86

let g:gruvbox_hls_cursor = 'bright_purple'
let g:gruvbox_number_column = 'black1'
let g:gruvbox_sign_column = 'black2'
let g:gruvbox_color_column = 'black1'
let g:gruvbox_vert_split = 'black3'

let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 0
let g:gruvbox_palette_overrides = {
            \ 'black': ['#000000', 0],
            \ 'black1': ['#070707', 0],
            \ 'black2': ['#0d0d0d', 0],
            \ 'black3': ['#1a1a1a', 0],
            \ 'bright_green': ['#b5cea8', 142],
            \ 'bright_yellow': ['#f0d961', 214],
            \ 'light1': ['#c7c7c7', 223]
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

" {rtp}/autoload/has.vim
function! HasColorscheme(name) abort
    " copied from https://stackoverflow.com/questions/5698284/in-my-vimrc-how-can-i-check-for-the-existence-of-a-color-scheme
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

if HasColorscheme('gruvbox')
  colorscheme gruvbox
elseif HasColorscheme('retrobox')
  colorscheme retrobox
endif

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set fileformats=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TextRelated
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

set shiftwidth=2
set tabstop=2
set softtabstop=2

augroup TabStops
  autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup end

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
if exists('g:loaded_fugitive')
  set statusline+=%{fugitive#statusline()}
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
" map <leader>sn ]s
" map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => ctrlp.vim configuration
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" " set cache directory
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" " search from current directory instead of project root
" let g:ctrlp_working_path_mode = 0
" " do not clear cache between sessions
" let g:ctrlp_clear_cache_on_exit = 0
" " use ag to search if installed to improve performance
" if executable('ag')
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The NERD Tree configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map ctl+n to toggle nerd tree sidebar
" map <leader>n :NERDTreeToggle<CR>
" note: I previously mapped <C-n> and <C-m>, however, <C-m> maps to <Enter>
" causing a conflict in the quickfix menu. See https://github.com/preservim/nerdtree/issues/964
nnoremap <C-n> <Nop>
nnoremap <C-n>n :NERDTreeToggle<CR>
nnoremap <expr> <C-n><C-n> &filetype == 'nerdtree' ? '<C-w><C-p>' : ':silent NERDTreeFind \| NERDTreeFocus<CR>'
nnoremap <C-n><C-q> :copen<CR>
nnoremap <C-n>q :cclose<CR>
nnoremap <C-n><C-l> :lopen<CR>
nnoremap <C-n>l :lclose<CR>

" nnoremap <C-n><C-n> :NERDTreeFind<CR>
" nnoremap <Nul> :NERDTreeFind<CR>
" nnoremap <Nul><C-n> :ls<CR>
" augroup QuickFixEnter
" autocmd!
" autocmd BufWinEnter quickfix map <buffer> <C-m> :.cc<CR>
" autocmd WinEnter *
" \ if &buftype == 'quickfix' |
" \   map <buffer> <C-m> :.cc<CR> |
" \ endif
" augroup end


" show hidden files
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

if has('nvim')
  nnoremap <C-/> <Plug>NERDCommenterToggle
  vnoremap <C-/> <Plug>NERDCommenterToggle
else
  " See https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
  " C-_ is C-/
  nnoremap <C-_> <Plug>NERDCommenterToggle
  vnoremap <C-_> <Plug>NERDCommenterToggle
endif
nnoremap <C-?> <Plug>NERDCommenterSexy
vnoremap <C-?> <Plug>NERDCommenterSexy
" vnoremap <C-_> :execute "normal ".(line("'>") - line("'<") + 1)."\<Plug>NERDCommenterToggle"<CR>


" """"""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki configuration
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""
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
    autocmd BufNewFile,BufRead ~/.aws/config setlocal filetype=toml
    autocmd BufNewFile,BufRead ~/.aws/credentials setlocal filetype=toml
    autocmd BufNewFile,BufRead *.pipeline if search('^---\|\s\+\w\+:\s*', 'nW') | setlocal filetype=yaml | else | setlocal filetype=json | endif
    " for fc commands
    autocmd BufNewFile,BufRead bash-fc.* silent! !rm %
    autocmd FileChangedShell bash-fc.* 5echowindow "To execute the command you must write the buffer contents."
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => testing section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ttyfast

" See https://github.com/vim/vim/blob/f220643c260d55d21a841a3c4032daadc41bc50b/runtime/defaults.vim#L140
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.

" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


" Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
" Revert with ":unmap Q".
map Q gq
sunmap Q

" set ttimeout		" time out for key codes
" set ttimeoutlen=100	" wait up to 100ms after Esc for special key
" set timeout timeoutlen=300 ttimeoutlen=100
" " fix meta-keys which generate <Esc>a .. <Esc>z " this caused issues
" let c='a'
" while c <= 'z'
" exec "set <M-".toupper(c).">=\e".c
" exec "imap \e".c." <M-".toupper(c).">"
" let c = nr2char(1+char2nr(c))
" endw


if bufwinnr(1)
    " resize vertical split window
    nnoremap <silent> <M-H> :vertical resize -5<CR>
    nnoremap <silent> <M-L> :vertical resize +5<CR>
    " resize horzontal split window
    nnoremap <silent> <M-J> :resize -5<CR>
    nnoremap <silent> <M-K> :resize +5<CR>
endif

" let v:exiting = 9
" au ExitPre bash-fc.* echo "Exit value is " .. v:exiting | sleep 1000m | normal <C-c>
" map <Down> [
" map <Up> ]

" fzf

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }


" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" let g:fzf_layout = { 'down': '30%' }


nnoremap s <Nop>
nnoremap sf :Files<CR>
nnoremap sg :BLines<CR>
nnoremap sG :Rg<CR>
nnoremap sb :Buffers<CR>
nnoremap st :Tags<CR>

" TODO map me to something
nnoremap S <Nop>


function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

autocmd User AirlineAfterInit let g:airline_section_b .= '%{getcwd()}'
" let g:airline_section_c .= '%t'

" show message for any line change, this help see the register info
set report=0
" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" inoremap <silent><expr> <Tab>
" \ coc#pum#visible() ? coc#pum#next(1) :
" \ CheckBackspace() ? "\<Tab>" :
" \ coc#refresh()

" inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
" inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
inoremap <expr> <Cr> coc#pum#visible() ? coc#pum#confirm() : "\<Cr>"

" set autochdir
set tags=tags;$HOME

set hidden

nnoremap <Leader>w <C-w>

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" https://github.com/neoclide/coc.nvim/issues/1445
function! s:GoToDefinition()
    try

        if CocAction('jumpDefinition')
            return v:true
        endif
    catch 
    endtry

    let ret = execute("silent! normal! \<C-]>")
    if ret =~ "Error"
        call searchdecl(expand('<cword>'))
    endif
endfunction

nmap <silent> gd :call <SID>GoToDefinition()<CR>

" augroup DiffUndoFold
"     autocmd!    
"     autocmd DiffUpdated * execute 'normal! zi]c'
" augroup end

" let g:colorizer_debug = 1

set virtualedit=block
set showcmd

" set fillchars=vert:│,fold:·,eob:~,lastline:@

set directory^=$HOME/.local/state/vim/swap//

" set backupdir=~/.backup//
" set backup
" set backupcopy=yes
" set backupext=.bak
" set writebackup

