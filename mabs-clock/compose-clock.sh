#!/bin/bash          

#logger "mab-bg-clock should be actualized"
cd ~/source/mab-bg-clock/mabs-clock/

#zeiger mitte des haupt bildes
x=730
y=1330

minute="$(date +%M)"
houre="$(date +%H)"


rotatePointers() {
	if [ ${houre} -gt 12 ]
	then
	    houre=`expr ${houre} - 12`
	fi

	mrotation=`expr ${minute} \* 6`
	hrotation=`expr ${houre} \* 30 \+ ${minute} \/ 4`

	#rotieren der zeiger
	convert -background 'rgba(0,0,0,0)' -rotate ${hrotation} ./h-original.png ./h.png
	convert -background 'rgba(0,0,0,0)' -rotate ${mrotation} ./m-original.png ./m.png
}

composeHourePointer() {
    #halbe bild breite
    hwidth=`convert ./h.png -format "%[fx:w/2]" info:`

    #neu ausrichtung der zeiger zur mitte der uhr
    xnew=`expr ${x} - ${hwidth} - 28`
    ynew=`expr ${y} - ${hwidth}`
    convert ./c-original.png ./h.png -geometry +${xnew}+${ynew} -composite ./r.png
}

composeMinutePointer() {
    #halbe bild breite
    mwidth=`convert ./m.png -format "%[fx:w/2]" info:`

    #neu ausrichtung der zeiger zur mitte der uhr
    xnew=`expr ${x} - ${mwidth} - 20`
    ynew=`expr ${y} - ${mwidth} - 10`


    if [ ! -z "$1" ]
    then
        convert ./r.png ./m.png -geometry +${xnew}+${ynew} -composite ../gif/r-${1}.png
	else
	    convert ./r.png ./m.png -geometry +${xnew}+${ynew} -composite ../r.png
    fi
}

processGif() {
    counter=${1}
    images=""
    rm -rf ../gif/*
    while [ ${counter} -gt 0 ]
    do
        echo "processing image nr: ${counter} from ${1}"
        rotatePointers
        composeHourePointer
        composeMinutePointer ${counter}
        #r = "../gif/r-${counter}.png"
        images=" ${images} ../gif/r-${counter}.png"
        ((counter--))
        ((minute++))
    done
    convert -loop 0 -delay 100 ${images} ../r.gif
}



if [ ! -z "$1" ]
then
    echo "processing gif with ${1} images"
	processGif ${1}
else
    #echo "prcoessing bg clock"
    rotatePointers
    composeHourePointer
    composeMinutePointer
    cp ../r.png /usr/share/backgrounds/r.png
fi

#set image to the background
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/r.png
gsettings set org.gnome.desktop.background picture-options "zoom"
#echo "clock generated and set as desktop bg"
#logger "clock generated and set as desktop bg"
