class Camera implements VideoStream {
  Capture cam;
  
  Camera(PApplet app) {
    String[] cameras = Capture.list();
    if (cameras.length <= 0) app.exit(); //if there isn't a camera, then exit the program
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