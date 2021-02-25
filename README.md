# Ghost clock

<!--- These are examples. See https://shields.io for others or to customize this set of shields. You might want to include dependencies, project status and licence info here --->
![GitHub repo size](https://img.shields.io/github/repo-size/mab9/ghost-clock)
![GitHub contributors](https://img.shields.io/github/contributors/mab9/ghost-clock)
![GitHub stars](https://img.shields.io/github/stars/mab9/ghost-clock?style=social)
![GitHub forks](https://img.shields.io/github/forks/mab9/ghost-clock?style=social)
<!--![Twitter Follow](https://img.shields.io/twitter/follow/mab9?style=social)-->

Ghost clock is a tool that allows developers to reduce their repetitive tasks.

The tool offers core functions and the possibility to integrate and use self written plugins to improve the dev workflow.
It aims to make it easier to work on different devices by providing the same functions.

![img](./originals/1920-1080-v1/c-original.png "ghost-clock")

## Installing ghost clock

To install ghost clock, follow these steps:

Linux:
```
git clone https://github.com/mab9/md.git
bash ./md/installation.sh
```

## Using ghost clock

this command sets the image to the background. the image must be in the /usr/share/backgrounds folder. otherwise the background change will not work.
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/clock.jpg


this command does resize the image so taht it fits to the display.
gsettings set org.gnome.desktop.background picture-options "zoom"

http://danilodellaquila.com/en/blog/how-to-automatically-change-your-desktop-background-wallpaper


- arbeiten mit verschiedenen layers
convert  c.jpg h.jpg -geometry +250+250 -composite r.png

- resize 
convert wecker.jpg -resize 1000 w.jpg

- drehen der bilder
convert -rotate 90 in.jpg out.jpg


- rotate and set background transparent
convert -background 'rgba(0,0,0,0)' -rotate 105 clock-zeiger-h-original-v2.png h.png


- get image width 
identify -format "%w" c.png 



- cronjob 
crontab -e * * * * * /compose-clock.sh
https://www.cyberciti.biz/faq/how-to-run-cron-job-every-minute-on-linuxunix/


- gif image with convert
convert -loop 0 -delay 100 in1.png in2.png out.gif


## Contributing to ghost clock

<!--- If your README is long or you have some specific process or steps you want contributors to follow, consider creating a separate CONTRIBUTING.md file--->
To contribute to ghost clock, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin md/<location>`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## My next ideas

- Make core scripts generic
- add md autocompletion
- Extend the use of the working directory
- Add a logging script with a lot of inos about logging [like](https://sematext.com/blog/journald-logging-tutorial/)

## Contributors

Thanks to the following people who have contributed to this project:

* [@mab9](https://github.com/mab9) 📖

<!-- You might want to consider using something like the [All Contributors](https://github.com/all-contributors/all-contributors) specification and its [emoji key](https://allcontributors.org/docs/en/emoji-key). -->

## Contact

If you want to contact me you can reach me at **marcantoine.bruelhart@gmail.com.**

## License
<!--- If you're not sure which open license to use see https://choosealicense.com/--->

This project uses the following license: [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/).












