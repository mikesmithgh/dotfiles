#!/bin/bash
git config --global user.name "$1"
git config --global user.email "$2"
git config --global core.excludesfile ~/.gitignore
git config --global core.autocrlf true
git config --global push.default current
git config --global diff.tool vimdiff 
git config --global merge.tool vimdiff 
git config --global difftool.prompt false 
git config --global mergetool.prompt false
git config --global log.date 'format:%m/%d/%Y %I:%M %p'
git config --global color.status.untracked magenta 
git config --global pretty.quick '%C(#5896A3 bold)%h %C(cyan nobold)%ad %C(#D8CB91)%an %C(#856A85)%s'
git config --global pretty.quicktabular '%C(#5896A3 bold)%<(8)%h %C(cyan nobold)%<(20)%ad %C(#D8CB91)%<(19)%an %C(#856A85)%s'
git config --global pretty.moretabular '%C(#CD8931 nobold)Commit: %C(#5896A3 bold)%H%n%C(#CD8931 nobold)Parent: %C(#5896A3 bold)%p%n%C(#D8CB91 bold)Author: %C(nobold)%an %C(#9FCB91)<%ae>%n%C(#D8CB91 bold)Date:   %C(cyan nobold)%ad%n%n%C(#856A85)%w(100,4,4)%s%n%n%C(reset)%w(100,4,4)%b'
git config --global alias.alias '! git config --get-regexp ^alias\\. | sed -e s/^alias\\.// -e s/\\ /\\?/ | grep -v alias| column -t -s"?"'
git config --global alias.br branch
git config --global alias.cbr 'symbolic-ref --short HEAD'
git config --global alias.ci commit
git config --global alias.cl '! git --no-pager log'
git config --global alias.co checkout
git config --global alias.dt difftool
git config --global alias.f fetch
git config --global alias.graph 'log --graph --format=quick'
git config --global alias.l '! git --no-pager lv --max-count=10'
git config --global alias.ll '! git --no-pager llv --max-count=2'
git config --global alias.llv 'log --format=moretabular'
git config --global alias.lv 'log --format=quicktabular'
git config --global alias.ml '! git l --author="$(git config --get user.name)"'
git config --global alias.mll '! git ll --author="$(git config --get user.name)"'
git config --global alias.mllv '! git llv --author="$(git config --get user.name)"'
git config --global alias.mlv '! git lv --author="$(git config --get user.name)"'
git config --global alias.mrb '! git rb | grep "$(git config --get user.name)"' 
git config --global alias.mt mergetool
git config --global alias.p pull
git config --global alias.rb '! git for-each-ref --format="%(color:cyan)%(authordate:format:\"%m/%d/%Y %I:%M %p\")    %(align:25,left)%(color:yellow)%(authorname)%(end) %(color:reset)%(refname:strip=3)" --sort=authordate refs/remotes'
git config --global alias.st status