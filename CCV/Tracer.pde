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
  //xcor of first tracked object center point in trace
  int xcorFirst() {
    return CCVMath.getXY(trace.getFirst(), img.width)[0];
  }
  //ycor of first tracked object center point in trace

  int ycorFirst() {
    return CCVMath.getXY(trace.getFirst(), img.width)[1];
  }
  //xcor of second tracked object center point in trace

  int xcorSecond() {
    int placeHolder = trace.removeFirst();
    int secondPos = trace.getFirst();
    trace.offerFirst(placeHolder);
    return CCVMath.getXY(secondPos, img.width)[0];
  }

  //ycor of second tracked object center point in trace

  int ycorSecond() {
    int placeHolder = trace.removeFirst();
    int secondPos = trace.getFirst();
    trace.offerFirst(placeHolder);
    return CCVMath.getXY(secondPos, img.width)[1];
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
    int[] unpacked = new int[trace.size()];
    for(int i = 0; i < trace.size(); i++){
      int[] temp = CCVMath.getXY(trace.removeFirst(), img.width); //get the xy coordinates
      temp[0] = img.width-temp[0];//mirror the x
      unpacked[i] = CCVMath.getXY(temp, img.width);//stick the coordinates into this temp array in linear coordinates
    }
    for(int i:unpacked){
      trace.addLast(i);//readd everything back, but mirrored
    }
  }   
}