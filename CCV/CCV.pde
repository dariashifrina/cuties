/* Team Cuties
 * Dasha, James, Gilivr
 * APCS2 Pd3
<<<<<<< HEAD
 */ 
 Camera in;
 void setup() {
   size(600, 450);
   in = new Camera(this);
 }
 void draw() {
   image(in.getImage(),0,0);
 }
=======
 */
TrackedObject tracked;

void mouseClicked() {
  tracked = new TrackedObject(mouseX, mouseY);
}
>>>>>>> 4a9faa7d872f930bbab153e412222d9e4d1acefe
