class Frame {
  
  color[] screen;
  PImage img;

  /**
   *Constructs a Frame object
   *@param PImage
   */
  public Frame(PImage img) {
    screen = img.pixels;  //create array of pixels 
    this.img = img; //save PImage;
  }

  /**
   *Gets the color of the pixel at the given position
   *@param int 1D position of pixel
   *@return color
   */
  color getColor(int pos) {
    return screen[pos];
  }

  /**
   *Gets the color of the pixel at the given position
   *@param int xcor, int ycor
   *@return color
   */
  color getColor(int xcor, int ycor) {
    return screen[CCVMath.getXY(xcor, ycor, img.width)];
  }

  /**
   *Gets the width of the frame
   *@return int
   */
  int getWidth() {
    return img.width;
  }
}