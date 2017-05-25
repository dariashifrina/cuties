class TrackedObject {
  color chosenColor;
  PShape shape;
  int coolInt;
  byte[][][] objectContained;
  int xcor;
  int ycor;
  Frame frame;

  TrackedObject(int xcord, int ycord)
  { 
    xcor = xcord;
    ycor = ycord;
    byte[] colorArr= frame.get(xcord, ycord);
    chosenColor = new color(colorArr[0], colorArr[1], colorArr[2]);
  }
  void draw()
  {
  }

  byte[][] buildObject()
  {
  }


  private byte[][][] getNeighbors()
  {
  }

  boolean partOf(byte[])
  {
  }

  byte[][][] getExtremes()
  {
  }
}