class Camera extends Video {
  Capture cam;
  PApplet ccv;
  Camera(PApplet app) {
    ccv = app;
    String[] cameras = Capture.list();
    if (cameras.length <= 0) ccv.exit();
    else {
      cam = new Capture( app, cameras[0]);
      cam.start();
    }
  }
  PImage getImage() {
    if (cam.available()) {
      cam.read();
    }
    return (PImage) cam;
  }
}