# Cuties Computer Vision
## James Smith, Daria Shifrina, Gilvir Gill
Cuties Computer Vision (**CCV**) is a basic implementation of [Computer Vision](https://en.wikipedia.org/wiki/Computer_vision), the idea of using a computer to interpret visual data. In this case, it relies on keeping track of a single object via it's color, and motion. We use the built in Processing Video library, which is based off of and requires locally gstreamer.

This program works by turning each individual frame of a video feed into an array of colors in which each pixel is a color, then navigating this array, finding pixels that match the selected object's color and position relative to the previous frame. 

To run the CCV program, use `processing CCV/CCV.pde`, select whether you want to use an active camera feed, or a prerecorded video, and then select the object that you would like the program to track.

Have fun, thinkers! 
