BORDERLINE_NVIM='nvim-borderline' # change this if you would like to test independently of your main Neovim configuration, e.g., borderline-nvim
config_dir="$(NVIM_APPNAME="$BORDERLINE_NVIM" nvim --headless +"=vim.fn.stdpath('config')" +quit 2>&1)"
share_dir="$(NVIM_APPNAME="$BORDERLINE_NVIM" nvim --headless +"=vim.fn.stdpath('data')" +quit 2>&1)"
mkdir -p "$share_dir/site/pack/mikesmithgh/start/"
mkdir -p "$config_dir"
cd "$share_dir/site/pack/mikesmithgh/start" || exit 1
git clone git@github.com:mikesmithgh/borderline.nvim.git 2>/dev/null
NVIM_APPNAME="$BORDERLINE_NVIM" nvim -u NONE +"helptags borderline.nvim/doc" +quit
rm -f "$config_dir/init.lua" 
touch "$config_dir/init.lua" 
echo "require('borderline').setup()" >> "$config_dir/init.lua" 
echo "require('gruvsquirrel').setup()" >> "$config_dir/init.lua" 
NVIM_APPNAME="$BORDERLINE_NVIM" nvim

