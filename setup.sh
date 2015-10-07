#!/bin/sh

#define source files to be installed
BASHFILES="bash_aliases"

#define emacs files to be installes
DOTEMACS="emacs"
EMACSDIR=""

#post setup scripts..
POST_SETUP=


#default destination prefix values
PREFIX=~/
BASHRC=~/.bashrc

# if WIPE=1 delete previous installation,if possible
WIPE=0

usage() {
    echo "setup.sh -[pw]"
    echo " -h   Show this message"
    echo " -p   Destination Prefix"
    echo "      Default: $PREFIX"
    echo " -w   Wipe destination directories (if posible)"
}

RES(){
    if [ $1 -eq 0 ]; then
	echo " ·=[ OK  ]=· "
    else
	echo " ·=[ERROR]=· "
    fi
}

RINS(){
    if [ $1 -eq 0 ]; then
	#echo " ·=[Already Installed]=· "
	echo " ....... Already Installed"
    else
	#echo " ·=[       OK        ]=· "
	echo " ....... OK"

    fi
}



MSG(){
    echo -ne "$@"
}

MSGLN(){
    echo "$@"
}




bash_src_addfile(){
    cp  $1 $PREFIX/.$1 
    
    line="[ -f  $PREFIX/.$1 ] && . $PREFIX/.$1"

    MSG "  + [ $1 ] -> $PREFIX/.$1  "
    
    grep "$line" $BASHRC > /dev/null
    RES=$?

    if [ ! $RES -eq 0 ]; then
	echo "$line" >> $BASHRC
    fi
    RINS $RES
}


bash_src_adddir(){

    srcfiles=`ls $1/`

    MSG "  *  Adding dir: $f  "
    
    for s in "echo $srcfiles"; do
	bash_src_addfile $s
    done
    s=""
}



install_bash(){

    for f in $BASHFILES; do
	[ -f $f ] && bash_src_addfile $f
	[ -d $f ] && bash_src_adddir  $f
    done
    f=""
}


install_emacs(){
    MSGLN "  *  Installing .emacs "
    cp $DOTEMACS $PREFIX/.emacs > /dev/null

    if [ ! "$EMACSDIR" == "" ]; then
	if [ $WIPE -eq 1 ]; then
	    MSGLN "  *  Installing .emacs.d  ·=[ WIPED ]=· "
	    rm -rf $PREFIX/.emacs.d > /dev/null
	else
	    MSGLN "  *  Installing .emacs.d"
	fi
        cp -r $EMACSDIR $PREFIX/.emacs.d > /dev/null
    fi
}


post_install(){

    for s in $POST_SETUP; do
	bash ./s
    done
    f=""
}




while getopts "hp:w" o; do
    case "$o" in
	h)  usage
	    ;;
	p)
	    PREFIX=$OPTARG
	    ;;
	w)
	    WIPE=1
	    ;;
	*)
	    usage
	    ;;
    esac
done
shift $((OPTIND-1))


MSGLN "=> Seting up bash environment files"
install_bash 
MSGLN ""


MSGLN "=> Seting up emacs"
install_emacs 
MSGLN ""


if [ ! "$POST_SETUP" == "" ]; then
    MSGLN "=> Post scripts"
    post_install 
    MSGLN ""
fi




