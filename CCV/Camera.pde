class Camera extends Video {
  Capture cam;
  PApplet ccv; 
  Camera(PApplet app) {
    ccv = app;
    String[] cameras = Capture.list();
    if (cameras.length <= 0) ccv.exit(); //if there isn't a camera, then exit the program
    else {
      cam = new Capture( app, cameras[0]); //if there is a camera, initialize it as a new camera object
      cam.start();
    }
  }

  /**
   *Gets the next image from the Camera feed
   *@return PImage
   */
  PImage getImage() {
    if (cam.available()) {
      cam.read();
    }
    return (PImage) cam;
  }
}