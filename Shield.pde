class Shield {

  PVector pos = new PVector();
  int amountOfRect = 40;
  float rectSize = 5;
  ArrayList<Rectangle> rects = new ArrayList<Rectangle>();
  int rectXMax = 10;

  public Shield(int x, int y) {
    pos.x = x;
    pos.y = y;

    float rectX = pos.x;
    float rectXCount = 0;
    float rectY = pos.y;
    for (int i = 0; i < amountOfRect; i++) {
      if (rectXCount == rectXMax) {
        rectY += rectSize;
        rectX = pos.x;
        rectXCount = 0;
      }
      rectX += rectSize;
      rectXCount++;
      rects.add(new Rectangle(rectX, rectY, rectSize));
    }
  }

  void show() {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).show();
    }
  }
}
