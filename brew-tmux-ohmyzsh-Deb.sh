# ============================
# Install BREW and LinuxBrew
# ============================

sudo apt-get update -y
sudo apt-get upgrade -y
sudo sudo apt-get install -y build-essential make cmake scons curl git \
                               ruby autoconf automake autoconf-archive \
                               gettext libtool flex bison \
                               libbz2-dev libcurl4-openssl-dev \
                               libexpat-dev libncurses-dev
# Clone LinuxBrew
git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew

# Append to the END to ~./bashrc
# Until LinuxBrew is fixed, the following is required.
# See: https://github.com/Homebrew/linuxbrew/issues/47
echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc

## Setup linux brew
echo "export LINUXBREWHOME=$HOME/.linuxbrew" >> ~/.bashrc
echo "export PATH=$LINUXBREWHOME/bin:$PATH" >> ~/.bashrc
echo "export MANPATH=$LINUXBREWHOME/man:$MANPATH" >> ~/.bashrc
echo "export PKG_CONFIG_PATH=$LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH" >> ~/.bashrc

# ================================
# Install TMUX
# ===============================
# install deps
sudo apt install -y automake build-essential pkg-config libevent-dev libncurses5-dev

# Clone, make, yay!
rm -fr /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
sh autogen.sh
./configure && make
sudo make install
cd -
rm -fr /tmp/tmux

# ===============================
# Install ZSH
# ===============================
apt-get install -y zsh
apt-get install -y git-core

# ===============================
# Install Oh-My-ZSH
# ===============================
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`
# Restart the shell since Ubuntu don't know about source' cmd
sudo shutdown -r 0


# ===============================
# Now push LinuxBrew vars to ~/.zshrc
echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc
echo "export LINUXBREWHOME=$HOME/.linuxbrew" >> ~/.bashrc
echo "export PATH=$LINUXBREWHOME/bin:$PATH" >> ~/.bashrc
echo "export MANPATH=$LINUXBREWHOME/man:$MANPATH" >> ~/.bashrc
echo "export PKG_CONFIG_PATH=$LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
# ===============================
