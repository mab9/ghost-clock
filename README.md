# Ghost clock

<!--- These are examples. See https://shields.io for others or to customize this set of shields. You might want to include dependencies, project status and licence info here --->
![GitHub repo size](https://img.shields.io/github/repo-size/mab9/ghost-clock)
![GitHub contributors](https://img.shields.io/github/contributors/mab9/ghost-clock)
![GitHub stars](https://img.shields.io/github/stars/mab9/ghost-clock?style=social)
![GitHub forks](https://img.shields.io/github/forks/mab9/ghost-clock?style=social)
<!--![Twitter Follow](https://img.shields.io/twitter/follow/mab9?style=social)-->

Ghost clock always shows you the current time on your desktop background. 

When executing the script, it produces an image of a clock showing the current time. 
As soon ghost clock is installed, a clock image will be generated every minute and set as your desktop background. 
This makes your desktop spitting.

![img](./out.gif "ghost-clock")


![img](./ghost-clock.gif "ghost-clock")

## Installing ghost clock

To install ghost clock, follow these steps:

Linux:

```
git clone https://github.com/mab9/ghost-clock.git
crontab -e
* * * * * /<ReplaceMe-path-toGhostClockScript>/ghost-clock.sh -s  # chose resolution -s (1920-1080) or -m (3840-2560): 
@reboot /<ReplaceMe-path-toGhostClockScript>/ghost-clock.sh -s  # chose resolution -s (1920-1080) or -m (3840-2560): 
```
- **Checkout the crontab example config image**

- **We create a user based crontab entry to run it with the given user: crontab -e. These entries are stored in files with the same name as the user in this directory, /var/spool/cron/**

- **Jobs that are added manually to the systems crontab (edit /etc/crontab) will be run with absolute permissions (ie: run as root) unless you specify another user.**

## Explanation of used commands 

This command sets the image to the background. the image must be in the /usr/share/backgrounds folder. Otherwise the background change will not work.

    gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/clock.jpg

This command does resize the image so that it fits to the display.
    
    gsettings set org.gnome.desktop.background picture-options "zoom"
    http://danilodellaquila.com/en/blog/how-to-automatically-change-your-desktop-background-wallpaper


Work with multiple image layers

    convert  c.jpg h.jpg -geometry +250+250 -composite r.png

Resizing the image resolution

    convert wecker.jpg -resize 1000 w.jpg

Rotate an image

    convert -rotate 90 in.jpg out.jpg
  
Rotate image and make background transparent

    convert -background 'rgba(0,0,0,0)' -rotate 105 clock-zeiger-h-original-v2.png h.png
  
Get image width

    identify -format "%w" c.png 

  
Cronjob config

    run cronjob every minute
    crontab -e * * * * * /ghost-clock.sh -s
    
    run script on system reboot
    crontab -e @reboot /ghost-clock.sh -s

Create a gif image
    
    convert -loop 0 -delay 100 in1.png in2.png out.gif
    convert -delay 25 -loop 0 -resize 20% ghost-clock-{0..11}-{0..59}.png ghost-clock.gif

- **-loop 0 = run 4 ever**
- **-delay 25 = x/100 ticks per second**

## Possible errors

### Gsettings not working for your OS

Google the right gsetting command to set background image.

### Cache resources exhausted

When your system falls into cache resources exhausted errors you may increase image magick max memory usage. 

    sudo nano /etc/ImageMagick-6/policy.xml
    <policy domain="resource" name="disk" value="1GiB"/>  

**Example: increase memory usage from 1gb to 2gb**

## My next ideas

- provide support for ios, windows, android and more
- execute script when unlocking os from sleep mode
- change image transition speed for linux mint
- fix -m resolution bug. The pointers for resolution -m are always few minutes behind current time.

## Contributing to ghost clock

<!--- If your README is long or you have some specific process or steps you want contributors to follow, consider creating a separate CONTRIBUTING.md file--->
To contribute to ghost clock, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin ghost-clock/<location>`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## Contributors

Thanks to the following people who have contributed to this project:

* [@mab9](https://github.com/mab9) 📖

<!-- You might want to consider using something like the [All Contributors](https://github.com/all-contributors/all-contributors) specification and its [emoji key](https://allcontributors.org/docs/en/emoji-key). -->

## Contact

If you want to contact me you can reach me at **marcantoine.bruelhart@gmail.com.**

## License
<!--- If you're not sure which open license to use see https://choosealicense.com/--->

This project uses the following license: [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/).