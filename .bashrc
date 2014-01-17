export EDITOR=vi
export IGNOREEOF=65536

if [ -e /etc/bash_completion.d/git ] ; then
    source /etc/bash_completion.d/git
fi

if [ "`whoami`" = "root" ] ; then
  export PS1="[\w]\n\[\033[0;31m\]\u@\h[\!]#\[\033[0m\] "
  PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
else
  if [ -e /etc/bash_completion.d/git ] ; then
    export PS1="[\w] \$(__git_ps1 '\[\033[1;34m\](%s)\[\033[0m\]')\n\[\033[0;32m\]\u@\h[\!]$\[\033[0m\] "
  else
    export PS1="[\w]\n\[\033[0;32m\]\u@\h[\!]$\[\033[0m\] "
  fi
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
alias cprove='cover --delete; env PERL5OPT="-MDevel::Cover=+ignore,.*,+select,^lib" prove -l'

if [ -e "$HOME/perl5/perlbrew/etc/bashrc" ] ; then
  source $HOME/perl5/perlbrew/etc/bashrc
fi

if [ -e "$HOME/.bashrc_hostlocal" ] ; then
  source $HOME/.bashrc_hostlocal
fi

if [ -d $HOME/.rbenv ] ; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

