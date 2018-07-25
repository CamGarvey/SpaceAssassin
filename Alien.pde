class Alien extends Ship {

  boolean dir = true;
  float steps = 0;
  float maxSteps = 65;
  int downCount = 0;
  int maxDownCount = 20;
  float downSpeed;
  float leftRightSpeed;
  int points;



  public Alien(int x, int y, PImage img, int points, float downSpeed, float leftRightSpeed) {
    super(x, y, img);
    this.points = points;
    this.downSpeed = downSpeed;
    this.leftRightSpeed = leftRightSpeed;
    timerInterval = 1000;
  }


  public void update() {
    if (steps > maxSteps) {
      steps = 0;
      dir = !dir;
    }
    if (dir) {
      pos.x += leftRightSpeed;
      steps++;
    } else {
      pos.x += -leftRightSpeed; 
      steps++;
    }
    downCount++;
    if (downCount == maxDownCount) {
      pos.y += downSpeed;
      downCount = 0;
    }
    //downSpeed+= 0.002;
  }




  void shoot(Assassin ship) {
    if (shootCount >= shootRate) {
      if (ship.pos.x + ship.w >= pos.x && ship.pos.x <= this.pos.x + this.w) {
        alienBullets.add(new Bullet(this.pos.x, this.pos.y + h, -5, alienBullet));
        alienSound.play();
      }
      shootCount = 0;
    } else {
      shootCount++;
    }
  }
}
