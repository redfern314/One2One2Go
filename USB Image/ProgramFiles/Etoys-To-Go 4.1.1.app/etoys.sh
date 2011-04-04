#!/bin/bash
# File:        etoys.sh (Etoys-To-Go version)
# Author:      Bert Freudenberg
# Description: Script to run etoys.image on the Squeak VM binary,
#              using default directories relative to the installation itself

APP=`dirname "$0"`
APP=`cd "$APP";pwd`
TOP=`dirname "$APP"`
OS=`uname -s`
CPU=`uname -m`
BIN="$APP/Contents/$OS-$CPU"
VM="$BIN/etoys"
VMOPTIONS="-encoding UTF-8"
IMAGE="$APP/Contents/Resources/etoys.image"
IMOPTIONS=""
DOCUMENT=""
WRAPPER=""

export SQUEAK_SECUREDIR="$TOP/.etoys"
export SQUEAK_USERDIR="$TOP/Etoys"

[ ! -d "$SQUEAK_SECUREDIR" ] && mkdir -p -m 700 "$SQUEAK_SECUREDIR"
[ ! -d "$SQUEAK_USERDIR" ] && mkdir -p "$SQUEAK_USERDIR"

while [ -n "$1" ] ; do
	if [ -z "$2" ] ; then
		echo Usage: $0 [-opt value] [arg value]
		exit -1
	fi
	case "$1" in
	    --document)
			case "$2" in
			    /*) DOCUMENT="$2"
				;;
			    *) DOCUMENT="$PWD/$2"
				;;
			esac
 			shift
			;;
        -*) VMOPTIONS="$VMOPTIONS $1 $2"
			shift
			;;
		*)  IMOPTIONS="$IMOPTIONS $1 $2"
			shift
			;;
	esac
	shift
done

showerror() {
    if [ -n "$DISPLAY" -a -x "`which kdialog 2>/dev/null`" ]; then
        kdialog --error "$1"
    elif [ -n "$DISPLAY" -a -x "`which zenity 2>/dev/null`" ]; then
        zenity --error --text "$1"
    else
        dialog --msgbox "$1" 0 0
    fi
}

# Try to work around USB drives mounted as non-exec
if [ ! -x "$VM" ] ; then
    chmod -R a+x "$BIN" 2>/dev/null
fi
if [ ! -x "$VM" ] ; then
    TMPBIN=`mktemp -t -d etoys-to-go-XXXXX` || TMPBIN="${TMPDIR:-/tmp}/etoys-to-go$$.d" && mkdir -p "$TMPBIN"
    mkdir -p "$TMPBIN"
    TMPFILES=`cd "$BIN";ls`
    (cd "$BIN"; cp $TMPFILES "$TMPBIN")
    chmod -R a+rx "$TMPBIN"
    BIN="$TMPBIN"
    VM="$TMPBIN/etoys"
fi
if [ ! -x "$VM" ] ; then
    showerror "Etoys does not have permissions to execute"
fi

# if we are running in X11, enable shared memory for speed
# and compositioninput 
if [ -n "$DISPLAY" ] ; then
    VMOPTIONS="$VMOPTIONS -vm-display-x11 -xshm"
    case "$LANG" in 
        bn* | gu* | hi* | kn* | ml* | mr* | ta* | te* | sa* )
            case "$LANG" in
                *.[uU][tT][fF]-8 | *.[uU][tT][fF]8)
                    VMOPTIONS="$VMOPTIONS -compositioninput" ;;
            esac
        ;;
    esac
fi

# if pulseaudio is running, use it if VM has the driver, or fall back to OSS
if pulseaudio --check 2>/dev/null ; then
    if "$VM" -help 2> /dev/null | grep -q vm-sound-pulse ; then
        VMOPTIONS="$VMOPTIONS -vm-sound-pulse"
    else
        VMOPTIONS="$VMOPTIONS -vm-sound-oss"
        if padsp true 2>/dev/null ; then
            WRAPPER=padsp
        fi
    fi
fi

# VM, Image, and Document are non-optional
# Document has to be present even if empty
$WRAPPER "$VM" -plugins "$BIN" $VMOPTIONS "$IMAGE" "$DOCUMENT" $IMOPTIONS

if [ -d "$TMPBIN" ] ; then
    (cd "$TMPBIN" ; rm $TMPFILES)
    rmdir "$TMPBIN"
fi

