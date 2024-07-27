#!/bin/bash

# Créer la structure des répertoires
mkdir -p /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
mkdir -p /etc/skel/.config/xfce4-session
mkdir -p /etc/skel/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Video}

# Créer les fichiers avec le contenu spécifié
cat << 'EOF' > /etc/skel/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Alias definitions.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# User specific environment and startup programs
export PATH=$HOME/bin:$PATH
EOF

cat << 'EOF' > /etc/skel/.profile
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples.

# the default umask is set in /etc/profile
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
EOF

cat << 'EOF' > /etc/skel/.bash_profile
# ~/.bash_profile: executed by the command interpreter for login shells.
# This file is read by bash(1) when invoked as an interactive login shell.

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin directories
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
EOF

cat << 'EOF' > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-panel" version="1.0">
  <property name="panels" type="array">
    <value type="string" value="1"/>
  </property>
  <property name="panel-1" type="empty">
    <property name="position" type="string" value="p=6;x=0;y=0"/>
    <property name="size" type="int" value="24"/>
    <property name="length" type="int" value="100"/>
  </property>
</channel>
EOF

cat << 'EOF' > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-session" version="1.0">
  <property name="general" type="empty">
    <property name="SaveOnExit" type="bool" value="true"/>
    <property name="PromptOnLogout" type="bool" value="false"/>
  </property>
</channel>
EOF

cat << 'EOF' > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-desktop" version="1.0">
  <property name="desktop-icons" type="empty">
    <property name="icon-size" type="int" value="48"/>
    <property name="show-trash" type="bool" value="true"/>
    <property name="show-home" type="bool" value="true"/>
  </property>
</channel>
EOF

cat << 'EOF' > /etc/skel/.config/xfce4-session/session
[Session: Default]
Client0_Command=xfwm4
Client0_RestartCommand=xfwm4 --replace
Client1_Command=xfce4-panel
Client1_RestartCommand=xfce4-panel --restart
Client2_Command=Thunar --daemon
Client2_RestartCommand=Thunar --daemon
EOF
