#!/bin/bash          

if [ ! -z "$1" ]
then 
	echo "parameter 1: $1"
fi

rotatePointers() {
	minute="$(date +%M)"
	houre="$(date +%H)"

	if [ $houre -gt 12 ]
	then
		houre=`expr $houre - 12`
	fi

	mrotation=`expr $minute \* 6`
	hrotation=`expr $houre \* 30 \+ $minute \/ 4`

	#rotieren der zeiger
	convert -background 'rgba(0,0,0,0)' -rotate $hrotation ./h-original.png ./h.png
	convert -background 'rgba(0,0,0,0)' -rotate $mrotation ./m-original.png ./m.png
}

rotatePointers

#zeiger mitte des haupt bildes
x=730
y=1330

composeHoure() {
#Stundenzeiger
#halbe bilder breite
hwidth=`convert ./h.png -format "%[fx:w/2]" info:`

#neu ausrichtung der zeiger zur mitte der uhr
xnew=`expr $x - $hwidth - 28`
ynew=`expr $y - $hwidth`
convert ./c-original.png ./h.png -geometry +$xnew+$ynew -composite ./r.png
}

composeHoure

composeMinute() {
#Minutenzeiger
#halbe bilder breite
mwidth=`convert ./m.png -format "%[fx:w/2]" info:`

#neu ausrichtung der zeiger zur mitte der uhr
xnew=`expr $x - $mwidth - 20`
ynew=`expr $y - $mwidth - 10`
convert ./r.png ./m.png -geometry +$xnew+$ynew -composite ../r.png
}
composeMinute

#set image to the background
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/r.png
gsettings set org.gnome.desktop.background picture-options "zoom"
