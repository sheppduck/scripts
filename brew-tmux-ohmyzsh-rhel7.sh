# ============================
# Install BREW and LinuxBrew
# ============================
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile
sudo yum groupinstall -y 'Development Tools' && sudo yum install -y curl file git

# Now install LinuxBrew
sudo yum update -y
sudo yum groupinstall -y "Development Tools"
sudo yum install -y \
        autoconf automake19 libtool gettext \
        git scons cmake flex bison \
        libcurl-devel curl \
        ncurses-devel ruby bzip2-devel expat-devel

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
sudo yum install -y gcc kernel-devel make ncurses-devel

# DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
curl -OL https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
tar -xvzf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure --prefix=/usr/local
make
sudo make install
cd ..

# DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL
curl -OL https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
tar -xvzf tmux-2.3.tar.gz
cd tmux-2.3
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install
cd ..

# ===============================
# Install ZSH
# ===============================
sudo yum install zsh -y

# ===============================
# Install Oh-My-ZSH
# ===============================
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ===============================
# Now push LinuxBrew vars to ~/.zshrc
echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc
echo "export LINUXBREWHOME=$HOME/.linuxbrew" >> ~/.bashrc
echo "export PATH=$LINUXBREWHOME/bin:$PATH" >> ~/.bashrc
echo "export MANPATH=$LINUXBREWHOME/man:$MANPATH" >> ~/.bashrc
echo "export PKG_CONFIG_PATH=$LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
# ===============================
