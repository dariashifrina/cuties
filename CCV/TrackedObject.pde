//class TrackedObject {
//  color chosenColor; //selected color of the pixel
//  PShape shape; //polygon shape of the object
//  ArrayList objectContained; //collection of object pixels
//  int pixPos; //position of pixel
//  Frame frame; 


//  /**
//   *Constructs the TrackedObject
//   *@param int, int, Frame
//   */
//  TrackedObject(int xcor, int ycor, Frame frame)
//  { 
//    this.frame = frame;
//    this.pixPos = CCVMath.getXY(xcor, ycor, frame.getWidth()); //save the target pixel's location in 1d not 2d
//    chosenColor = frame.getColor(pixPos); //access the color of the target pixel
//    objectContained = new ArrayList();
//  }

//  /**
//   *Creates a polygon outline of the object on the current frame
//   */
//  void draw()
//  {
//    buildObject();
//  }

//  /**
//   *Finds the pixels of the tracked object and adds them to the objectContained array
//   *@return void
//   */
//  void buildObject()
//  {
//  }


//  /**
//   *Gets the positions of the neighboring pixels in the order up, down, left, right
//   *@return int[]
//   */
//  private int[] getNeighbors(int pix)
//  {
//  }

//  /**
//   *Gets the edge pixels of the object
//   *@return int[]
//   */
//  int[] getExtremes()
//  {
//  }
//}