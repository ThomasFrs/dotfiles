#!/bin/bash
# Config file to run to install libraries, packages and pretty much configure anything for a new quick session on Ubuntu 20.04LTS

# colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[1;32m'
NC='\033[0m'

# update packages
Update()
{
    message "information" "Updating"
    apt-get update
    menu
}

# upgrade packages
Upgrade()
{
    message "information" "Upgrading"
    apt-get upgrade
    menu
}

# config file path
default_path=$(eval "pwd")
cd ~
config_path=~/OneDrive/personnel/software/linux/dotfiles

# replace config files with those in config folder
UpdateConfig()
{
    message "information" "Updating config files"
    message "information" "Updating ~/.config/i3/config"
    cp -rf ${config_path}/i3rc ~/.config/i3/config
    message "information" "Updating ~/.config/betterlockscreen/betterlockscreenrc"
    cp -rf ${config_path}/betterlockscreenrc ~/.config/betterlockscreen/betterlockscreenrc
    message "information" "Updating ~/.vimrc"
    cp -rf ${config_path}/.vimrc ~/.vimrc
    message "information" "Updating ~/.zshrc"
    cp -rf ${config_path}/.zshrc ~/.zshrc
    message "information" "Updating ~/.moc/config"
    cp -rf ${config_path}/mocrc ~/.moc/config
    message "information" "Updating ~/.moc/keymap.example"
    cp -rf ${config_path}/mockeymap.example ~/.moc/keymap.example
    message "information" "Updating ~/.config/ranger/rc.conf"
    cp -rf ${config_path}/rc.conf ~/.config/ranger/rc.conf
    message "information" "Updating ~/.gitconfig"
    cp -rf ${config_path}/.gitconfig ~/.gitconfig
    message "information" "Updating ~/.config/i3/bumblebee-status/themes/modded-onedark-powerline.json"
    cp -rf ${config_path}/modded-onedark-powerline.json ~/.config/i3/bumblebee-status/themes/modded-onedark-powerline.json
    menu
}

# replace files in the config folder with normals
FetchConfig()
{
    message "information" "Fetching config files"
    message "information" "Fetching ~/.config/i3/config"
    cp -rf ~/.config/i3/config ${config_path}/i3rc
    message "information" "Fetching ~/.config/betterlockscreen/betterlockscreenrc"
    cp -rf ~/.config/betterlockscreen/betterlockscreenrc ${config_path}/betterlockscreenrc 
    message "information" "Fetching ~/.vimrc"
    cp -rf ~/.vimrc ${config_path}/.vimrc 
    message "information" "Fetching ~/.zshrc"
    cp -rf ~/.zshrc ${config_path}/.zshrc 
    message "information" "Fetching ~/.moc/config"
    cp -rf ~/.moc/config ${config_path}/mocrc 
    message "information" "Fetching ~/.moc/keymap.example"
    cp -rf ~/.moc/keymap.example ${config_path}/mockeymap.example 
    message "information" "Fetching ~/.config/ranger/rc.conf"
    cp -rf ~/.config/ranger/rc.conf ${config_path}/rc.conf 
    message "information" "Fetching ~/.gitconfig"
    cp -rf ~/.gitconfig ${config_path}/.gitconfig 
    message "information" "Fetching ~/.config/i3/bumblebee-status/themes/modded-onedark-powerline.json"
    cp -rf ~/.config/i3/bumblebee-status/themes/modded-onedark-powerline.json ${config_path}/modded-onedark-powerline.json 
    menu
}

# fonts
InstallFonts()
{
    message "information" "Installing Font-Awesome"
    git clone https://github.com/FortAwesome/Font-Awesome.git
    mkdir ~/.fonts/
    #mv ~/Font-Awesome/webfonts/*.ttf ~/.fonts
    mv Font-Awesome/js-packages/@fortawesome/fontawesome-free/webfonts/*.ttf ~/.fonts
    message "information" "Installing Fonts-Powerline"
    apt-get install powerline fonts-powerline # installs powerline fonts
    menu
}

# packages
Packages()
{
    options=("OneDrive" "i3" "Vim" "ZShell" "Shutter" "Ranger" "Mocp" "Git" "cUrl" "Flatpak" "Viu" "CBonsai" "TLP-Powertop")
    menu
}

## onedrive
OneDrive()
{
    message "information" "Removing configured PPA associated with older onedrive package"
    apt remove onedrive
    add-apt-repository --remove ppa:yann1ck/onedrive
    message "information" "Adding the OpenSuSE Build Service repository release key"
    wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_20.04/Release.key | sudo apt-key add -
    message "information" "Add the OpenSuSE Build Service repository"
    echo 'deb https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_20.04/ ./' | sudo tee /etc/apt/sources.list.d/onedrive.list
    message "information" "Updating"
    apt-get update
    message "information" "Installing onedrive"
    apt install --no-install-recommends --no-install-suggests onedrive
    menu
}

## onedriver
OneDriver()
{
    message "information" "Installing curl"
    apt-get install curl
    echo 'deb http://download.opensuse.org/repositories/home:/jstaf/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:jstaf.list
    curl -fsSL https://download.opensuse.org/repositories/home:jstaf/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_jstaf.gpg > /dev/null
    message "information" "Updating"
    apt update
    message "information" "Installing Onedriver"
    apt install onedriver
    menu
}

## i3
i3()
{
    message "information" "Installing i3"
    apt-get install i3
    message "information" "Installing lm-sensors"
    apt-get install lm-sensors
    message "information" "Installing compton"
    apt-get install compton
    message "information" "Installing bumblebee-status"
    git clone https://github.com/tobi-wan-kenobi/bumblebee-status ~/.config/i3/

    options=("i3Blocks" "i3BetterLockScreen" "i3Gaps")
    menu
}

### i3 blocks & font installation
i3Blocks()
{
    message "information" "Installing i3Blocks"
    apt-get install i3blocks
    menu
}

### betterlockscreen
i3BetterLockScreen()
{
    #### i3 lock color
    message "information" "Installing x11-utils"
    apt-get install x11-utils
    message "information" "Installing i3lock-color"
    apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
    git clone https://github.com/Raymo111/i3lock-color.git
    message "information" "Building i3lock-color"
    i3lock-color/./install-i3lock-color.sh

    message "information" "Installing betterlockscreen"
    # you might need to download manually imagemagick mapimage https://imagemagick.org/script/download.php
    wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
    unzip main.zip

    chmod u+x betterlockscreen-main/betterlockscreen
    cp betterlockscreen-main/betterlockscreen /usr/local/bin/
    mkdir -p ~/.config/betterlockscreen/
    menu
}

i3Gaps()
{
    message "information" "Installing i3-gaps"
    add-apt-repository ppa:regolith-linux/release
    apt update
    apt install i3-gaps
    menu
}

## vim and vimwiki
Vim()
{
    message "information" "Installing vim"
    apt-get install vim
    message "information" "Installing vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir ~/.vim/
    mkdir ~/.vim/colors/ # put your custom themes there
    # run :PlugInstall inside of Vim
    menu
}

## ZShell
ZShell()
{
    message "information" "Installing zsh"
    apt-get install zsh
    message "information" "Installing oh-my-zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh # clones oh-my-zsh repo
    chsh -s /bin/zsh # changes default shell (needs restart)
    # MesloLGS NF Regular in GNOME shell font and disable scrollbar + titlebar in new window or smth

    options=("ZShell_plugins" "ZShell_powerlevel10k")
    menu
}

### plugins
ZShell_plugins()
{
    message "information" "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # auto suggestions
    message "information" "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    menu
}

### powerlevel10k installation & configuration
ZShell_powerlevel10k()
{
    message "information" "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    menu
}

## shutter
Shutter()
{
    message "information" "Installing shutter"
    add-apt-repository ppa:shutter/ppa && sudo apt-get update && sudo apt install shutter
    menu
}

Ranger()
{
    message "information" "Installing ranger"
    apt-get install ranger
    menu
}

Moc()
{
    message "information" "Installing moc"
    apt-get install moc
    menu
}

Git()
{
    message "information" "Installing git"
    apt-get install git
    menu
}

cUrl()
{
    message "information" "Installing curl"
    apt-get install curl
    menu
}

Flatpak()
{
    message "information" "Installing flatpak"
    sudo apt install flatpak
    sudo apt install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    menu
}

Viu()
{
    message "information" "Installing cargo"
    apt-get install cargo
    message "information" "Installing viu"
    cargo install viu
    menu
}

CBonsai()
{
    message "information" "Updating"
    apt update
    message "information" "Installing cbonsai"
    apt install build-essential git pkgconf
    apt install libncurses6 libncurses-dev ncurses-base ncurses-bin
    git clone https://gitlab.com/jallbrit/cbonsai
    cd cbonsai
    make install PREFIX=~/.local
    cd
    menu
}

TLP-Powertop()
{
    # reduces battery usage
    # tlp-stat to check it
    message "information" "Installing TLP"
    apt-get install tlp tlp-rdw
    systemctl enable tlp
    message "information" "Disabling screensavers"
    echo "xset s off" >> $HOME/.xsession
    message "information" "Installing powertop"
    apt install powertop
    home
}

# main
## message
message()
{
    if [ "$1" == "title" ]; then
        echo -e "${GREEN}$2${NC}"
    elif [ "$1" == "information" ]; then
        echo -e "${BLUE}$2...${NC}"
    elif [ "$1" == "warning" ]; then
        echo -e "${RED}$2...${NC}"
    fi
}

## menu
menu()
{
    message "title" "INSTALLATION MENU" 
    select opt in "Home" "${options[@]}" "Quit"
    do
        case "$REPLY" in
            1) options=("Update" "Upgrade" "UpdateConfig" "FetchConfig" "InstallFonts" "Packages"); menu;;
            [1-$((${#options[@]}+1))])
                choice=$(expr $REPLY-2);
                ${options[$choice]};;
            $((${#options[@]}+2))) message "warning" "Quitting"; cd "$default_path"; exit 0;;
            *) echo "Invalid option $REPLY"; continue;;
        esac
    done
}

options=("Update" "Upgrade" "UpdateConfig" "FetchConfig" "InstallFonts" "Packages")
menu
