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

  void draw() {
    image(img, 0, 0);
  }
  //========================Helper Functions========================
  int getSize() {
    return screen.length;
  }

  /**
   *Gets the color of the pixel at the given position
   *@param int xcor, int ycor
   *@return color
   */
  color getColor(int[] coords) {
    return screen[CCVMath.getXY(coords, img.width)];
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
   *Sets the color of the pixel at the given position
   *@param int xcor, int ycor, color color
   *@return previous color
   */
  color setColor(int[] coords, color col) {
    color tmp = getColor(coords);
    screen[CCVMath.getXY(coords, img.width)] = col;
    return tmp;
  }

  /**
   *Swap colors
   *@param color x1,y1,x2,y2
   */
  void swapColors(int[] coords1, int[] coords2) {
    color tmp = setColor(coords1, getColor(coords2));
    setColor(coords2, tmp);
  }


  /**
   *Gets the width of the frame
   *@return int
   */
  int getWidth() {
    return img.width;
  }

  int getHeight() {
    return img.height;
  }

  //========================Helper Functions========================

  //========================Major Methods========================
  //mirrors the image on the screen
  void mirror() {
    //for every row:
    int[] coords1 = new int[2];
    int[] coords2 = new int[2];
    int length = 0;
    if (img.width != 0) {
      length = screen.length/img.width;
    }
    for (int i = 0; i <length; i++) {
      for (int j = 0; j <img.width/2; j++) {
        coords1[0] = j;
        coords1[1] = i;
        coords2[0] = img.width-j-1;
        coords2[1] = i;
        swapColors(coords1, coords2);
      }
    }
  }

  //performs the sobel edge detection operation on the frame
  void sobelFilter() {
    int[][] mat=new int[3][3];
    int[]  coord = new int[2];
      for (int i=1; i< getWidth()-1; i++) {
        for (int j=1; j< getHeight()-1; j++) {
          coord[0] = i-1;
          coord[1] = j-1;
          mat[0][0] = (int)red(getColor( coord ));
          coord[0] = i-1;
          coord[1] = j;
          mat[0][1] = (int)red(getColor( coord ));
          coord[0] = i-1;
          coord[1] = j+1;  
          mat[0][2] = (int)red(getColor( coord ));
          coord[0] = i;
          coord[1] = j-1;  
          mat[1][0] = (int)red(getColor( coord ));
          coord[0] = i;
          coord[1] = j+1;  
          mat[1][2] = (int)red(getColor( coord ));
          coord[0] = i+1;
          coord[1] = j-1;  
          mat[2][0] = (int)red(getColor( coord ));
          coord[0] = i+1;
          coord[1] = j;  
          mat[2][1] = (int)red(getColor( coord ));
          coord[0] = i+1;
          coord[1] = j+1;  
          mat[2][2] = (int)red(getColor( coord ));
          int edge = (int)convolution(mat);
          coord[0] = i;
          coord[1] = j;
          color old = getColor(coord);
          setColor(coord, edge);
          //setColor(coord, old);
        }
      }
    }

  //Convolutes the matrix according to the kernel x and kernel y matrices in the sobel operation
  public double convolution(int[][] mat) {
    int gy=(mat[0][0]*-1)+(mat[0][1]*-2)+(mat[0][2]*-1)+(mat[2][0])+(mat[2][1]*2)+(mat[2][2]*1);
    int gx=(mat[0][0])+(mat[0][2]*-1)+(mat[1][0]*2)+(mat[1][2]*-2)+(mat[2][0])+(mat[2][2]*-1);
    return Math.sqrt(Math.pow(gy, 2)+Math.pow(gx, 2));
  }
  //========================Major Methods========================
}