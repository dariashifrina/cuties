class CCVMath {  

  /**
   *Returns the parameter for a linear screen given 2d coords
   *@params int xcor, int ycor, int screen width
   *@return int
   */
  int getXY(int xcor, int ycor, int width) {
    return xcor + (ycor*width);
  }

//gets 3d color distance
  float colorDist(color c1, color c2)
  {
    float r1 = red(c1);
    float r2 = red(c2);
    float g1 = green(c1); 
    float g2 = green(c2);
    float b1 = blue(c1);
    float b2 = blue(c2);
    float dist = pow(r2-r1,2)+pow(g2-g1, 2)+pow(b2-b1,2);
    return dist;
  }