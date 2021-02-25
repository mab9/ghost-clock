#!/bin/bash          

# cd to src files 
cd ~/source/ghost-clock/

originalsPath="./originals/1920-1080-v1"

#1920-1080
#3840-2560

#xPointerCenter=730
#yPointerCenter=1330

xPointerCenter=361
yPointerCenter=494

currentMinute="$(date +%M)"
currentHour="$(date +%H)"

rotatePointers() {
	if [ ${currentHour} -gt 12 ]
	then
	    currentHour=`expr ${currentHour} - 12`
	fi

	mRotation=`expr ${currentMinute} \* 6`
	hRotation=`expr ${currentHour} \* 30 \+ ${currentMinute} \/ 2`

	convert -background 'rgba(0,0,0,0)' -rotate ${hRotation} ${originalsPath}/h-original.png ./h.png
	convert -background 'rgba(0,0,0,0)' -rotate ${mRotation} ${originalsPath}/m-original.png ./m.png
}

composeClock() {
    hWidth=`convert ./h.png -format "%[fx:w/2]" info:`
    mWidth=`convert ./m.png -format "%[fx:w/2]" info:`

    #neu positionierung der zeiger in die mitte der uhr
    xHoure=`expr ${xPointerCenter} - ${hWidth}`
    yHoure=`expr ${yPointerCenter} - ${hWidth}`

    xMinute=`expr ${xPointerCenter} - ${mWidth}`
    yMinute=`expr ${yPointerCenter} - ${mWidth}`

    convert ${originalsPath}/c-original.png ./h.png -geometry +${xHoure}+${yHoure} -composite \
            ./m.png -geometry +${xMinute}+${yMinute} -composite ../r.png
}

setClockToBackground() {
    gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/r.png
    gsettings set org.gnome.desktop.background picture-options "zoom"
    #echo "clock generated and set as desktop bg"
    #logger "clock generated and set as desktop bg"
}

processImage() {
    rotatePointers
    composeClock
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
