#  .cshrc for FreeBSD/Solaris/Linux/(ちょっとだけ)cygwin
#  
#       last updated : 2011/01/13
#       modified by tsucchi

if ( "`uname`" == "SunOS" ) then
    set path = (/usr/local/bin /opt/sfw/bin /usr/sfw/bin /usr/openwin/bin \
    /usr/dt/bin $path /bin /usr/ucb /usr/ccs/bin)
    unset autologout
endif
if ( "`uname`" == "Linux") then
  setenv LD_LIBRARY_PATH /usr/local/lib

  setenv XMODIFIERS "@im=SCIM"
  setenv LC_ALL ja_JP.eucJP
  setenv LC_CTYPE ja_JP.eucJP
  setenv LC_MESSAGES ja_JP.eucJP
  setenv LANG ja_JP.eucJP
  setenv PAGER less

  unset autocorrect
  unset correct
  unset autologout
endif

setenv EDITOR  vi
setenv BLOCKSIZE 1K
setenv HOST  `hostname`

if ( $?prompt ) then
  if ( $?tcsh ) then    # tcsh用の設定
    set color
    set colorcat
    set rmstar
    #                1 2 3 4 5 6 7 8 9 1011
    setenv LSCOLORS "gxfxcxdxbxegedabagacad"
    setenv LS_COLORS "di=0;36:ex=0;31:ln=0;35:cd=0;43;34:so=0;32"
    if ( -e ~/.complete ) then
      source ~/.complete
    endif
    if ( "`whoami`" == "root" ) then
      set prompt = "[%~]\\
%{^[[31m%}root@%m[%h]#%{^[[0m%} %L"
    else
      set prompt = "[%~]\\
%{^[[32m%}`whoami`@%m[%h]\%%{^[[0m%} %L"
    endif
  else # csh用の設定
    if ( "`whoami`" == "root" ) then
      set prompt = "%B%U`whoami`@`hostname | sed s/\\..\*//`%u [\\!] #%b "
    else
      set prompt = "`whoami`@`hostname | sed s/\\..\*//` [\\!] % "
    endif
    set filec
  endif

  # csh, tcsh共通の設定
  # read aliases
  # aliasは .aliases に書いてあります。自分で追加するならそちらに足した方が良いでしょう
  if ( -e ~/.aliases ) then
    source ~/.aliases
  endif
  #set cdpath  =   ( .. ~ )
  set history = 100
  set savehist = 100
  set symlinks = expand
  set autoexpand
  set autolist
  set addsuffix
  set fignore = ('~' .class .aux .o .tmp CVS \~)
  set ignoreeof
  set visiblebell
  set nobeep
  #set recexct
  set notify

  if ( "`uname`" == "FreeBSD") then
    # setting for ls color support
    switch ($term)
      case kterm:
        set term=kterm-color
        breaksw
      case xterm:
        set term=xterm-color
        breaksw
    endsw
  endif
endif

if (`uname | grep -i cygwin` == "") then
  # cygwin の tcsh には limit がない
  limit coredumpsize 0
endif

# load host-local file
if ( -e ~/.hostlocal ) then
  source ~/.hostlocal
endif

# perlbrew
if ( -e ~/perl5/perlbrew/etc/cshrc ) then
  source ~/perl5/perlbrew/etc/cshrc
endif
