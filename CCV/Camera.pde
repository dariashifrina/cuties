class Camera implements VideoStream {
  Capture cam;
  int counter = 0;
  
  Camera(PApplet app) {
    String[] cameras = Capture.list();
    if (cameras.length <= 0) app.exit(); //if there isn't a camera, then exit the program
    else {
      cam = new Capture( app); //if there is a camera, initialize it as a new camera object
      println("Using camera: " + cameras[0]);
      println(cameras);
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
    else{
      //println("no frame");
      counter++;
      return createImage(1280,720,0);
    }
    return (PImage) cam;
  }
}