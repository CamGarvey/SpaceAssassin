class Shield {

  PVector pos = new PVector();
  int amountOfRect = 40; // Sets max amount of rect that makes up shields
  float rectSize = 5; //sets size of each rect
  ArrayList<Rectangle> rects = new ArrayList<Rectangle>();
  int rectXMax = 10; // sets max amount of rects on x axis

  public Shield(int x, int y) {
    pos.x = x;
    pos.y = y;

    float rectX = pos.x;
    float rectXCount = 0;
    float rectY = pos.y;
    for (int i = 0; i < amountOfRect; i++) {
      //if rect is equal to rectXMax go down on y axis
      if (rectXCount == rectXMax) {
        rectY += rectSize;
        rectX = pos.x;
        rectXCount = 0; // reset x axis
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
