import processing.video.*;

class Video implements VideoStream {
  Movie mov;

  Video(PApplet app, String fileName) {
    mov = new Movie(app, fileName);
    mov.loop();//when the movie ends, restart it
  }
  
    /**
   *Gets the next image from the Movie feed
   *@return PImage
   */
  PImage getImage() {
    if (mov.available()) {
      mov.read();
    }
    return (PImage)mov;
  }
}