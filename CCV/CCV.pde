/* Team Cuties
 * Dasha, James, Gilivr
 * APCS2 Pd3
 */ 
 Camera in;
 void setup() {
   size(600, 450);
   in = new Camera(this);
 }
 void draw() {
   image(in.getImage(),0,0);
 }