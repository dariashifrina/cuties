class UserMenu {
  float xCenter;//screen center
  float yCenter;//screen center
  float buttonOffset; //horizontal offset from the center screen
  float buttonWidth;
  float buttonHeight;
  color buttonColor;
  PImage img;

  UserMenu(float screenWidth, float screenHeight) {
    xCenter = screenWidth/2;
    yCenter = screenHeight/2;
    buttonWidth = 200;
    buttonOffset = 150;
    buttonHeight = 150;
    buttonColor = color(153, 204, 255);
    //img = loadImage("background.jpg");
  }

  void draw() {
    //background(img);
    fill(buttonColor);
    ellipse(xCenter+buttonOffset, yCenter, buttonWidth, buttonHeight);
    ellipse(xCenter-buttonOffset, yCenter, buttonWidth, buttonHeight);
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Camera", 2*xCenter-(xCenter+buttonOffset), yCenter);
    text("Video File", xCenter+buttonOffset, yCenter);
    fill(153, 204, 255);
    textAlign(CENTER, TOP);
    text("Welcome to Cuties Computer Vision!", xCenter, 0);
    textSize(24);
    text("Select a video feed type", xCenter, 60);
  }

  int mouseReleased() {
    if (mouseY < yCenter + buttonHeight/2 && mouseY > yCenter - buttonHeight/2) {
      if (mouseX > xCenter - buttonOffset - buttonWidth/2 && mouseX < xCenter + buttonWidth/2 - buttonOffset) {//if the mouse is within the Camera ellipse, return the 1 state
        return 1;
      }
      if (mouseX > xCenter + buttonOffset - buttonWidth/2 && mouseX < xCenter + buttonOffset + buttonWidth/2) {//if the mouse is within the Video File ellipse, return the 2 state
        return 2;
      }
    }
    return 0;
  }
}