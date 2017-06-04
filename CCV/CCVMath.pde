static class CCVMath {  

  /**
   *Returns the parameter for a linear screen given 2d coords
   *@params int xcor, int ycor, int screen width
   *@return int
   */
  static int getXY(int[] coords, int width) {
    return coords[0] + (coords[1]*width);
  }
  
  
  //returns {x, y} given single coord
  static int[] getXY(int coord, int width) {
    int[] ret = new int[2];
    ret[0] = coord%width;
    ret[1] = floor(coord/width);
    return ret;
  }
}