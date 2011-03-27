# $FreeBSD: src/share/skel/dot.login,v 1.11.2.1 1999/08/29 16:47:50 peter Exp $
#
# .login - csh login script, read by login shell, 
#	   after `.cshrc' at login.
#
# see also csh(1), environ(7).
#

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/bin /usr/X11R6/bin \
            /usr/local/sbin $HOME/bin)

setenv MANPATH "/usr/share/man:/usr/X11R6/man:/usr/local/man:/usr/man:/usr/local/share/man:/usr/local/man/ja:/usr/share/man/ja:/usr/X11R6/man/ja"

if (-x "/usr/local/bin/jless") then
    setenv PAGER 'jless -X'
else
    setenv PAGER more
endif

if (`uname` == "FreeBSD") then
    #setenv JSERVER localhost
    #setenv XMODIFIERS "@im=kinput2"
    setenv XMODIFIERS "@im=SCIM"
    setenv LC_ALL ja_JP.UTF-8
    setenv LC_CTYPE ja_JP.UTF-8
    setenv LC_MESSAGES ja_JP.UTF-8
    setenv LANG ja_JP.UTF-8
    #setenv PAGER jless
    #setenv JAVA_HOME /usr/local/jdk1.4.2
    #setenv JAVA_HOME /usr/local/jdk1.5.0

    if ( -d /usr/local/diablo-jdk1.5.0 ) then
	setenv JAVA_HOME /usr/local/diablo-jdk1.5.0
    else if ( -d /usr/local/jdk1.5.0 ) then
	setenv JAVA_HOME /usr/local/jdk1.5.0
    else if ( -d /usr/local/jdk1.4.2 ) then
	setenv JAVA_HOME /usr/local/jdk1.4.2
    endif

    #setenv PATH /usr/local/jdk1.4.2/bin:$PATH
    #setenv JAVAVM /usr/local/jdk1.4.2/bin/java
    #setenv JAVAVM /usr/local/jdk1.5.0/bin/java
    setenv JARDIR /usr/local/share/java/classes
    setenv JHHOME /usr/local/jh1.1

    if (! $?CLASSPATH) then
	setenv CLASSPATH .
    endif
    
    set jdelib = "/usr/local/share/java/jde/lib"
    if (-d $jdelib) then
	foreach i (`/bin/ls $jdelib | grep \\.jar`)
	    setenv CLASSPATH $jdelib/$i\:$CLASSPATH
	end
    endif
    unset $jdelib

    set java3ddir = "/usr/local/share/java/java3d/jar"
    if (-d $java3ddir) then
	foreach i (`/bin/ls $java3ddir | grep \\.jar`)
	    setenv CLASSPATH $java3ddir/$i\:$CLASSPATH
	end
    endif
    unset $java3ddir

    set jaidir = "/usr/local/share/java/jai/jar"
    if (-d $jaidir) then
	foreach i (`/bin/ls $jaidir | grep \\.jar`)
	    setenv CLASSPATH $jaidir/$i\:$CLASSPATH
	end
    endif
    unset $jaidir


    if (-d $JARDIR) then
	foreach i (`/bin/ls $JARDIR/ | grep \\.jar`)
	    setenv CLASSPATH $JARDIR/$i\:$CLASSPATH
	end
    endif
else if (`uname` == "SunOS") then
    if (-x /usr/local/bin/kinput2) then
	setenv XMODIFIERS "@im=kinput2"
    endif
    setenv JAVA_HOME /usr/j2se
    if (-x "/usr/local/bin/jless") then
	setenv PAGER jless
    else
	setenv PAGER more
    endif
endif
if (-x /usr/games/fortune) then
    echo `/usr/games/fortune`
endif

# A rightous umask
umask 22

