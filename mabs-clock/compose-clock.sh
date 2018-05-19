#!/bin/bash          

cd ~/source/mab-bg-clock/mabs-clock/

xPointerCenter=730
yPointerCenter=1330

currentMinute="$(date +%M)"
currentHour="$(date +%H)"

rotatePointers() {
	if [ ${currentHour} -gt 12 ]
	then
	    currentHour=`expr ${currentHour} - 12`
	fi

	mrotation=`expr ${currentMinute} \* 6`
	hrotation=`expr ${currentHour} \* 30 \+ ${currentMinute} \/ 4`

	#rotieren der zeiger
	convert -background 'rgba(0,0,0,0)' -rotate ${hrotation} ./h-original.png ./h.png
	convert -background 'rgba(0,0,0,0)' -rotate ${mrotation} ./m-original.png ./m.png
}

composeHourePointer() {
    #halbe bild breite
    hWidth=`convert ./h.png -format "%[fx:w/2]" info:`

    #neu ausrichtung der zeiger zur mitte der uhr
    xMinute=`expr ${xPointerCenter} - ${hWidth} - 28`
    yMinute=`expr ${yPointerCenter} - ${hWidth}`
    convert ./c-original.png ./h.png -geometry +${xMinute}+${yMinute} -composite ./r.png
}

#convert ./c-original.png ./h.png -geometry +730+1330 -composite ./m.png -geometry +730+1330 -composite res.png
composeMinutePointer() {
    #halbe bild breite
    mMidth=`convert ./m.png -format "%[fx:w/2]" info:`

    #neu ausrichtung der zeiger zur mitte der uhr
    xMinute=`expr ${xPointerCenter} - ${mMidth} - 20`
    yMinute=`expr ${yPointerCenter} - ${mMidth} - 10`


#    if [ ! -z "$1" ]
#    then
#        convert ./r.png ./m.png -geometry +${xnew}+${ynew} -composite ../gif/r-${1}.png
#	 else
#	    convert ./r.png ./m.png -geometry +${xnew}+${ynew} -composite ../r.png
#    fi

    convert ./r.png ./m.png -geometry +${xMinute}+${yMinute} -composite ../r.png

}

processGif() {
    counter=20
    images=""
    rm -rf ../gif/*
    while [ ${counter} -gt 0 ]
    do
        echo "processing image nr: ${counter} from ${1}"
        rotatePointers
        composeHourePointer
        composeMinutePointer ${counter}
        images=" ${images} ../gif/r-${counter}.png"
        ((counter--))
        ((currentMinute++))
    done
    convert -loop 0 -delay 100 ${images} ../r.gif
}

setClockToBackground() {
    gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/r.png
    gsettings set org.gnome.desktop.background picture-options "zoom"
    #echo "clock generated and set as desktop bg"
    #logger "clock generated and set as desktop bg"
}

processImage() {
    rotatePointers
    composeHourePointer
    composeMinutePointer
    cp ../r.png /usr/share/backgrounds/r.png
    setClockToBackground
}

while getopts ":r" opt; do
  case $opt in
    r)
      echo "clock will be generated with a random minute pointer" >&2
      currentMinute=`expr $RANDOM % 60`
      processImage
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

processImage