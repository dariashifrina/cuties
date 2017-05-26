class Frame {
  color[] screen;
  PImage img;

  public Frame(PImage img) {
    screen = img.pixels;  //create array of pixels 
    this.img = img; //save PImage;
  }

  color getColor(int xcor, int ycor) {
    return screen[CCVMath.getXY(xcor, ycor, img.width)];
  }
}