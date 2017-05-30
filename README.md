# Cuties Computer Vision
## James Smith, Daria Shifrina, Gilvir Gill
Cuties Computer Vision (**CCV**) is a basic implementation of [Computer Vision](https://en.wikipedia.org/wiki/Computer_vision), the idea of using a computer to interpret visual data. In this case, it relies on keeping track of a single object via it's color, and motion. We use the built in Processing Video library, which is based off of and requires locally gstreamer.

This program works by turning each individual frame of a video feed into an array of colors in which each pixel is a color, then navigating this array, finding pixels that match the selected object's color and position relative to the previous frame. 

To run the CCV program, use `processing CCV/CCV.pde`, select whether you want to use an active camera feed, or a prerecorded video, and then select the object that you would like the program to track.

Have fun, thinkers!

# Classes

**CCV** is the main applet, and is nicely wrapped in the PApplet class (which is necessary in other classes as a reference). It contains references to the other objects, including the Video input. THe user is first given an instance of **UserMenu**, which loads two ellipse buttons on the screen and lets you pick your input from **Video** and **Camera**, which essentially interact with the built in Capture library to return the PImage class. 

The PImage class is made up of an 1d array and a couple other variables, such as length. To locate the (x,y) location of a pixel in the PImage, you would go to (x+y*width)

Then, this data is passed to **Frame**, which coupled with **CCVMath** provides methods for convient access. Then, the user clicks on an object, and it's properties are constructed and stored in the **TrackedObject** class
