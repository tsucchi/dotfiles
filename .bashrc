export EDITOR=vi
export IGNOREEOF=65536

if [ "`whoami`" = "root" ] ; then
  export PS1="[\w]\n\[\033[0;31m\]\u@\h[\!]#\[\033[0m\] "
  PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
else
  export PS1="[\w]\n\[\033[0;32m\]\u@\h[\!]$\[\033[0m\] "
  PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
fi

export LS_COLORS="di=0;36:ex=0;31:ln=0;35:cd=0;43;34:so=0;32"

case "${OSTYPE}" in
  darwin*)
    alias ls="ls -F -G"
  ;;
  linux*)
    alias ls='ls -F --color=auto'
  ;;
esac

alias la='ls -A'
alias ll='ls -lhA'
alias s='source ~/.bashrc'
alias ..='cd ..'
alias su='su -m'
alias emacs='env XMODIFIERS=@im=none emacs'
alias rmchi='rm -f *~ .*~'
alias less='less -X'

if [ -e "$HOME/perl5/perlbrew/etc/bashrc" ] ; then
  source $HOME/perl5/perlbrew/etc/bashrc
fi

if [ -d $HOME/.rbenv ] ; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi
