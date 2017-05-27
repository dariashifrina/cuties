static class CCVMath {  

  /**
   *Returns the parameter for a linear screen given 2d coords
   *@params int xcor, int ycor, int screen width
   *@return int
   */
  static int getXY(int xcor, int ycor, int width) {
    return xcor + (ycor*width);
  }
}