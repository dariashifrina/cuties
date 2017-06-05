import java.util.*;
class TrackedObject {
  Frame frame; 
  Deque<Integer> trace; //trace
  ArrayList<Integer> objectContained; //collection of object edge pixels
  color chosenColor; //selected color of the pixel
  int pixPos; //position of pixel
  int hue_threshold;//increases 2 level threshold range for hue
  int saturation_threshold;//increases 2 level threshold range for saturation
  int brightness_threshold;//increases 2 level threshold range for brightness

  //  /**
  //   *Constructs the TrackedObject
  //   *@param int, int, Frame
  //   */
  TrackedObject(int xcor, int ycor, Frame frame)
  { 
    this.frame = frame;
    trace = new LinkedList<Integer>();
    int[] coords = {xcor, ycor};
    pixPos = CCVMath.getXY(coords, frame.getWidth()); //save the target pixel's location in 1d not 2d
    chosenColor = frame.getColor1(pixPos); //access the color of the target pixel
    objectContained = new ArrayList(100);//arbitrary size but the object will certaintly be greater than 10 pixels
    hue_threshold = 80; //through experimentation
    saturation_threshold = 80;
    brightness_threshold = 80;
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
      //color green = color(0, 255, 0);
      //for (int n : trace) {
      //  int[] coords = CCVMath.getXY(n, frame.getWidth());
      //  set(coords[0],coords[1],green);
      //}
    }
  }

  //Does all of the work. Given a new frame it saves this frame, finds the center of the object from the previous frame and then uses it on the new frame to try and find an edge of the object, when it does, it builds the object by surfing the edge
  boolean update(Frame frm) {
    frame = frm;
    frame.binaryInRangeFilter(chosenColor, hue_threshold, saturation_threshold, brightness_threshold);
    boolean success = buildObject();//builds an object after finding an object pixel using the center
    if (success) {
      centerPixPos();//set the reference pixel for the next frame to the center of the object in this frame
    }
    return success;
  }

  //=======================Helper Functions ================================
  //Travels around the edge of the object, adding the edges pixel positions to the objectContained list
  boolean buildObject() {
    for (int i = 0; i < frame.getSize(); i++) {
      if (frame.getColor(i) == color(255)) {
        objectContained.add(i);
      }
    }
    if (objectContained.size() < frame.getSize()/(50000)) {
      return false;
    }
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
      trace.add(pixPos);
    }
  }

  void changeThreshold(int delta) {
    color_threshold += delta;
    print("Color threshold = " + color_threshold);
  }
}