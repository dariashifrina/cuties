class TrackedObject {
  color chosenColor; //selected color of the pixel
  PShape shape; //polygon shape of the object (as a list of vertices)
  ArrayList objectContained; //collection of object pixels
  int pixPos; //position of pixel
  Frame frame; 


//  /**
//   *Constructs the TrackedObject
//   *@param int, int, Frame
//   */
  TrackedObject(int xcor, int ycor, Frame frame)
  { 
    this.frame = frame;
    this.pixPos = CCVMath.getXY(xcor, ycor, frame.getWidth()); //save the target pixel's location in 1d not 2d
    chosenColor = frame.getColor(pixPos); //access the color of the target pixel
    objectContained = new ArrayList();
  }

//  /**
//   *Creates a polygon outline of the object on the current frame
//   */
  void draw()
  {
    buildObject(pixPos);
  }

//  /**
//   *Finds the pixels of the tracked object and adds them to the objectContained array
//   *@return void
//   */
color getColor( int pos) {
  return frame.getColor(pos);
}

void buildObject(int pix)
{
  int[] neighborz = getNeighbors(pix);
  if (colorDist(pix, neighborz[0]) < 2000000)
  {
    objectContained.add(neighborz[0]);
    buildObject(neighborz[0]);
  } 
    if (colorDist(pix, neighborz[1]) < 2000000)
  {
    objectContained.add(neighborz[1]);
    buildObject(neighborz[1]);
  } 
    if (colorDist(pix, neighborz[2]) < 2000000)
  {
    objectContained.add(neighborz[2]);
    buildObject(neighborz[2]);
  } 
    if (colorDist(pix, neighborz[3]) < 2000000)
  {
    objectContained.add(neighborz[3]);
    buildObject(neighborz[3]);
  } 
  else {
    return;
  }
}


//  /**
//   *Gets the positions of the neighboring pixels in the order up, down, left, right
//   *@return int[]
//   */
private int[] getNeighbors(int pix)
{
  int[] retArray = new int[4];
  retArray[0] = pixPos - frame.getWidth();
  retArray[1] = pixPos + frame.getWidth();
  retArray[2] = pixPos - 1;
  retArray[3] = pixPos + 1;
  return retArray;
}


//  /**
//   *Gets the edge pixels of the object
//   *@return int[]
//   */
  int[] getExtremes()
  {
    
  }
}