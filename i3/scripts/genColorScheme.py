#!/usr/bin/env python

'''
Andrew Barlow
Generate a color palette based on the current background set by pywal
Using documentation from:
https://github.com/dylanaraps/pywal/wiki/Using-%60pywal%60-as-a-module#examples
06/24/18
'''

#import wal api
import pywal
#import tool to read hex colors according to their hue & sort
import colorsys
#os for file in/output
import os
#subproccess in order to call a script to reset vis
import subprocess


#turn hex val into hsv
def get_hsv(hexrgb):
    hexrgb = hexrgb.lstrip("#")   # in case you have Web color specs
    r, g, b = (int(hexrgb[i:i+2], 16) / 255.0 for i in range(0,5,2))
    return colorsys.rgb_to_hsv(r, g, b)





#sort list of hsv colors
def sort_hsv(colorList):
    #bubble sort the colors
    sorted = False
    while (sorted == False):
        sorted = True
        for i in colorList:
            if (colorList[i+1][1] > colorList[i][1]):
                sorted = False
                temp = colorList[i]
                colorList[i] = colorList[i+1]
                colorList[i+1] = temp


def test_sorting(colorList_og, colorList_new):
    print("--------------------------------------------")
    print("Original Color List:")
    print("--------------------------------------------")

    for i in colorList_og:
        print(i)

    print("--------------------------------------------")



    print("Sorted Color List:")
    print("--------------------------------------------")

    for i in colorList_new:
        print(i)

    print("--------------------------------------------")


def init():
    try:
        os.remove("/home/andrew/.cache/wal/sequences")
    except FileNotFoundError:
        print("file nonexistant")
    #reset vis
    reset_vis()

#Main Function
def main():
    vis_config = "/home/andrew/.config/vis/colors/pywal"

    try:
        os.remove(vis_config)
    except OSError:
        pass

    file_out = open(vis_config, 'w')


    try:

        #find path for current background image
        background = pywal.image.get("/home/andrew/Photos/wallpapers/")


    except:
        #error message
        print("Error fetching current background")

    try:

        #get a color scheme for current background in dict format
        colorScheme = pywal.colors.get(background)

        #get a list of hex values seperate from the dict
        colors = colorScheme["colors"]


        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("Error fetching current color scheme")
        if (colorCount == 2):
            print("Could not generate background with:")
        print(background)
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        return 1

    colorList = []

    for key in colors:
        colorList.append(colors[key])


    testSort = colorList

    colorList.sort(key=get_hsv)

    #test_sorting(colorList, testSort)



    #write all of the colors in color scheme to vis config file
    for i in range(0, len(colorList)):
        file_out.write(colorList[i])
        file_out.write("\n")







    #Taken from github page, basically sets the background & themes


    # Apply the palette to all open terminals.
    # Second argument is a boolean for VTE terminals.
    # Set it to true if the terminal you're using is
    # VTE based. (xfce4-terminal, termite, gnome-terminal.)
    pywal.sequences.send(colorScheme, "/home/andrew/.cache/wal", True)

    # Export all template files.
    pywal.export.every(colorScheme)

    # Export individual template files.
    pywal.export.color(colorScheme, "xresources", "/home/andrew/.Xresources")
    pywal.export.color(colorScheme, "shell", "/home/andrew/.config/i3/colors.sh")

    # Reload xrdb, i3 and polybar.
    pywal.reload.env()

    # Reload individual programs.
    pywal.reload.i3()
    pywal.reload.polybar()
    pywal.reload.xrdb()

    # Set the wallpaper.
    pywal.wallpaper.change(background)

    #reset vis
    subprocess.call(['./resetVis.sh'])



#call main
main()
subprocess.call(['./resetVis.sh'])
