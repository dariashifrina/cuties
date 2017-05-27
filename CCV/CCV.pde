/* Team Cuties
 * Dasha, James, Gilivr
 * APCS2 Pd3
 */

Frame currentFrame;
Camera in;
TrackedObject tracked;

void setup() {
  size(600, 450);//adjusts the camera resolution
  in = new Camera(this);//pass PApplet to Camera object
}

/**
 *Draws the next image from the camera feed and the outline of the object being tracked
 */
void draw() {
  currentFrame = new Frame(in.getImage());
  image(currentFrame.getImg(), 0, 0);
}

/**
 *Creates a trackedObject at the mouse's position
 */
void mouseClicked() {
  tracked = new TrackedObject(mouseX, mouseY, currentFrame);
}