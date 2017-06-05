# Cuties Computer Vision
## James Smith, Daria Shifrina, Gilvir Gill
Cuties Computer Vision (**CCV**) is a basic implementation of [Computer Vision](https://en.wikipedia.org/wiki/Computer_vision), the idea of using a computer to interpret visual data. This program allows you to track an object or run a sobel edge detection filter on a pre-recorded video or a live camera feed. This program relies on keeping track of a single object via it's color using its hue, saturation, and brightness components(HSB).

# Prerequisites
1. The Video library by the Processing Foundation must be installed in order to run this program. Information on how to install the library can be found [here](https://github.com/processing/processing/wiki/How-to-Install-a-Contributed-Library) and the actual library repository can be found [here if you wish to manually install it.](https://github.com/processing/processing-video)
2. In order to use the webcam feature, you must have a webcam, otherwise the program will fail.
3. You must have an understanding of hue, saturation, and brightness in order to calibrate the program. Information can be found further down and also [here](https://en.wikipedia.org/wiki/HSL_and_HSV)

# How to Run
After you have met the first prerequistite, navigate to the 'cuties' repository folder on your computer and enter `processing CCV/CCV.pde` into the terminal. Alternitively, you could also find CCV.pde in a file explorer and run that file. After opening the file in processing, run the applet by clicking the play button in the top left corner of the screen.
Have fun, thinkers!

# How to Use
Here are the keys necessary to use with the program:

| Key | Function |
| ------------- | ------------- |
| ESCAPE | Exits the program |
| Releasing Mouse Button | Selects an object to track on the screen |
| BACKSPACE | Stops tracking the object on the screen |
| UP | Mirror the screen |
| LEFT | Turn on sobel edge detection filter |
| DOWN | Turn on HSB range filter |
| Q | Increases the hue threshold  |
| A | Decreases the hue threshold  |
| W | Increases the saturation threshold |
| S | Decreases the saturation threshold |
| E | Increases the brightness threshold |
| D | Decreases the brightness threshold |
| R | Increases the sobel edge detection threshold |
| F | Decreases the sobel edge detection threshold |

Once you have the program running, you will be prompted with two options: "Camera" or "Video File". Click the one you desire to use for the program(see Prerequisite 2 before selecting "Camera"). If you selected "Video File" a file explorer will be opened where you can navigate to the desired **video** file(the file must be a video file supported by the Video library) and open it up.

You should now have a video feed on screen! Now, you may click on object on the screen and it will begin to track it. You can now calibrate the tracking by adjusting the threshold values for hue, saturation, and brightness using the keys above. 

You may also change what you see on the screen using the filters. The mirror filter reflects the screen. The sobel edge detection filter displays only the hard edges of the image. The threshold values for this can also be calibrated until you get a nice result. The last filter is the HSB range filter which shows you what the computer "sees" when tracking the object. For more information on these filters, go to the filters section of this file. 

# Classes
**CCV**: The main applet which acts as the driver file for the program. This class handles the start up sequence and the main program loop that controls how the TrackedObject and Frame interact with each other and the user. 

**CCVMath**: A small class dedicated to converting 2D coordinates to linear coordinates and vice versa. It needs to do this because the screen is a color[] and some of us prefer to work on 2D coordinates as opposed to linear.

**Camera**: Instantiates a Caputure object from the Video library and uses it to open up a live Camera feed. Feeds PImage frames to the CCV main applet when there is a frame available.

**Video**: Performs the same operation as Camera, but instead opens up a video file and loops it.

**Frame**: A container for the PImage frame. Contains 3 color arrays, one for what the computer sees, one for mid process filtering, and one for what the user sees. This class is used for getting information from a video frame, changing information on the video frame, filtering the video frame, and displaying the frame.

**Tracked Object**: Represents the object being tracked on the screen. At its core, it relies on its color, its frame, and its ArrayList containing object pixels. This class takes in a frame, runs a binary HSB filter on the frame for its color and threshold values, and then adds the pixels that meet the requirement of the filter to the arrayList for display.

**UserMenu**: A GUI for the initial video feed selection.

# How the filters work
**HSB Filter**
The binary HSB filter takes a color(the color of the object), then breaks the color down into its individual components: hue, saturation, and brighness. The filter then creates a range of acceptable values for each component using a lower and upper threshold with adjustable deltas. The frame is then iterated through, and each pixel is decomposed into its HSB components and checked to see if each element makes it its corresponding acceptable range. If it meets the criteria, this means that the pixel is similar enough to the object pixel that it is most likely part of the object, and it is turned white(255). If it does not meet the criteria, it is turned black. This creates a binary image(black and white) in which the white pixels are the object pixels and the black are not. Lastly, because the filter is not perfect, it will pick up random pixels here and there which is considered noise. To get rid of such noise, an erosion and a dilation are called one after the other. Though they are inverse operations, it doesn't function that way when the only two options for a color are white or black. And because black is the majority, the white noise will be filtered out, leaving just the object.

Before:
![alt text](https://i.gyazo.com/4b46ec8f910aae40916de1e123b3bbc7.png)

After:
![alt text](https://i.gyazo.com/f48c296130fb8d21786bd9a0a32bad06.png)

**Why use HSB as opposed to RGB?**
HSB transforms the RGB cartesian cube into a more intuitive system in the form of a cylinder. This allows easier adjustment of threshold because if you trying to calibrate on RGB, you are adjusting the color itself which can lead to very extreme consequences. When using HSB, you can adjust the saturation if your object seems to be more vibrant than other things in the frame, the brightness if it is brighter or darker, and hue if the acceptable color range doesn't seem right. A diagram of HSB and RGB can be seen below.
![alt text](https://i.stack.imgur.com/dvHEX.png)
![alt text](https://upload.wikimedia.org/wikipedia/commons/0/05/RGB_Cube_Show_lowgamma_cutout_a.png)
Additionally, a double threshold cannot be implemented in RGB because you can only calculate color distance using the 3D cartesian cube, thus leading to a less accurate filter.
