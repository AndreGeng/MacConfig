rm -rf ~/.hammerspoon
rm -rf ~/config/karabiner
rm -f ~/.zshrc
rm -f ~/.tmux.conf
rm -rf ~/.config/nvim
rm -rf ~/.config/alacritty
cp -R ./.hammerspoon ~
cp -R ./karabiner ~/.config
cp -R ./.zshrc ~
cp -R ./nvim ~/.config
cp -R ./alacritty ~/.config
cp -R ./.tmux.config ~
