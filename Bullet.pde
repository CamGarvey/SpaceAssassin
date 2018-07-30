class Bullet {

  PVector pos = new PVector();
  float bulletSize = grid/4;
  float speed = 5;
  PImage img;


  public Bullet(float x, float y, float speed, PImage img) {
    pos.x = x + (grid/ 2);
    pos.y = y;
    this.speed = speed;
    this.img = img; // since some bullets have different images a PImage is passed
  }


  public void show() {
    image(img, pos.x, pos.y, bulletSize, bulletSize);
  }

  public void update() {
    this.pos.y -= speed;
  }


  //collision detection against any ship
  boolean hit(Ship s) {
    if (pos.x + bulletSize/2 > s.pos.x &&
        pos.x - bulletSize/2 < s.pos.x + s.w &&
        pos.y - bulletSize/2 < s.pos.y + s.h &&
        pos.y + bulletSize/2 > s.pos.y) {
          return true;
    }
    return false;
  }
  
  //collision detection against shields
  boolean hit(Shield s) {
      for (int i = 0; i < s.rects.size(); i++) {
        if (pos.x + bulletSize/2 > s.rects.get(i).pos.x &&
          pos.x - bulletSize/2 < s.rects.get(i).pos.x + s.rects.get(i).size &&
          pos.y - bulletSize/2 < s.rects.get(i).pos.y + s.rects.get(i).size &&
          pos.y + bulletSize/2 > s.rects.get(i).pos.y) {
          s.rects.remove(i);
          return true;
        }
      }
    return false;
  }
  
  
}
  
