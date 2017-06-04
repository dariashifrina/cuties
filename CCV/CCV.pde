/* Team Cuties
 * Dasha, James, Gilivr
 * APCS2 Pd3
 */
Frame currentFrame;
VideoStream in;
PImage img;
TrackedObject tracked;
int state; //0 = in user prompt, 1 = camera, 2 = movie
UserMenu menu;
int sobel_threshold;
int color_threshold;
boolean mirrored;//true if the user wants the display to be mirrored
boolean sobelFiltered; //true if the user wants to see the sobel Filter on the screen
boolean hsbFiltered; //true if the user wants to see the hsb filter on the screen

void setup() {
  size(600, 480);//adjusts the camera resolution
  background(0);
  surface.setResizable(true);
  frameRate(60);
  state = 0;
  menu = new UserMenu(width, height);
  in = null;
  sobel_threshold = 60;//color threshold to divide the pixels among their local gradient
  color_threshold = 200;//maximum threshold value to consider a pixel similar to another
  mirrored = false;
  sobelFiltered = false;
  hsbFiltered = false;
}

/**
 *Draws the next image from the camera feed and the outline of the object being tracked.
 */
void draw() {
  //user setup loop
  if (state == 0) {
    background(0);
    menu.draw();
  }

  //Main loop
  else {
    img = in.getImage();//get the camera's frame
    if (img.height == 0 || img.width == 0) { //if a speghetti frame was fed in, dont do anything
    } else {
      currentFrame = new Frame(img);//turn that image into a frame for a possible trackedObject
      try {
        surface.setSize(img.width, img.height); //try to resize the frame to its proper size
      } 
      catch(Exception e) {
        println("Resize error! Trying again on next Frame...");
      }
      if (mirrored) {
        currentFrame.mirror(); //mirror the picture
      }
      if (sobelFiltered) {
        currentFrame.sobelFilter(sobel_threshold);
      }
      if (hsbFiltered) {
        if (tracked == null) {
          println("No tracked object color to filter");
        } else {
          currentFrame.nonFiltered.pixels = currentFrame.filtered;
        }
      }
      currentFrame.draw(); //Display the image
      if (tracked != null) { //if there is a trackedObject, display it
        tracked.draw(currentFrame);//update the object with the new frame and draw it
      }
      System.gc();
    }
  }
}



/**
 *Creates a trackedObject at the mouse's position
 */
void mouseReleased() {//ensures that it only happens once vs mouse clicked
  if (state == 0) { //if you are in the user menu
    int toBeState; //Handles threading in the case of state 2 so the draw method doesn't get ahead of the mouseClicked()
    toBeState = menu.mouseReleased(); //calls mouseClicked of menu to check if the mouse is in the buttons
    if (toBeState == 1) {
      in = new Camera(this);
      state = toBeState;
    }
    if (toBeState == 2) {
      selectInput("Select a video file to run", "fileSelected"); //opens OS's filesystem to get File object. "fileSelected" is method callback
    }
  } else {
    tracked = new TrackedObject(mouseX, mouseY, currentFrame);
  }
}

/**
 *Called by selectInput() method callback. Creates a video object and sets the state to 2
 *@return void
 */
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else { 
    in = new Video(this, selection.getAbsolutePath()); //turns the file object into a String path and passes it into a Video file feed object
    state = 2;  //finally sets the state since you are at the end of multithreading
  }
}

void keyPressed() {
  if (key == 'r') {
    sobel_threshold += 2;
    println("The Sobel threshold is now: " + sobel_threshold);
  }
  if (keyCode == 'f') {
    sobel_threshold -=2;
    println("The Sobel threshold is now: " + sobel_threshold);
  }
  if (keyCode == ESC) {
    exit();
  }
  if (key == 'q' && tracked != null) {
    tracked.hue_threshold += 5;
    println("The hue threshold is now: " + tracked.hue_threshold);
  }
  if (key == 'a' && tracked != null) {
    tracked.hue_threshold -= 5;
    println("The hue threshold is now: " + tracked.hue_threshold);
  } 
  if (key == 'w' && tracked != null) {
    tracked.saturation_threshold += 5;
    println("The saturation threshold is now: " + tracked.saturation_threshold);
  }
  if (key == 's' && tracked != null) {
    tracked.saturation_threshold -= 5;
    println("The saturation threshold is now: " + tracked.saturation_threshold);
  }
  if (key == 'e' && tracked != null) {
    tracked.brightness_threshold += 5;
    println("The brightness threshold is now: " + tracked.brightness_threshold);
  }
  if (key == 'd' && tracked != null) {
    tracked.brightness_threshold -= 5;
    println("The brightness threshold is now: " + tracked.brightness_threshold);
  }
  if (keyCode == UP) {
    mirrored = !mirrored;
  }
  if (keyCode == LEFT) {
    sobelFiltered = !sobelFiltered;
  }
  if (keyCode == DOWN) {
    hsbFiltered = !hsbFiltered;
  }
}