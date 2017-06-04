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

void setup() {
  size(600, 480);//adjusts the camera resolution
  background(0);
  surface.setResizable(true);
  frameRate(60);
  state = 0;
  menu = new UserMenu(width, height);
  in = null;
  sobel_threshold = 224;//color threshold to divide the pixels among their local gradient
  color_threshold = 200;//maximum threshold value to consider a pixel similar to another
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
    //background(0,0,0);
    img = in.getImage();//get the camera's frame
    currentFrame = new Frame(img);//turn that image into a frame for a possible trackedObject
    currentFrame.mirror(); //mirror the picture
    currentFrame.sobelFilter(sobel_threshold);
    currentFrame.draw(); //Display the image
    if (tracked != null) { //if there is a trackedObject, display it
      tracked.draw(currentFrame);//update the object with the new frame and draw it
    }
    System.gc();
  }
}



/**
 *Creates a trackedObject at the mouse's position
 */
void mouseClicked() {
  if (state == 0) { //if you are in the user menu
    int toBeState; //Handles threading in the case of state 2 so the draw method doesn't get ahead of the mouseClicked()
    toBeState = menu.mouseClicked(); //calls mouseClicked of menu to check if the mouse is in the buttons
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
  if (keyCode == UP) {
    sobel_threshold += 2;
    println(sobel_threshold);
  }
  if (keyCode == DOWN) {
    sobel_threshold -=2;
    println("The Sobel threshold is: " + sobel_threshold);
  }
}