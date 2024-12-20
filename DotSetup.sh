#!/bin/bash -
#===============================================================================
#
#          FILE: DotSetup.sh
#
#         USAGE: ./DotSetup.sh
#
#        AUTHOR: 
#  ORGANIZATION:
#       CREATED: Wed 13 Oct 2021 09:37:45 AM MDT
#      REVISION:  ---
#===============================================================================

DOTFILES="$HOME/dot-files"
ts=`date +%y-%m-%d-%H-%M` # timestamp
backups="$DOTFILES/backups"

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  printLine
#   DESCRIPTION:  prints a line
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
printLine() {
    numLine=64
    while [ $numLine -gt 1 ]
    do
        printf "*"
        (( numLine-- ))
    done
    printf '\n'
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  help
#   DESCRIPTION:  prints the help menu then exits
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
help()
{
printLine
# each of the following strings cannot be longer than 60 char
strings=("Welcome to the help menu!"
"Usage: ./DotSetup.sh"
"this script installs the config files"
"for vim, nvim, bash, zshell, git, tmux"
"and creates a local bin folder"
"run as sudo to install all programs"
"Thank you for choosing my Script")
printf "* %-60s *\n" "${strings[@]}"
printLine
exit 0
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  installPackages
#   DESCRIPTION: Install all required packages using apt, brew, or pacman
#    PARAMETERS:  None
#       RETURNS:  0 on success, 1 if error
#-------------------------------------------------------------------------------
installPackages()
{
    # Detect package manager
    if command -v brew >/dev/null 2>&1; then
        echo "Using Homebrew package manager"
        
        # Install Homebrew if not installed
        if ! command -v brew >/dev/null 2>&1; then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        # Install packages with brew
        brew install \
            make \
            gcc \
            ripgrep \
            git \
            neovim \
            zsh \
            gh

    elif command -v pacman >/dev/null 2>&1; then
        echo "Using pacman package manager"
        
        if [ `id -u` -ne 0 ]; then
            echo "You must run with sudo privileges to install packages on Arch"
            return 1
        fi

        # Install packages with pacman
        sudo pacman -Syu --noconfirm
        sudo pacman -S --needed --noconfirm \
            base-devel \
            ripgrep \
            git \
            xclip \
            neovim \
            zsh \
            github-cli
        
    elif command -v apt >/dev/null 2>&1; then
        echo "Using apt package manager"
        
        if [ `id -u` -ne 0 ]; then
            echo "You must run with sudo privileges to install packages on Ubuntu/Debian"
            return 1
        fi

        # Add neovim repository
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        
        # Add github cli repository
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        
        sudo apt update
        
        # Install packages with apt
        sudo apt install -y \
            make \
            gcc \
            ripgrep \
            unzip \
            git \
            xclip \
            neovim \
            zsh \
            gh
    else
        echo "No supported package manager found (brew, pacman, or apt)"
        return 1
    fi
}
#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  VimSetup
#   DESCRIPTION: Setup Vim Configuration 
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
VimSetup()
{
    echo "$BOLD$RED$0 Starting vim setup$RESET"
    if [ -e "$HOME/.vimrc" ] || [ -L "$HOME/.vimrc" ]
    then
        echo ".vimrc exists. Creating a backup and deleting."
        cp $HOME/.vimrc $backups/.vimrc
        rm $HOME/.vimrc
    fi

    echo "creating new .vimrc file"
    ln -s $DOTFILES/vim/.vimrc $HOME/.vimrc

    if [ -e "$HOME/.vim" ] || [ -L "$HOME/.vim" ]
    then
        echo ".vim exists. Creating a backup and deleting."
        cp -r $HOME/.vim $backups/.vim
        rm -rf $HOME/.vim
    fi

    echo "creating new .vim folder"
    ln -s $DOTFILES/vim/vim $HOME/.vim
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  NeoVimSetup
#   DESCRIPTION: Setup NeoVim Configuration 
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
NeoVimSetup()
{

    echo "$BOLD$RED$0 Starting neovim setup$RESET"

    # ill just keep my nvim config over there
    # TODO: make backup
    rm -r "$HOME/.config/nvim"
    git clone https://github.com/Shhwip/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  userBinSetup
#   DESCRIPTION: Setup userBin Configuration 
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
userBinSetup()
{
    echo "$BOLD$RED$0 Starting local bin setup$RESET"
    
    if [ -d "$HOME/bin" ] || [ -L "$HOME/bin" ]
    then
        echo "$HOME/bin exists"
        echo "making backup and deleting"
        cp -r $HOME/bin $backups/bin
        rm -r $HOME/bin
    fi

    echo "linking bin folder to user bin folder"
    ln -s $DOTFILES/bin $HOME/bin
}
#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  bashrcSetup
#   DESCRIPTION: Setup bash Configuration 
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
bashrcSetup()
{
    printf "\n"
    echo "$BOLD$RED$0 Starting bash setup$RESET"
    
    echo "Checking if .bashrc exists"
    if [ -e "$HOME/.bashrc" ] || [ -L "$HOME/.bashrc" ]
    then
        echo ".bashrc exists. Creating a backup and deleting."
        cp $HOME/.bashrc $backups/.bashrc
        rm $HOME/.bashrc
    fi
    
    if [ -e "$HOME/.bash_aliases" ] || [ -L "$HOME/.bash_aliases" ]
    then
        echo ".bash_aliases exists. Creating a backup and deleting."
        cp $HOME/.bash_aliases $backups/.bash_aliases
        rm $HOME/.bash_aliases
    fi
    ln -s $DOTFILES/bashrc/.bashrc $HOME/.bashrc
    ln -s $DOTFILES/bashrc/.bash_aliases $HOME/.bash_aliases
    source $HOME/.bashrc
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  zshrcSetup
#   DESCRIPTION: Setup zshell Configuration 
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
zshrcSetup()
{
    echo "$BOLD$RED$0 Starting zsh setup$RESET"
    echo "checking if zsh is installed"

    if [ -L "$HOME/.zshrc" ] || [ -e "$HOME/.zshrc" ]
    then
        echo ".zshrc exists. Creating a backup and deleting."
        cp $HOME/.zshrc $backups/.zshrc
        rm $HOME/.zshrc
    fi

    echo "creating new .zshrc file"
    ln -s $DOTFILES/zshrc/.zshrc $HOME/.zshrc
    
    if [ -d "$HOME/.oh-my-zsh" ]
    then
        echo "oh my zsh is already installed"
    else
        echo "installing oh my zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]
    then
        echo "powerlevel10k is already installed"
        echo "backing up p10k.zsh config and deleting"
        cp $HOME/.p10k.zsh $backups/.p10k.zsh
        rm $HOME/.p10k.zsh
    else
        echo "installing powerlevel10k"
        git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    fi

    while true; do
        read -p "do you want to configure p10K now? (y/n) " yn
        case "${yn:0:1}" in
            y|Y ) p10k configure; break;;
            n|N ) echo "Using saved p10k config"
                ln -s $DOTFILES/zshrc/.p10k.zsh $HOME/.p10k.zsh
                break;;
            * ) echo "Please answer y or n";;
        esac
    done

    echo "installing zshell plugins"
    echo "installing syntax highlighting"
    
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
    then
        echo "syntax highlighting is already installed"
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi

    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
    then
        echo "auto suggestions is already installed"
    else
        echo "installing auto suggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
}

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  gitSetup
#   DESCRIPTION: Setup git Configuration 
#    PARAMETERS:  None
#       RETURNS:  None
#-------------------------------------------------------------------------------
gitSetup()
{
    echo "$BOLD$RED$0 Starting git setup$RESET"
    
    if [ -e "$HOME/.gitconfig" ] || [ -L "$HOME/.gitconfig" ]
    then
        echo ".gitconfig exists. Creating a backup and deleting."
        cp -s $HOME/.gitconfig $backups/.gitconfig
        rm $HOME/.gitconfig
    fi
    ln -s $DOTFILES/git/.gitconfig $HOME/.gitconfig
}
#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  main
#   DESCRIPTION:  This is the main driver function.
#    PARAMETERS:  Optional parameters: --help
#       RETURNS:  Success or Error
#-------------------------------------------------------------------------------
main ()
{
    # Load some nice colors
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    RESET="$(tput sgr0)"

    echo "Welcome $USER to my $BOLD$GREEN$0$RESET script."
    
    if [[ $1 == "--help" ]]
    then
        help
    fi
    installPackages
    VimSetup
    bashrcSetup
    userBinSetup
    zshrcSetup
    NeoVimSetup
}	# ----------  end of function main  ----------

# Main Program
main $1
exit 0
