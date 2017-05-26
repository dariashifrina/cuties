class Frame {
  byte[][][] colors;
  byte[][][] screen;
  
  byte[] getColor(int xcor, int ycor) {
    return screen[xcor][ycor];
  }
}