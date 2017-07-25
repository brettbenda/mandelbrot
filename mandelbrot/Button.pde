class Button {
  float x;
  float y;
  float buttonWidth;
  float buttonHeight;
  String name;

  Button(float x, float y, float buttonWidth, float buttonHeight, String name) {
    this.x=x;
    this.y=y;
    this.buttonWidth=buttonWidth;
    this.buttonHeight=buttonHeight;
    this.name = name;
  }

  void show() {
    rectMode(CENTER);
    if (isClicked()) {
      fill(200);
    } else {
      fill(225);
    }
    stroke(100);
    rect(x, y, buttonWidth, buttonHeight, 10);
    fill(0);
    textFont(createFont("Tahoma", buttonHeight/2));
    textAlign(CENTER);
    text(name,x,y+buttonHeight/5);
  }

  boolean isClicked() {
    if (mousePressed && isOver()) {
      return true;
    }
    return false;
  }

  boolean isOver() {
    if (mouseX > x - buttonWidth/2 && mouseX < x + buttonWidth/2) {
      if (mouseY > y - buttonHeight/2 && mouseY < y + buttonHeight/2) {
        return true;
      }
    }
    return false;
  }
}