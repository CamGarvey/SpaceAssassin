//This class creates an Alien Object
class Alien extends Ship {

  boolean dir = true; //Checks if going left or right
  float steps = 0; // Steps to the left or right
  float maxSteps = 65; //How many step an alien can move
  int downCount = 0; // How far down alien has gone down
  int maxDownCount = 20;
  float downSpeed; // How fast aliens move down
  float leftRightSpeed; //How fast aliens move left and right
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
    //Checks if going right(dir == true) then moves right, else goes left
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



  //Shoots bullets towards assassin
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
