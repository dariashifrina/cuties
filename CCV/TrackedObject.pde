import java.util.*;
class TrackedObject {
  Frame frame; 
  ArrayList<Integer> objectContained; //collection of object edge pixels
  color chosenColor; //selected color of the pixel
  int pixPos; //position of pixel
  int _threshold;//maximum value to consider a pixel similar to the object pixel
  boolean[] traversed//maps to the frame for the pixels traversed. if a pixel is true, it has been traversed on


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
    traversed = new boolean[frame.getSize()];
    _threshold = 100;
  }

  //  /**
  //   *Creates a polygon outline of the object on the current frame
  //   */
  void draw()
  {
    //assembles the arraylist containing the desired indices:
    buildObject(pixPos);
    color red = color(0, 0, 0);
    for (int i : objectContained) {
      int[] coords = CCVMath.getXY(i, frame.getWidth());
      set(0, 0, red);
    }
  }

  //Does all of the work. Given a new frame it saves this frame, finds the center of the object from the previous frame and then uses it on the new frame to try and find an edge of the object, when it does, it builds the object by surfing the edge
  void update(Frame frm) {
    frame = frm;
    buildObject(findObjPix());//builds an object after finding an object pixel using the center
  }

  //=======================Helper Functions ================================
  //Travels around the edge of the object, adding the edges pixel positions to the objectContained list
  boolean buildObject(int pos) {  
    return true;
  }

  //core traversal algo. expands from the center of the object and tries to find an edge pixel of the object.
  boolean findObjPix() {
  }

  //returns if the colors at two locations are similar(uses the 3 dimensional color distance assuming that each color is a plane corresponding to x, y, z)
  boolean isSimilar(int p1) {
    color c1 = frame.screen[p1];
    float r = red(chosenColor) - red(c1);
    float g = green(chosenColor) - green(c1);
    float b = blue(chosenColor) - blue(c1);
    float dist = pow(r, 2)+pow(g, 2)+pow(b, 2);
    return dist < _threshold;
  }

  //Spreads the traversal from itself to its neighbors
  boolean spread(int pos) {
    traversed[pos] = true;//this pixel has been traversed;
    ArrayList<Integer> neighbors = getValidNeighbors(pos);
    for (int i : getValidNeighbors) {
      if(isSimilar(frame.getColor(i))){
        return true;
      }
      spread(i);
    }
  }

  ArrayList<Integer> getValidNeighbors(int pos) {
    ArrayList<Integer> valid = new ArrayList(); //arraylist where the valid neighbors are stored
    int[] coords = CCVMath.getXY(pos, frame.getWidth()); //get the x, y coords of this point
    int row = coords[0];
    int column = coords[1];

    if (column > 0 && traversed[pos-1] != true) {//if it isnt at the starting edge of the row and it hasnt been traveled... 
      valid.add(pos-1);
    }

    if (column < frame.getWidth()-1 && traversed[pos+1] != true) {//if it isnt at the ending edge of the row and it hasnt been traversed...
      valid.add(pos+1);
    }

    if (row > 0 && traversed[pos-frame.getWidth()] != true) {//if it isnt at the top of the screen and the top pixel hasnt been traversed...
      valid.add(pos-frame.getWidth());
    }
    if (row < frame.getHeight() && traversed[pos+frame.getWidth()] != true) {
      valid.add(pos + frame.getWidth());
    }
    return valid;
  }



  //void buildObject(int pos)
  //{
  //  //gets an array of all the edges:
  //  LinkedList<Integer> edges = getEdges(pos);
  //  for (int i: edges) objectContained.add(i);
  //}


  ////  /**
  ////   *Gets the positions of the neighboring pixels in the order up, down, left, right INSIDE THE 
  ////   *@return int[]
  ////   */

  //  //if (pos-frame.getWidth() >= 0 && pos-frame.getWidth() <= frame.getSize() && isSimilar(pos-frame.getWidth(), pos)) {

  ////private ArrayList<Integer> getNeighbors(int pos)
  ////{
  ////  ArrayList<Integer> ret = new ArrayList<Integer>(4);
  ////  //if is in the correct bounds, and it matches the general color, add it to the neighbors that can be checked.
  ////  //pixel above
  ////  if (pos-frame.getWidth() >= 0 && pos-frame.getWidth() <= frame.getSize() && isSimilar(pos-frame.getWidth(), pos)) {
  ////    ret.add(pos-frame.getWidth());
  ////  }
  ////  //pixel below
  ////  if (pos+frame.getWidth() >= 0 && pos+frame.getWidth() <= frame.getSize() && isSimilar(pos+frame.getWidth(), pos)) {
  ////    ret.add(pos+frame.getWidth());
  ////  }
  ////  //to the left:
  ////  if (pos-1 >= 0 && pos-1 <= frame.getSize() && isSimilar(pos-1, pos)) {
  ////    ret.add(pos-1);
  ////  }
  ////  //to the right:
  ////  if (pos+1 >= 0 && pos+1 <= frame.getSize() && isSimilar(pos+1, pos)) {
  ////    ret.add(pos+1);
  ////  }
  ////  //mark already visited spots as already visited
  ////  visited[pos]=true;
  ////  return ret;
  ////}


  ////  /**
  ////   *Gets the indices of the edge pixels of the object
  ////   *@return ArrayList<Integer>
  ////   */
  //  LinkedList<Integer> getEdges(int pos) {

  //  //REWRITE THIS WITH OUR OWN LINKEDLIST IMPLEMENTATION LATER:
  //    LinkedList ret = new LinkedList<Integer>();
  //    //getNeighbors: gives you an ArrayList of ALL the neighbors
  //    //if the length of the returned arraylist is less than 4, that means one of the direct neighbors isnt part of the object, so it's an edge. Add it's pos to the arraylist of edges.
  //    //start at the index pixPos:
  //    //if you're an edge, add yourself to the list of edges:
  //    ArrayList<Integer> neighbors = getNeighbors(pos);
  //    if (neighbors.size() < 4) ret.add(pos);
  //    for (int i: neighbors) {
  //          if (!visited[i]) ret.addAll(getEdges(i));
  //    }
  //    //if youre a neighbor thats not been checked for edges yet, get checked for edges:
  //    return ret;
  //  }

  //   ArrayList<Integer> objectContained = tracked.edges(); 
  //    color red = color(0, 255, 0);
  //    for (int i : objectContained) {
  //      int[] coords = CCVMath.getXY(i, frame.getWidth());
  //      set(coords[0], coords[1], red);
}