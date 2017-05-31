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

void setup() {
  size(1920, 1080);//adjusts the camera resolution
  frameRate(60);
  state = 0;
  menu = new UserMenu(width, height);
  in = null;
}

/**
 *Draws the next image from the camera feed and the outline of the object being tracked.
 */
void draw() {
  //user setup loop
  if (state == 0) {
    background(0, 0, 0);
    menu.draw();
  }

  //Main loop
  else {
    img = in.getImage();//get the camera's frame
    currentFrame = new Frame(img);//turn that image into a frame for a possible trackedObject
    //img.loadPixels();
    //mirror image
    color[] pixels = img.pixels;
    //for every row:
    int length = 0;
    if (img.width != 0) {
      length = pixels.length/img.width;
    }
    for (int i = 0; i <length; i++) {
      for (int j = 0; j <img.width/2; j++) {
        currentFrame.swapColors(j, i, img.width-j-1, i);
      }
    }
    //img.updatePixels();
    if (tracked != null) { //if there is a trackedObject, display it
      tracked.draw();
    }
    image(img, 0, 0); //Display the image
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