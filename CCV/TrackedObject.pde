import java.util.*;
class TrackedObject {
  color chosenColor; //selected color of the pixel
  ArrayList<Integer> objectContained; //collection of object pixels
  int pixPos; //position of pixel
  Frame frame; 
  boolean[] visited;
  int _threshold;
  int[] newCenter;


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
    visited = new boolean[frame.getSize()];
    _threshold = 30;
    newCenter = new int[2];
  }

//  /**
//   *Creates a polygon outline of the object on the current frame
//   */
  void draw()
  {
    //assembles the arraylist containing the desired indices:
    buildObject(pixPos);
    color red = color(0, 0, 0);
    for (int i: objectContained) {
      int[] coords = CCVMath.getXY(i, frame.getWidth());
      set(0, 0, red);
      
    }
  }
  ArrayList<Integer> edges() {
    buildObject(pixPos);
    return objectContained;
  }


//  /**
//   *Finds the pixels of the tracked object and adds them to the objectContained array
//   *@return void
//   */
color getColor( int pos) {
  return frame.getColor(pos);
}

void buildObject(int pos)
{
  //gets an array of all the edges:
  LinkedList<Integer> edges = getEdges(pos);
  for (int i: edges) objectContained.add(i);
}

//returns if the colors at two locations are similar
boolean isSimilar(int p1, int p2) {
    color c1 = frame.screen[p1];
    color c2 = frame.screen[p2];
    float r1 = red(c1);
    float r2 = red(c2);
    float g1 = green(c1); 
    float g2 = green(c2);
    float b1 = blue(c1);
    float b2 = blue(c2);
    float dist = pow(r2-r1,2)+pow(g2-g1, 2)+pow(b2-b1,2);
    return dist < _threshold*_threshold;
}


//  /**
//   *Gets the positions of the neighboring pixels in the order up, down, left, right INSIDE THE 
//   *@return int[]
//   */
private ArrayList<Integer> getNeighbors(int pos)
{
  ArrayList<Integer> ret = new ArrayList<Integer>(4);
  //if is in the correct bounds, and it matches the general color, add it to the neighbors that can be checked.
  //pixel above
  if (pos-frame.getWidth() >= 0 && pos-frame.getWidth() <= frame.getSize() && isSimilar(pos-frame.getWidth(), pos)) {
    ret.add(pos-frame.getWidth());
  }
  //pixel below
  if (pos+frame.getWidth() >= 0 && pos+frame.getWidth() <= frame.getSize() && isSimilar(pos+frame.getWidth(), pos)) {
    ret.add(pos+frame.getWidth());
  }
  //to the left:
  if (pos-1 >= 0 && pos-1 <= frame.getSize() && isSimilar(pos-1, pos)) {
    ret.add(pos-1);
  }
  //to the right:
  if (pos+1 >= 0 && pos+1 <= frame.getSize() && isSimilar(pos+1, pos)) {
    ret.add(pos+1);
  }
  //mark already visited spots as already visited
  visited[pos]=true;
  return ret;
}


//  /**
//   *Gets the indices of the edge pixels of the object
//   *@return ArrayList<Integer>
//   */
  LinkedList<Integer> getEdges(int pos) {
    
  //REWRITE THIS WITH OUR OWN LINKEDLIST IMPLEMENTATION LATER:
    LinkedList ret = new LinkedList<Integer>();
    //getNeighbors: gives you an ArrayList of ALL the neighbors
    //if the length of the returned arraylist is less than 4, that means one of the direct neighbors isnt part of the object, so it's an edge. Add it's pos to the arraylist of edges.
    //start at the index pixPos:
    //if you're an edge, add yourself to the list of edges:
    ArrayList<Integer> neighbors = getNeighbors(pos);
    if (neighbors.size() < 4) ret.add(pos);
    for (int i: neighbors) {
          if (!visited[i]) ret.addAll(getEdges(i));
    }
    //if youre a neighbor thats not been checked for edges yet, get checked for edges:
    return ret;
    
        
  }
}