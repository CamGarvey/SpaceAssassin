//This class creates an object of the main ship the user controls
class Assassin extends Ship {

  boolean leftDown = false;
  boolean rightDown = false;
  float speed = 3;
  boolean dead = false;

  public Assassin(int x, int y, PImage img) {
    super(x, y, img);
    
  }

  public void move(float x) {
    this.pos.x += x;
  }

  public void update() {
    //If user is holding down any arrow keys then leftDown/rightDown is to true and move method is called
    if (leftDown){
      move(-speed);
    }
    if (rightDown){
      move(speed);
    }
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).show();
      bullets.get(i).update();
      if (bullets.get(i).pos.y < 0) {
        bullets.remove(i);
      }
    }
    //Stops assassin going off screen
    pos.x = constrain(pos.x,0, width - w);
  }

  public void shoot() {
    bullets.add(new Bullet(pos.x - 2, pos.y, 5, AssassinBullet));
  }
}
