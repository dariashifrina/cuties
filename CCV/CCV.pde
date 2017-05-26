/* Team Cuties
 * Dasha, James, Gilivr
 * APCS2 Pd3
 */ 
 Camera in;
 void setup() {
   size(600, 450);
   //for some reason, the Capture class requires having the Applet Object running the program, and so a reference to it must be passed
   in = new Camera(this);
 }
 void draw() {
   image(in.getImage(),0,0);
 }
//TrackedObject tracked;

//void mouseClicked() {
//  tracked = new TrackedObject(mouseX, mouseY);
//}