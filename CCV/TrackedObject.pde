import java.util.*;
class TrackedObject {
  Frame frame; 
  ArrayList<Integer> objectContained; //collection of object edge pixels
  color chosenColor; //selected color of the pixel
  int pixPos; //position of pixel
  int color_threshold;//maximum value to consider a pixel similar to the object pixel
  boolean[] traversed; //maps to the frame for the pixels traversed. if a pixel is true, it has been traversed on


  //  /**
  //   *Constructs the TrackedObject
  //   *@param int, int, Frame
  //   */
  TrackedObject(int xcor, int ycor, Frame frame)
  { 
    this.frame = frame;
    int[] coords = {xcor, ycor};
    pixPos = CCVMath.getXY(coords, frame.getWidth()); //save the target pixel's location in 1d not 2d
    chosenColor = frame.getColor(pixPos); //access the color of the target pixel
    objectContained = new ArrayList(100);//arbitrary size but the object will certaintly be greater than 10 pixels
    traversed = new boolean[frame.getSize()];
    color_threshold = 1500;
  }

  //  /**
  //   *Creates a polygon outline of the object on the current frame
  //   */
  void draw(Frame frm)
  {
    objectContained = new ArrayList(100);
    if (update(frm)) {//if it was successful in updating the object with the new frame, then display it
      //assembles the arraylist containing the desired indices:
      color red = color(255, 0, 0);
      for (int i : objectContained) {
        int[] coords = CCVMath.getXY(i, frame.getWidth());
        set(coords[0], coords[1], red);
      }
    }
  }

  //Does all of the work. Given a new frame it saves this frame, finds the center of the object from the previous frame and then uses it on the new frame to try and find an edge of the object, when it does, it builds the object by surfing the edge
  boolean update(Frame frm) {
    frame = frm;
    //frame.blur(1)//perform a small Gaussian blue on the frame to get rid of possible inconsistencies
    boolean success = buildObject();//builds an object after finding an object pixel using the center
    if (success) {
      centerPixPos();//set the reference pixel for the next frame to the center of the object in this frame
    }
    traversed = new boolean[frame.getSize()];//reset the boolean screen
    return success;
  }

  //=======================Helper Functions ================================
  //Travels around the edge of the object, adding the edges pixel positions to the objectContained list
  boolean buildObject() {
    int edgePix = spread(pixPos);
    if (edgePix == -1) {
      return false;
    }
    addObjPix(edgePix);
    return true;
  }

  //returns if the colors at two locations are similar(uses the 3 dimensional color distance assuming that each color is a plane corresponding to x, y, z)
  boolean isSimilar(int p1) {
    color c1 = frame.getColor(p1);
    float r = red(chosenColor) - red(c1);
    float g = green(chosenColor) - green(c1);
    float b = blue(chosenColor) - blue(c1);
    float dist = pow(r, 2)+pow(g, 2)+pow(b, 2);
    return dist < color_threshold;
  }

  boolean addObjPix(int pos) {
    for(int i = pos; i < frame.getSize(); i++){
      if(isSimilar(i)){
        objectContained.add(i);
      }
    }
    return true;
    //traversed[pos] = true;//this pixel has been traversed;
    //ArrayList<Integer> neighbors = getValidNeighbors(pos);
    //for (int i : neighbors) { //iterate through the neighbors
    //  if (isSimilar(i)) {
    //    objectContained.add(i);
    //    addObjPix(i);
    //  }
    //}
    //return true;
  }

  //Spreads the traversal from itself to its neighbors. returns the edge pixel of the object. if it couldnt find an object pixel, returns -1;
  int spread(int pos) {
    for (int i = 0; i < frame.getSize(); i++) {
      if (isSimilar(i)) {
        return i;
      }
    }
    return -1;
    //  traversed[pos] = true;//this pixel has been traversed;
    //  //ArrayList<Integer> neighbors = getValidNeighbors(pos);
    //  //for (int i : neighbors) { //iterate through the neighbors
    //  //  if (isSimilar(i)) {
    //  //    return i;
    //  //  }
    //  //  return spread(i);
    //  //}
    //  //return -1;
  }
  //
  //returns the neighboring pixels that havent been traversed
  ArrayList<Integer> getValidNeighbors(int pos) {
    ArrayList<Integer> valid = new ArrayList(); //arraylist where the valid neighbors are stored(could be 0, could be 4, so arraylist is easier
    int[] coords = CCVMath.getXY(pos, frame.getWidth()); //get the x, y coords of this point
    int row = coords[0];
    int column = coords[1];
    if (column > 0 && traversed[pos-1] != true) {//if it isnt at the starting edge of the row and it hasnt been traveled... 
      valid.add(pos-1);
    }

    if (column < frame.getWidth()-1 && traversed[pos+1] != true) {//if it isnt at the ending edge of the row and it hasnt been traversed...
      valid.add(pos+1);
    }

    if (row > 1 && traversed[pos-frame.getWidth()] != true) {//if it isnt at the top of the screen and the top pixel hasnt been traversed...
      valid.add(pos-frame.getWidth());
    }
    if (row < frame.getHeight() && traversed[pos+frame.getWidth()] != true) {//if it isnt at the bottom of the screen and the bottom pixel hasnt been traversed
      valid.add(pos + frame.getWidth());
    }
    return valid;
  }

  //Finds the center of the object by summing the coordinates of the edge pixels. If buildObject wasnt successful, it uses the previous frame's position again because that is the object's last known position
  void centerPixPos() {
    int sumX = 0;
    int sumY = 0;
    if (objectContained.size() > 0) {
      int[] coords = new int[2];//if the object failed, this makes it start in the top left corner
      for (int i : objectContained) {//iterate through the edge pixels
        coords = CCVMath.getXY(i, frame.getWidth());//convert the edge pixel into x, y coords
        sumX += coords[0];
        sumY += coords[1];
      }
      coords[0] = sumX/objectContained.size();
      coords[1] = sumY/objectContained.size();
      pixPos = CCVMath.getXY(coords, frame.getWidth());
    }
  }
  
  void changeThreshold(int delta){
    color_threshold += delta;
    print("Color threshold = " + color_threshold);
  }
}