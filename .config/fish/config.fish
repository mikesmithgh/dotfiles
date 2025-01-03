set script_dir (dirname (status current-filename))

if status is-interactive
    set private_config $HOME/.config/fish/private.fish
    if test -f $private_config
        source $private_config
    end

    # xdg base directories (https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
    set --export XDG_RUNTIME_DIR (mktemp -u -t $USER)
    mkdir -p "$XDG_RUNTIME_DIR" & # this directory is important for neovim vim.fn.serverstart (used by fzf-lua)

    set --export XDG_CONFIG_HOME "$HOME/.config"
    set --export XDG_DATA_HOME "$HOME/.local/share"
    set --export XDG_STATE_HOME "$HOME/.local/state"
    set --export XDG_CACHE_HOME "$HOME/.cache"
    set --export XDG_DATA_DIRS /usr/local/share

    # ls
    # generated with vivid https://github.com/sharkdp/vivid
    # LS_COLORS="$(vivid generate ~/gitrepos/gruvsquirrel.nvim/extra/vivid/gruvsquirrel.yml)"
    set --export LS_COLORS '*~=3;38;2;150;140;129:bd=1;38;2;219;188;95:ca=0;38;2;7;7;7;48;2;255;105;97:cd=3;38;2;222;165;132:di=0;38;2;131;165;152:do=1;38;2;177;98;134:ex=1;38;2;83;101;78:fi=0;38;2;199;199;199:ln=3;38;2;69;133;136:mh=1:mi=0;38;2;199;199;199;48;2;175;58;3:no=0;38;2;199;199;199:or=3;38;2;175;58;3:ow=1;38;2;83;101;78:pi=0;38;2;211;134;155:rs=0:sg=0;38;2;7;7;7;48;2;214;153;29:so=1;38;2;211;134;155:st=0;38;2;199;199;199;48;2;131;165;152:su=0;38;2;199;199;199;48;2;255;105;97:tw=3;38;2;199;199;199;48;2;131;165;152:*.a=1;38;2;83;101;78:*.c=0;38;2;143;170;128:*.d=0;38;2;143;170;128:*.h=0;38;2;143;170;128:*.m=0;38;2;143;170;128:*.o=3;38;2;150;140;129:*.p=0;38;2;143;170;128:*.r=0;38;2;143;170;128:*.t=0;38;2;143;170;128:*.z=0;38;2;214;153;29:*.7z=0;38;2;214;153;29:*.as=0;38;2;143;170;128:*.bc=3;38;2;150;140;129:*.bz=0;38;2;214;153;29:*.cc=0;38;2;143;170;128:*.cp=0;38;2;143;170;128:*.cr=0;38;2;143;170;128:*.cs=0;38;2;143;170;128:*.di=0;38;2;143;170;128:*.el=0;38;2;143;170;128:*.ex=0;38;2;143;170;128:*.fs=0;38;2;143;170;128:*.go=0;38;2;143;170;128:*.gv=0;38;2;143;170;128:*.gz=0;38;2;214;153;29:*.hh=0;38;2;143;170;128:*.hi=3;38;2;150;140;129:*.hs=0;38;2;143;170;128:*.jl=0;38;2;143;170;128:*.js=0;38;2;143;170;128:*.ko=1;38;2;83;101;78:*.kt=0;38;2;143;170;128:*.la=3;38;2;150;140;129:*.ll=0;38;2;143;170;128:*.lo=3;38;2;150;140;129:*.md=0;38;2;219;188;95:*.ml=0;38;2;143;170;128:*.mn=0;38;2;143;170;128:*.nb=0;38;2;143;170;128:*.pl=0;38;2;143;170;128:*.pm=0;38;2;143;170;128:*.pp=0;38;2;143;170;128:*.ps=1;38;2;69;133;136:*.py=0;38;2;143;170;128:*.rb=0;38;2;143;170;128:*.rm=1;38;2;146;187;223:*.rs=0;38;2;143;170;128:*.sh=0;38;2;143;170;128:*.so=1;38;2;83;101;78:*.td=0;38;2;143;170;128:*.ts=0;38;2;143;170;128:*.ui=0;38;2;222;165;132:*.vb=0;38;2;143;170;128:*.wv=0;38;2;157;186;212:*.xz=0;38;2;214;153;29:*.aif=0;38;2;157;186;212:*.ape=0;38;2;157;186;212:*.apk=0;38;2;214;153;29:*.arj=0;38;2;214;153;29:*.asa=0;38;2;143;170;128:*.aux=3;38;2;150;140;129:*.avi=1;38;2;146;187;223:*.awk=0;38;2;143;170;128:*.bag=0;38;2;214;153;29:*.bak=3;38;2;150;140;129:*.bat=1;38;2;83;101;78:*.bbl=3;38;2;150;140;129:*.bcf=3;38;2;150;140;129:*.bib=0;38;2;222;165;132:*.bin=1;38;2;255;105;97:*.blg=3;38;2;150;140;129:*.bmp=0;38;2;157;186;212:*.bsh=0;38;2;143;170;128:*.bst=0;38;2;222;165;132:*.bz2=0;38;2;214;153;29:*.c++=0;38;2;143;170;128:*.cfg=0;38;2;222;165;132:*.cgi=0;38;2;143;170;128:*.clj=0;38;2;143;170;128:*.com=1;38;2;83;101;78:*.cpp=0;38;2;143;170;128:*.css=0;38;2;143;170;128:*.csv=0;38;2;219;188;95:*.csx=0;38;2;143;170;128:*.cxx=0;38;2;143;170;128:*.deb=0;38;2;214;153;29:*.def=0;38;2;143;170;128:*.dll=1;38;2;83;101;78:*.dmg=1;38;2;255;105;97:*.doc=1;38;2;69;133;136:*.dot=0;38;2;143;170;128:*.dox=3;38;2;83;101;78:*.dpr=0;38;2;143;170;128:*.elc=0;38;2;143;170;128:*.elm=0;38;2;143;170;128:*.epp=0;38;2;143;170;128:*.eps=0;38;2;157;186;212:*.erl=0;38;2;143;170;128:*.exe=1;38;2;83;101;78:*.exs=0;38;2;143;170;128:*.fls=3;38;2;150;140;129:*.flv=1;38;2;146;187;223:*.fnt=0;38;2;157;186;212:*.fon=0;38;2;157;186;212:*.fsi=0;38;2;143;170;128:*.fsx=0;38;2;143;170;128:*.gif=0;38;2;157;186;212:*.git=3;38;2;150;140;129:*.gvy=0;38;2;143;170;128:*.h++=0;38;2;143;170;128:*.hpp=0;38;2;143;170;128:*.htc=0;38;2;143;170;128:*.htm=0;38;2;219;188;95:*.hxx=0;38;2;143;170;128:*.ico=0;38;2;157;186;212:*.ics=1;38;2;69;133;136:*.idx=3;38;2;150;140;129:*.ilg=3;38;2;150;140;129:*.img=1;38;2;255;105;97:*.inc=0;38;2;143;170;128:*.ind=3;38;2;150;140;129:*.ini=0;38;2;222;165;132:*.inl=0;38;2;143;170;128:*.ipp=0;38;2;143;170;128:*.iso=1;38;2;255;105;97:*.jar=0;38;2;214;153;29:*.jpg=0;38;2;157;186;212:*.kex=1;38;2;69;133;136:*.kts=0;38;2;143;170;128:*.log=3;38;2;150;140;129:*.ltx=0;38;2;143;170;128:*.lua=0;38;2;143;170;128:*.m3u=0;38;2;157;186;212:*.m4a=0;38;2;157;186;212:*.m4v=1;38;2;146;187;223:*.mid=0;38;2;157;186;212:*.mir=0;38;2;143;170;128:*.mkv=1;38;2;146;187;223:*.mli=0;38;2;143;170;128:*.mov=1;38;2;146;187;223:*.mp3=0;38;2;157;186;212:*.mp4=1;38;2;146;187;223:*.mpg=1;38;2;146;187;223:*.nix=0;38;2;222;165;132:*.odp=1;38;2;69;133;136:*.ods=1;38;2;69;133;136:*.odt=1;38;2;69;133;136:*.ogg=0;38;2;157;186;212:*.org=0;38;2;219;188;95:*.otf=0;38;2;157;186;212:*.out=3;38;2;150;140;129:*.pas=0;38;2;143;170;128:*.pbm=0;38;2;157;186;212:*.pdf=1;38;2;69;133;136:*.pgm=0;38;2;157;186;212:*.php=0;38;2;143;170;128:*.pid=3;38;2;150;140;129:*.pkg=0;38;2;214;153;29:*.png=0;38;2;157;186;212:*.pod=0;38;2;143;170;128:*.ppm=0;38;2;157;186;212:*.pps=1;38;2;69;133;136:*.ppt=1;38;2;69;133;136:*.pro=3;38;2;83;101;78:*.ps1=0;38;2;143;170;128:*.psd=0;38;2;157;186;212:*.pyc=3;38;2;150;140;129:*.pyd=3;38;2;150;140;129:*.pyo=3;38;2;150;140;129:*.rar=0;38;2;214;153;29:*.rpm=0;38;2;214;153;29:*.rst=0;38;2;219;188;95:*.rtf=1;38;2;69;133;136:*.sbt=0;38;2;143;170;128:*.sql=0;38;2;143;170;128:*.sty=3;38;2;150;140;129:*.svg=0;38;2;157;186;212:*.swf=1;38;2;146;187;223:*.swp=3;38;2;150;140;129:*.sxi=1;38;2;69;133;136:*.sxw=1;38;2;69;133;136:*.tar=0;38;2;214;153;29:*.tbz=0;38;2;214;153;29:*.tcl=0;38;2;143;170;128:*.tex=0;38;2;143;170;128:*.tgz=0;38;2;214;153;29:*.tif=0;38;2;157;186;212:*.tml=0;38;2;222;165;132:*.tmp=3;38;2;150;140;129:*.toc=3;38;2;150;140;129:*.tsx=0;38;2;143;170;128:*.ttf=0;38;2;157;186;212:*.txt=0;38;2;199;199;199:*.vcd=1;38;2;255;105;97:*.vim=0;38;2;143;170;128:*.vob=1;38;2;146;187;223:*.wav=0;38;2;157;186;212:*.wma=0;38;2;157;186;212:*.wmv=1;38;2;146;187;223:*.xcf=0;38;2;157;186;212:*.xlr=1;38;2;69;133;136:*.xls=1;38;2;69;133;136:*.xml=0;38;2;219;188;95:*.xmp=0;38;2;222;165;132:*.yml=0;38;2;222;165;132:*.zip=0;38;2;214;153;29:*.zsh=0;38;2;143;170;128:*.zst=0;38;2;214;153;29:*TODO=0;38;2;83;101;78:*hgrc=3;38;2;83;101;78:*.bash=0;38;2;143;170;128:*.conf=0;38;2;222;165;132:*.dart=0;38;2;143;170;128:*.diff=0;38;2;143;170;128:*.docx=1;38;2;69;133;136:*.epub=1;38;2;69;133;136:*.fish=0;38;2;143;170;128:*.flac=0;38;2;157;186;212:*.h264=1;38;2;146;187;223:*.hgrc=3;38;2;83;101;78:*.html=0;38;2;219;188;95:*.java=0;38;2;143;170;128:*.jpeg=0;38;2;157;186;212:*.json=0;38;2;222;165;132:*.less=0;38;2;143;170;128:*.lisp=0;38;2;143;170;128:*.lock=3;38;2;150;140;129:*.make=3;38;2;83;101;78:*.mpeg=1;38;2;146;187;223:*.opus=0;38;2;157;186;212:*.orig=3;38;2;150;140;129:*.pptx=1;38;2;69;133;136:*.psd1=0;38;2;143;170;128:*.psm1=0;38;2;143;170;128:*.purs=0;38;2;143;170;128:*.rlib=3;38;2;150;140;129:*.sass=0;38;2;143;170;128:*.scss=0;38;2;143;170;128:*.tbz2=0;38;2;214;153;29:*.tiff=0;38;2;157;186;212:*.toml=0;38;2;222;165;132:*.webm=1;38;2;146;187;223:*.webp=0;38;2;157;186;212:*.woff=0;38;2;157;186;212:*.xbps=0;38;2;214;153;29:*.xlsx=1;38;2;69;133;136:*.yaml=0;38;2;222;165;132:*.cabal=0;38;2;143;170;128:*.cache=3;38;2;150;140;129:*.class=3;38;2;150;140;129:*.cmake=3;38;2;83;101;78:*.dyn_o=3;38;2;150;140;129:*.ipynb=0;38;2;143;170;128:*.mdown=0;38;2;219;188;95:*.patch=0;38;2;143;170;128:*.scala=0;38;2;143;170;128:*.shtml=0;38;2;219;188;95:*.swift=0;38;2;143;170;128:*.toast=1;38;2;255;105;97:*.xhtml=0;38;2;219;188;95:*README=1;38;2;222;165;132:*passwd=0;38;2;222;165;132:*shadow=0;38;2;222;165;132:*.config=0;38;2;222;165;132:*.dyn_hi=3;38;2;150;140;129:*.flake8=3;38;2;83;101;78:*.gradle=0;38;2;143;170;128:*.groovy=0;38;2;143;170;128:*.ignore=3;38;2;83;101;78:*.matlab=0;38;2;143;170;128:*COPYING=3;38;2;160;160;160:*INSTALL=1;38;2;222;165;132:*LICENSE=3;38;2;160;160;160:*TODO.md=0;38;2;83;101;78:*.desktop=0;38;2;222;165;132:*.gemspec=3;38;2;83;101;78:*Doxyfile=3;38;2;83;101;78:*Makefile=3;38;2;83;101;78:*TODO.txt=0;38;2;83;101;78:*setup.py=3;38;2;83;101;78:*.DS_Store=3;38;2;150;140;129:*.cmake.in=3;38;2;83;101;78:*.fdignore=3;38;2;83;101;78:*.kdevelop=3;38;2;83;101;78:*.markdown=0;38;2;219;188;95:*.rgignore=3;38;2;83;101;78:*COPYRIGHT=3;38;2;160;160;160:*README.md=1;38;2;222;165;132:*configure=3;38;2;83;101;78:*.gitconfig=3;38;2;83;101;78:*.gitignore=3;38;2;83;101;78:*.localized=3;38;2;150;140;129:*.scons_opt=3;38;2;150;140;129:*CODEOWNERS=3;38;2;83;101;78:*Dockerfile=0;38;2;222;165;132:*INSTALL.md=1;38;2;222;165;132:*README.txt=1;38;2;222;165;132:*SConscript=3;38;2;83;101;78:*SConstruct=3;38;2;83;101;78:*.gitmodules=3;38;2;83;101;78:*.synctex.gz=3;38;2;150;140;129:*.travis.yml=0;38;2;69;133;136:*INSTALL.txt=1;38;2;222;165;132:*LICENSE-MIT=3;38;2;160;160;160:*MANIFEST.in=3;38;2;83;101;78:*Makefile.am=3;38;2;83;101;78:*Makefile.in=3;38;2;150;140;129:*.applescript=0;38;2;143;170;128:*.fdb_latexmk=3;38;2;150;140;129:*CONTRIBUTORS=1;38;2;222;165;132:*appveyor.yml=0;38;2;69;133;136:*configure.ac=3;38;2;83;101;78:*.clang-format=3;38;2;83;101;78:*.gitattributes=3;38;2;83;101;78:*.gitlab-ci.yml=0;38;2;69;133;136:*CMakeCache.txt=3;38;2;150;140;129:*CMakeLists.txt=3;38;2;83;101;78:*LICENSE-APACHE=3;38;2;160;160;160:*CONTRIBUTORS.md=1;38;2;222;165;132:*.sconsign.dblite=3;38;2;150;140;129:*CONTRIBUTORS.txt=1;38;2;222;165;132:*requirements.txt=3;38;2;83;101;78:*package-lock.json=3;38;2;150;140;129:*.CFUserTextEncoding=3;38;2;150;140;129'

    # path
    # NOTE: the majority of PATH env vars are set in $HOME/.config/kitty/macos-launch-services-cmdline

    # homebrew
    # eval "$(/opt/homebrew/bin/brew shellenv)" # Add homebrew to path if not set
    # the following are hardcoded results of the above command to improve speed
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    fish_add_path -gP /opt/homebrew/bin /opt/homebrew/sbin
    set -q MANPATH; and set MANPATH[1] ":$(string trim --left --chars=":" $MANPATH[1])"
    ! set -q INFOPATH; and set INFOPATH ''
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

    # eza
    set --export EZA_COLORS 'uu=38;2;167;192;128:gu=38;2;167;192;128:uR=38;2;255;105;97:gR=38;2;255;105;97:un=90:gn=90'


    # go
    set --export GOPATH $HOME/go
    set --export GOARCH arm64
    set --export GOOS darwin

    # sdkman (https://sdkman.io/)
    # additional sdkman config in conf.d/config_sdk.fish
    set --global --export SDKMAN_DIR /opt/homebrew/opt/sdkman-cli/libexec

    # java (managed by sdkman)
    set --global --export JAVA_HOME "$HOMEBREW_PREFIX/opt/sdkman-cli/libexec/candidates/java/current"

    # man
    set --global --export MANPAGER 'nvim +Man!'

    # fzf

    # only needed one time, uncomment on new install
    # mkdir -p '/Users/mike/.local/state/fzf/'


    if test "$TERM" = xterm-kitty
        set --export FZF_DEFAULT_OPTS '--border=thinblock --scrollbar=▊'
    else
        set --export FZF_DEFAULT_OPTS ''
    end

    set --export FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS '--preview-window=60%,border-thinblock --margin 1,4 --multi --layout=reverse --scroll-off=7 --height=100% --bind "alt-a:toggle-all" --history '$HOME/.local/state/fzf/history.txt' --history-size=100000 --cycle --info=inline-right --ellipsis=… --separator=─ --pointer=󰅂 --no-separator --marker=﹢ --prompt="$ "'

    # generate colors with $HOME/gitrepos/gruvsquirrel.nvim/extra/fzf/gruvsquirrel.sh
    set gruvsquirrel_fzf_colors 'spinner:#8faa80:bold,fg:#c7c7c7,pointer:#ff6961:bold,preview-label:#504945:bold,hl+:#dbbc5f:bold:reverse,label:#504945:reverse:bold,bg+:#32302f,fg+:#a0a0a0:bold,info:#8faa80,query:#c7c7c7:bold,preview-bg:#070707,separator:#504945,disabled:#968c81:regular,border:#504945,prompt:#83a598,bg:#1a1a1a,hl:#a9d5c4:bold:reverse,gutter:#1a1a1a,marker:#d3869b:bold,preview-fg:#c7c7c7,scrollbar:#504945,header:#968c81'
    if test "$TERM_PROGRAM" != Apple_Terminal
        set --export FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS "--color='$gruvsquirrel_fzf_colors'"
    end

    # TODO: revisit the defaults
    set fzf_fd_opts --strip-cwd-prefix --hidden --no-ignore

    # fzf.fish

    # see https://github.com/PatrickF1/fzf.fish/discussions/303
    set fzf_directory_opts --prompt="󰥨 " \
        "--bind=ctrl-d:reload(fd --type d --type l --color=always --strip-cwd-prefix --hidden --no-ignore)" \
        "--bind=ctrl-f:reload(fd --color=always --strip-cwd-prefix --hidden --no-ignore)"

    set --export fzf_history_opts --prompt=" " --preview-window=bottom:40%,border-thinblock


    # dynamic libary lookup fallback currently used by image.nvim
    set --export --global DYLD_FALLBACK_LIBRARY_PATH /opt/homebrew/lib

    starship init fish | source
end
