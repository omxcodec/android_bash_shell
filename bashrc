# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
busybox resize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

use_color=true

# set some environment variables
HOME=/
TERM=linux

# enable colorful terminal
if [[ ${EUID} == 0 ]] ; then
	PS1="gn@dev:\w# "
else
	PS1="gn@dev:\w$ "
fi

# Set up a ton of aliases to cover toolbox with the nice busybox
# equivalents of its commands
#for i in cat chmod chown df insmod ln lsmod mkdir mount mv rm rmdir rmmod umount; do
#	eval alias ${i}=\"busybox ${i}\"
#done

for i in echo $(busybox --list); do
	eval alias ${i}=\"busybox ${i}\"
done

unset i
alias ls='busybox ls --color=auto'
alias sysro='mount -o remount,ro /system'
alias sysrw='mount -o remount,rw /system'

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

