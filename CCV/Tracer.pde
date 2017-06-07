//line tracing class for tracked object
/*idea & working on now: connect first 2 points in the tracer deque to form a line. 
 as more points are added, keep connecting the most recent 2 points to form a jagged line.
 ***next:
 as it approaches a limit of maybe 100 items in trace, start removing points and lines that were initially drawn to keep an updated version.
 */

class Tracer {
  //int stroke;
  Deque<Integer> trace;  
  int maxPoints;
  
  //constructor. initializes deque that holds center points of tracked object through past 100 frames.
  Tracer() {
    trace = new LinkedList<Integer>();
    maxPoints = 20;
  }
  //if there are more than 2 points present in 
  void draw() {
    if (trace.size() > 1) {
      Iterator<Integer> itr = trace.iterator();
      int[] dummy = null;
      int[] coords = null;
      while (itr.hasNext()) {    
        strokeWeight(10);
        stroke(255, 247, 0);
        if (dummy == null) {
          dummy = CCVMath.getXY(itr.next(), img.width);
        } else {
          coords = CCVMath.getXY(itr.next(), img.width);
          line(dummy[0], dummy[1], coords[0], coords[1]);
          dummy = coords;
        }
      }
    }
  }
  //allows for adding center points from tracked object class
  void addPoint(int pixPos) {
    if (trace.size() > maxPoints) {
      trace.removeLast();
    }
    trace.addFirst(pixPos);
  }
  
  //in the case that the screen gets mirrored, so do the previous points
  void mirror(){
    int n = trace.size();
    //for every number, we want to take it from one end (ie the back) then bring it back in the other, except modified
    for(int i = 0; i < n; i++){
      int[] temp = CCVMath.getXY(trace.removeFirst(), img.width); //get the xy coordinates
      temp[0] = img.width-temp[0];//mirror the x
      trace.addLast( CCVMath.getXY(temp, img.width)) ;//stick the coordinates back from the other side.
  }
  }   
}