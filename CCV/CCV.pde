/* Team Cuties
 * Dasha, James, Gilivr
 * APCS2 Pd3
 */

Frame currentFrame;
VideoStream in;
PImage img;
//TrackedObject tracked;
int state; //0 = in user prompt, 1 = camera, 2 = movie
UserMenu menu;

void setup() {
  size(600,450);//adjusts the camera resolution
  state = 0;
  menu = new UserMenu(width, height);
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
    //if (tracked != null) { //if there is a trackedObject, display it
    // tracked.draw();
    //}
    image(img, 0, 0); //Display the image
  }
}


/**
 *Creates a trackedObject at the mouse's position
 */
void mouseClicked() {
  if (state == 0) {
    state = menu.mouseClicked();
  } else {
//    tracked = new TrackedObject(mouseX, mouseY, currentFrame);
  }
}