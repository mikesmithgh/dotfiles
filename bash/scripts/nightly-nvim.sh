set -ex
cd ~/gitrepos/neovim || exit 1
git pull
make distclean 
make CMAKE_BUILD_TYPE=RelWithDebInfo
nvim -c ":helptags ALL" -c "quit"
