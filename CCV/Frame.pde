class Frame {
  
  color[] screen;
  PImage img;

  /**
   *Constructs a Frame object
   *@param PImage
   */
  public Frame(PImage img) {
    screen = img.pixels;  //save array of pixels 
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
  int getSize() {
    return screen.length;
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
   *Sets the color of the pixel at the given position
   *@param int xcor, int ycor, color color
   *@return previous color
   */
   color setColor(int xcor, int ycor, color col) {
     color tmp = getColor(xcor, ycor);
     screen[CCVMath.getXY(xcor, ycor, img.width)] = col;
     return tmp;
   }
   
  /**
   *Swap colors
   *@param color x1,y1,x2,y2
  */
  void swapColors(int x1, int y1, int x2, int y2) {
    color tmp = setColor(x1,y1, getColor(x2, y2));
    setColor(x2, y2, tmp);
  }
   

  /**
   *Gets the width of the frame
   *@return int
   */
  int getWidth() {
    return img.width;
  }
  
  //mirrors the image on the screen
  void mirror(){
    //for every row:
    int length = 0;
    if (img.width != 0) {
      length = screen.length/img.width;
    }
    for (int i = 0; i <length; i++) {
      for (int j = 0; j <img.width/2; j++) {
        frm.swapColors(j, i, img.width-j-1, i);
      }
    }
}