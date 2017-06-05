class Frame {
  color[] screen;
  color[] nonFiltered;
  color[] filtered;
  PImage img;

  /**
   *Constructs a Frame object
   *@param PImage
   */
  public Frame(PImage img) {
    this.img = img; //save PImage;
    screen = img.pixels;  //save array of pixels
    filtered = new color[screen.length];
    nonFiltered = new color[screen.length];
    arrayCopy(screen, nonFiltered);
  }

  void draw(color[] type) {
    img.pixels = type;
    image(img, 0, 0);
  }

  //========================Helper Functions========================
  int getSize() {
    return screen.length;
  }

  PImage getImage() {
    return img;
  }

  /**
   *Gets the color of the pixel at the given position
   *@param int xcor, int ycor
   *@return color
   */
  color getColor(int[] coords) {
    return screen[CCVMath.getXY(coords, img.width)];
  }
  color getColor1(int pos) {
    return nonFiltered[pos];
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
   arrayCopy(screen, nonFiltered);
  }

  //uses a double threshold HSB to create a binary image in which the white is lower<color<upper
  void binaryInRangeFilter(color c1, int delta1, int delta2, int delta3) {
    float h = hue(c1);
    float s = saturation(c1);
    float b = brightness(c1);
    float[] lowerThresh = {h-delta1, s-delta2, b-delta3};
    float[] upperThresh = {h+delta1, s+delta2, b+delta3};
    for (int i = 0; i < getSize(); i++) {
      if (inRange(getColor(i), lowerThresh, upperThresh)) { //if the color is within the threshold range
        filtered[i] = color(255); //set it to white
      } else {
        filtered[i] = color(0); //set to black
      }
    }
    img.pixels = filtered;
    screen = filtered;
    img.filter(ERODE);
    img.filter(DILATE);
  }

  //returns true if the color is within the ranges for hue, saturation, and brightness
  boolean inRange(color c, float[] lower, float[] upper) {
    return (lower[0] < hue(c) && hue(c) < upper[0]) && (lower[1] < saturation(c) && saturation(c) < upper[1]) && (lower[2] < brightness(c) && brightness(c) < upper[2]);
  }

  int[][] kernel(int n, int[] coords) {
    int x = coords[0];
    int y = coords[1];
    int ysgn = 1;
    int xsgn = 1;
    //return a kernel with n elements on each side of the center, if edge assume mirror
    int[][] k = new int[n*2+1][n*2+1];
    //from top left to bottom right:
    for (int i = -n; i <=n; i++) {
      //if out of array bounds because negative, use a mirror:
      ysgn = 1;
      if (i+y < 0) ysgn = -1;
      for (int j = -n; j <= n; j++) {
        xsgn = 1;
        //if out of array bounds because negative, use a mirror:
        if (j+x < 0) xsgn = -1;
        coords[0]= (xsgn*(j+x)); //x coord
        coords[1]=(ysgn*(i+y)); //y coord
        k[i+n][j+n] = (int)brightness(getColor( coords ));
      }
    }
    return k;
  }

  //performs the sobel edge detection operation on the frame
  void sobelFilter(int threshold) {
    img.filter(BLUR, 2);
    img.filter(GRAY);//convert to grayscale for the gradient
    int[][] mat=new int[3][3];
    int[]  coord = new int[2];
    for (int i=1; i< getWidth()-1; i++) {
      for (int j=1; j< getHeight()-1; j++) { //iterate through each pixel and get its neighbors. Get their intensities to form a color matrix to approximate the local intensity vector gradient
        //coord[0] = i-1;
        //coord[1] = j-1;
        //mat[0][0] = (int)brightness(getColor( coord ));
        //coord[0] = i-1;
        //coord[1] = j;
        //mat[0][1] = (int)brightness(getColor( coord ));
        //coord[0] = i-1;
        //coord[1] = j+1;  
        //mat[0][2] = (int)brightness(getColor( coord ));
        //coord[0] = i;
        //coord[1] = j-1;  
        //mat[1][0] = (int)brightness(getColor( coord ));
        //coord[0] = i;
        //coord[1] = j+1;  
        //mat[1][2] = (int)brightness(getColor( coord ));
        //coord[0] = i+1;
        //coord[1] = j-1;  
        //mat[2][0] = (int)brightness(getColor( coord ));
        //coord[0] = i+1;
        //coord[1] = j;  
        //mat[2][1] = (int)brightness(getColor( coord ));
        //coord[0] = i+1;
        //coord[1] = j+1;  
        //mat[2][2] = (int)brightness(getColor( coord ));
        coord[0] = i;
        coord[1] = j;
        mat = kernel(1, coord);
        int edge = (int)convolution(mat);
        if (edge >= threshold) {
          edge = 255;
        }
        if (edge < threshold) {
          edge = 0;
        }
        filtered[i + j*img.width] =  color(edge);
      }
    }
  }

  //Convolutes the matrix according to the kernel x and kernel y derivative matrices in the sobel operation to form a vector gradient number
  public double convolution(int[][] mat) {
    int gy=((mat[0][0]*-3)+(mat[0][1]*-10)+(mat[0][2]*-1)+(mat[2][0])+(mat[2][1]*10)+(mat[2][2]*3))/6;
    int gx=((mat[0][0])+(mat[0][2]*-3)+(mat[1][0]*10)+(mat[1][2]*-10)+(mat[2][0])+(mat[2][2]*-3))/6;
    return Math.sqrt(Math.pow(gy, 2)+Math.pow(gx, 2));
  }

  public void dilate() {
    //target value is white because it is a binary image with white being the object
    int targetValue = 255;
    int reverseValue = 0; //reverse of white is black :)

    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        //For BLACK pixel RGB all are set to 0 and for WHITE pixel all are set to 255.
        int[] coords = {x, y};
        if (red(getColor(coords)) == targetValue) {
          /*
        3x3 kernel
           * [1, 1, 1
           *  1, 1, 1
           *  1, 1, 1]
           */
          boolean flag = false;   //this will be set if a pixel of reverse value is found in the mask
          for (int ty = y - 1; ty <= y + 1 && flag == false; ty++) {
            for (int tx = x - 1; tx <= x + 1 && flag == false; tx++) {
              if (ty >= 0 && ty < img.height && tx >= 0 && tx < img.width) {
                //origin of the mask is on the image pixels
                if (red(getColor(tx+ty*img.width)) != targetValue) {
                  flag = true;
                  filtered[x+y*width] = reverseValue;
                }
              }
            }
          }
          if (flag == false) {//if all of the pixels were the targetvalue
            filtered[x+y*width] = color(targetValue);
          }
        } else {
          filtered[x+y*width] = color(reverseValue);
        }
      }
    }
    img.pixels = filtered; //save filter to the screen
  }
  //========================Major Methods========================
}