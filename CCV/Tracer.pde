//line tracing class for tracked object
/*idea & working on now: connect first 2 points in the tracer deque to form a line. 
as more points are added, keep connecting the most recent 2 points to form a jagged line.
***next:
as it approaches a limit of maybe 100 items in trace, start removing points and lines that were initially drawn to keep an updated version.
*/

class Tracer {
  //int stroke;
  Deque<Integer> trace;  
//constructor. initializes deque that holds center points of tracked object through past 100 frames.
  Tracer() {
    trace = new LinkedList<Integer>();
    //stroke = 1;
  }
//if there are more than 2 points present in 
  void draw() {
    if (trace.size() > 1) {
      strokeWeight(30);
      line(xcorFirst(), ycorFirst(), xcorSecond(), ycorSecond());
      stroke(126);
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
    trace.add(pixPos);
  }
}