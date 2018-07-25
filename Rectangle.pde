class Rectangle {

  PVector pos = new PVector();
  float size;

  public Rectangle(float x, float y, float size) {
    pos.x = x;
    pos.y = y;
    this.size = size;
  }

  public void show() {
    fill(0,200,0);
    stroke(0,200,0);
    rect(pos.x, pos.y, size, size);
  }
}
