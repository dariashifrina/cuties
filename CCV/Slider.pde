//slider class for adjusting threshold for edge detection

import controlP5.*;

ControlP5 cp5;
public Slider slideThing;

void setup() {
  cp5 = new ControlP5(this);
  
slideThing = cp5.addSlider("slider")
     .setBroadcast(false)
     .setRange(0, 200)
     .setPosition(20, 100)
     .setSize(10, 100)
     .setBroadcast(true)
     .setValue(100)
     ;
  
}

void keyPressed() {
  // default properties load/save key combinations are 
  // alt+shift+l to load properties
  // alt+shift+s to save properties
  if (key=='a') {
    slideThing.setValue(slideThing.getValue() - 1);
    threshold -= 1;
  } 
  else if (key=='d') {
    slideThing.setValue(slideThing.getValue() + 1);
    threshold -= 1;
  }