class Ship {

  PVector pos = new PVector();
  float w = grid;
  float h = grid;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PImage img;
  boolean dead = false;
  int timer;
  int timerInterval = 1000; // Sets waiting timne for timer

  public Ship(int x, int y, PImage img) {
    this.pos.x = x;
    this.pos.y = y;
    this.img = img;
  }
  
  public Ship(){
    
  }
  

  public void show() {
    image(img, pos.x, pos.y, w, h);
  }

  ////collision detection against any ship
  boolean hit(Ship s) {
    for (Bullet b : bullets) {
      if (b.pos.x + b.bulletSize/2 > s.pos.x &&
        b.pos.x - b.bulletSize/2 < s.pos.x + s.w &&
        b.pos.y - b.bulletSize/2 < s.pos.y + s.h &&
        b.pos.y + b.bulletSize/2 > s.pos.y) {
        bullets.remove(b);
        return true;
      }
    }
    return false;
  }
  
  //collision detection against shields
  boolean hit(Shield s) {
    for (Bullet b : bullets) {
      for (int i = 0; i < s.rects.size(); i++) {
        if (b.pos.x + b.bulletSize/2 > s.rects.get(i).pos.x &&
          b.pos.x - b.bulletSize/2 < s.rects.get(i).pos.x + s.rects.get(i).size &&
          b.pos.y - b.bulletSize/2 < s.rects.get(i).pos.y + s.rects.get(i).size &&
          b.pos.y + b.bulletSize/2 > s.rects.get(i).pos.y) {
          s.rects.remove(i);
          bullets.remove(b);
          return true;
        }
      }
    }
    return false;
  }
  
  //if time is up return true
  boolean checkTimer(){
    if (millis() > timer + timerInterval){
       return true; 
    }
    return false;
  }
  
  //starts timer
  //alien or assassin is hit
  void startTimer() {
    timer = millis();
    dead = true;
  }
  
  void setImg(PImage img){
    this.img = img;
  }
}
