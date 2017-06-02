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

//gets 3d color distance
  //static float colorDist(color c1, color c2)
  //{
  //  float r1 = red(c1);
  //  float r2 = red(c2);
  //  float g1 = green(c1); 
  //  float g2 = green(c2);
  //  float b1 = blue(c1);
  //  float b2 = blue(c2);
  //  float dist = pow(r2-r1,2)+pow(g2-g1, 2)+pow(b2-b1,2);
  //  return dist;
  //}
}