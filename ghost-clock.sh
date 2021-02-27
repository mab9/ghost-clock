#!/bin/bash          

imageOutputPath=./ghost-clock.png
currentMinute="$(date +%M)"
currentHour="$(date +%H)"

# used to work with relative paths
FILE_DIRECTORY=`dirname "$0"`
ghostClockRepoPath=$(realpath ${FILE_DIRECTORY})
cd ${ghostClockRepoPath}

useResolution1920-1080() {
  originalsPath="./originals/1920-1080-v1"
  xPointerCenter=361
  yPointerCenter=494
}

useResolution3840-2560() {
  originalsPath="./originals/3840-2560-v2"
  xPointerCenter=730
  yPointerCenter=1330
}

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

    # Pointer positioning to the middle of the clock
    xHoure=`expr ${xPointerCenter} - ${hWidth}`
    yHoure=`expr ${yPointerCenter} - ${hWidth}`

    xMinute=`expr ${xPointerCenter} - ${mWidth}`
    yMinute=`expr ${yPointerCenter} - ${mWidth}`

    convert ${originalsPath}/c-original.png ./h.png -geometry +${xHoure}+${yHoure} -composite \
            ./m.png -geometry +${xMinute}+${yMinute} -composite ${imageOutputPath}

    # different out path to create gif
    # convert ${originalsPath}/c-original.png ./h.png -geometry +${xHoure}+${yHoure} -composite \
    #         ./m.png -geometry +${xMinute}+${yMinute} -composite ./gif/ghost-clock-${currentHour}-${currentMinute}.png
}

activateClockToBackground() {
    # Would be good to distinguish os instead of to set multiple settings.
    gsettings set org.gnome.desktop.background picture-uri file://${ghostClockRepoPath}/ghost-clock.png
    gsettings set org.gnome.desktop.background picture-options "zoom"

    gsettings set org.cinnamon.desktop.background picture-uri file://${ghostClockRepoPath}/ghost-clock.png
    gsettings set org.cinnamon.desktop.background picture-options "zoom"

    #echo "clock generated and set as desktop bg"
    #logger "clock generated and set as desktop bg"
}

processImage() {
    rotatePointers
    composeClock
    activateClockToBackground
}

generateGif() {
  originalsPath="./gif"

  # Generate a day
  for (( j = 0; j < 12; j++ )); do
      # Generate one hour
      for (( i = 0; i < 60; i++ )); do
          currentMinute=$i
          currentHour=$j
          imageOutputPath=./gif/ghost-clock-${currentHour}-${currentMinute}.png
          processImage
      done
  done
}

function instructions() {
  echo "Options:"
  echo "  -g         generate gif"
  echo "  -s         generate small img  - resolution 1920-1080"
  echo "  -m         generate medium img - resolution 3840-2560"
  echo ""
  echo "Usage:"
  echo "  ./ghost-clock -s"
  echo ""
}

error() {
  echo "Examples: ./ghost-clock -s"
  echo ""
  instructions
}

function help() {
  echo "Help"
  echo ""
  instructions
}

case $1 in
  -g)
    generateGif
    ;;
  -s)
    useResolution1920-1080
    processImage
    ;;
  -m)
    useResolution3840-2560
    processImage
    ;;
  -h|--help)
    help
    ;;
  *)
    error
    ;;
esac