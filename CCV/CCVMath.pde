static class CCVMath {  

  //Returns the parameter for a linear screen given 2d coords
  static int getXY(int xcor, int ycor, int width) {
    return xcor + (ycor*width);
  }
}