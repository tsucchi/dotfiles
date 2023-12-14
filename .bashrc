hash code 2> /dev/null
if [ $? -eq 0 ] ; then
  export EDITOR='code --wait'
else
  export EDITOR='vi'
fi

export IGNOREEOF=65536
export PAGER='less -X -R'
export LESSCHARSET=utf-8
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=C

export RAKUDOBREW_ROOT="${HOME}/.rakudobrew"
export PYENV_ROOT="${HOME}/.pyenv"

stty stop undef

if [ -e $HOME/.git_completion ] ; then
  source $HOME/.git_completion
fi

if [ -e $HOME/.minio_completion ] ; then
  source $HOME/.minio_completion
fi

__ruby_ps1 ()
{
  if [ -e "$HOME/.rbenv" ] ; then
    rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
    if [ "$rbenv_ruby_version" = "" ] ; then
      printf ""
    elif [ "$rbenv_ruby_version" = "system" ] ; then
      printf "[system-ruby]"
    else
      printf "[ruby-$rbenv_ruby_version]"
    fi
  else
    printf ""
  fi
}

__perl_ps1 ()
{
  if [ -e "$HOME/.perlbrew" ] ; then
    perlbrew_perl_version=`perlbrew list | grep '*' | sed 's/\* //'`
    if [ "$perlbrew_perl_version" = "" ] ; then
      printf "[system-perl]"
    else
      printf "[$perlbrew_perl_version]"
    fi
  else
    printf ""
  fi
}

__p6_ps1 ()
{
  if [ -d $RAKUDOBREW_ROOT ] ; then
    rakudobrew_rakudo_version=`rakudobrew list | grep '*' | sed 's/\* //'`
    if [ "$rakudobrew_rakudo_version" = "" ] ; then
      printf ""
    else
      printf "[p6-$rakudobrew_rakudo_version]"
    fi
  else
    printf ""
  fi
}


__python_ps1 ()
{
  if [ -e "$HOME/.pyenv" ] ; then
    pyenv_python_version=`pyenv version | sed -e 's/ .*//'`
    if [ "$pyenv_python_version" = "" ] ; then
      printf ""
    elif [ "$pyenv_python_version" = "system" ] ; then
      printf "[system-python]"
    else
      printf "[python-$pyenv_python_version]"
    fi
  else
    printf ""
  fi
}

__nodenv_ps1 ()
{
  if [ -e "$HOME/.nodenv" ] ; then
    version=`nodenv version | sed -e 's/ .*//'`
    if [ "$version" = "" ] ; then
      printf ""
    elif [ "$version" = "system" ] ; then
      printf "[system-node]"
    else
      printf "[node-$version]"
    fi
  else
    printf ""
  fi
}

__screen_window ()
{
    if [ -n "$WINDOW" ] ; then
        printf "$WINDOW:"
    else
        printf ""
    fi
}

if [ "`whoami`" = "root" ] ; then
  export PS1="[\w]\n\[\033[0;31m\]\u@\h[\$(__screen_window)\!]#\[\033[0m\] "
  PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
else
  if [ -e $HOME/.git_completion ] ; then
    export PS1="[\w]\[\033[1;34m\]\$(__git_ps1)\[\033[0m\]\[\033[1;34m\]\$(__perl_ps1)\$(__ruby_ps1)\$(__nodenv_ps1)\$(__python_ps1)\$(__p6_ps1)\[\033[0m\]\n\[\033[0;32m\]\u@\h[\$(__screen_window)\!]$\[\033[0m\] "
  else
    export PS1="[\w]\n\[\033[0;32m\]\u@\h[\!]$\[\033[0m\] "
  fi
  PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
fi

# screen の場合のみ。ウィンドウ名をカレントディレクトリにする
if [ $TERM == 'screen' ]; then
  PS1=${PS1}'\[\033k\W\033\\\]'
fi

export LS_COLORS="di=0;36:ex=0;31:ln=0;35:cd=0;43;34:so=0;32"

case "${OSTYPE}" in
  darwin*)
    alias ls="ls -F -G"
    alias vim="mvim -v"
    alias view="mview -v"
  	alias factor="gfactor"
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
alias less='less -X -R'
alias vi='vim -u NONE --noplugin'

alias cprove='cover --delete; env PERL5OPT="-MDevel::Cover=+ignore,.*,+select,^lib" prove -l'
alias cprove_all='cover --delete; env PERL5OPT="-MDevel::Cover" prove -l'
alias rijiserve='php -S 0:3650 -t blog'
alias enable-dotfile-in-finder='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias disable-dotfile-in-finder='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
alias markdown2impress='markdown2impress --google-analytics-account UA-2083680-7'
alias screen-auto-attach='screen -r `screen -ls | grep Detached | awk "{ print $1 }" | sort -r | head -1`'
alias ec='env TERM=xterm-256color emacsclient -t -a emacs'
alias cdgr='cd $(git rev-parse --show-toplevel)'
alias pecode='code `find . | peco`'
alias tmux='tmux -u'
alias tmux-mouse-on='tmux set -g mouse on'
alias tmux-mouse-off='tmux set -g mouse off'

function peco-lscd {
    local dir="$( find . -maxdepth 1 -type d | sed -e 's;\./;;' | peco )"
    if [ ! -z "$dir" ] ; then
        cd "$dir"
    fi
}

# if [ -d $HOME/.nodebrew/current/bin ] ; then
#   export PATH=$HOME/.nodebrew/current/bin:$PATH
# fi

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

if [ -d $HOME/.nodenv ] ; then
  export PATH=$HOME/.nodenv/bin:$PATH
  eval "$(nodenv init -)"
fi

if [ -d "${PYENV_ROOT}" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

if [ -d "${RAKUDOBREW_ROOT}" ]; then
    export PATH=${RAKUDOBREW_ROOT}/bin:${RAKUDOBREW_ROOT}/moar-nom/install/share/perl6/site/bin:$PATH
    eval "$(rakudobrew init -)"
fi

export GOPATH="$HOME/go"
#export GOROOT="/usr/local/opt/go/libexec"
export PATH=$GOPATH/bin:$HOME/activator:$HOME/perl6/bin:$HOME/perl6/share/perl6/site/bin:$PATH
# export PATH=$HOME/.nodebrew/current/bin:$PATH

