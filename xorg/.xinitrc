#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Load global xinitrc files
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start redshift configured for Craiova
gtk-redshift -l 44.323848:23.811951 &

# Necessary for audio to work
ck-launch-session --sh-syntax --exit-with-session

# .Xresources
if [ -f $HOME/.Xresources ]; then
  xrdb -merge $HOME/.Xresources
fi

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export GPG_AGENT_INFO SSH_AUTH_SOCK

# map caps lock to l-control and compose stuff
setxkbmap -option ctrl:nocaps,compose:ralt

# pointer
xset m 10 4

# Start i3
exec i3
