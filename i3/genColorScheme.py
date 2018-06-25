#!/usr/bin/env python

'''
Andrew Barlow

Generate a color palette based on the current background set by pywal

Using documentation from:
https://github.com/dylanaraps/pywal/wiki/Using-%60pywal%60-as-a-module#examples

Started: 06/24/18

'''

#import wal api
import pywal



#Main Function
def main():
    
    vis_config = "/home/andrew/.config/vis/colors/pywal"
    file_out = open(vis_config, 'w')

    try:

        #find path for current background image
        background = pywal.image.get("/home/andrew/Photos/wallpapers/")
        #print(background)
    
    except:
    
        print("Error fetching current background")

    try:
    
        #get color scheme of current background in dict format
        colorScheme = pywal.colors.get(background)
        #print(colorScheme)
    
    except:
        print("Error fetching current color scheme")



    #TODO
    #format colorscheme to more usable data type
    #export to a file in ~/.config/vis/colors/

    for key in colorScheme["colors"]:
        file_out.write(colorScheme["colors"][key])
        file_out.write("\n")

   #Taken from github page, basically sets the background & themes
   
   # Apply the palette to all open terminals.
    # Second argument is a boolean for VTE terminals.
    # Set it to true if the terminal you're using is
    # VTE based. (xfce4-terminal, termite, gnome-terminal.)
    pywal.sequences.send(colorScheme, "True")

    # Export all template files.
    pywal.export.every(colorScheme)

    # Export individual template files.
    pywal.export.color(colorScheme, "xresources", "/home/andrew/.Xresources")
    pywal.export.color(colorScheme, "shell", "/home/andrew/colors.sh")

    # Reload xrdb, i3 and polybar.
    pywal.reload.env()

    # Reload individual programs.
    pywal.reload.i3()
    pywal.reload.polybar()
    pywal.reload.xrdb()

    # Set the wallpaper.
    pywal.wallpaper.change(background)



#call main
main()
