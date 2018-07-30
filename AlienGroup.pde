//This class creates a group of aliens, keeps track of each one and their bullets
class AlienGroup {

  ArrayList<Alien> aliens;
  int numberOfAliens;

  //Different Alien Images
  PImage alienImg1;
  PImage alienImg2;
  PImage alienImg3;
  PImage alienImg4;



  public AlienGroup(int amount, float downSpeed, float leftRightSpeed) {
    numberOfAliens = amount;
    alienImg1 = loadImage("images/BadShip.png");
    alienImg2 = loadImage("images/BadShip2.png");
    alienImg3 = loadImage("images/BadShip3.png");
    alienImg4 = loadImage("images/BadShip4.png");
    alienBullets = new ArrayList<Bullet>();
    setUpAliens(downSpeed, leftRightSpeed);

  }


  //Checks size of alien ArrayList
  boolean checkWin() {
    if (aliens.size() == 0) {
      return true;
    }
    return false;
  }

  
  void updateAllAliens() {
    for (int i = 0; i < aliens.size(); i++) {
      showAllAliens(i);
      update(i);
      //Checks if alien has been shot, if it has then timer is checked.
      //if timer is up, then alien is removed
      if (aliens.get(i).dead){
        if (aliens.get(i).checkTimer()){
          aliens.remove(i);
        }
      }
    }
  }

  //Shows all aliens in arrayList
  void showAllAliens(int index) {
    aliens.get(index).show();
  }

  void updateBullets() {
    for (int i = 0; i < alienBullets.size(); i++) {
      alienBullets.get(i).show();
      alienBullets.get(i).update();
      if (alienBullets.get(i).pos.y > height) {
        alienBullets.remove(i);
      }
    }
  }


  //Checks if alien hits assassin
  boolean alienHitAssassin(Assassin a) {
    for (int i = 0; i < alienBullets.size(); i++) {
      if (alienBullets.get(i).hit(a)) {
        alienBullets.remove(i);
        return true;
      }
    }
    return false;
  }




  //Checks if alien hits any shields, if it did then bullet is removed
  void alienHitShields(Shield[] shields) {
    for (Shield s : shields) {
      for (int i = alienBullets.size()-1; i >= 0; i--) {
        if (alienBullets.get(i).hit(s)) {
          alienBullets.remove(i);
        }
      }
    }
  }




  //If alien isn't hit update and shoot
  void update(int index) {
    if (!aliens.get(index).dead) {
      aliens.get(index).update();
      aliens.get(index).shoot(assassin);
    }
  }

  // //If alien isn't already hit check if hit 
  int checkIfHit(Assassin a) {
    for (int i = 0; i < aliens.size(); i++) {
      if (!aliens.get(i).dead) {
        if (a.hit(aliens.get(i))) {
          aliens.get(i).setImg(explode);
          aliens.get(i).startTimer();
          explodeSound.play();
          return aliens.get(i).points;
        }
      }
    }
    return 0;
  }



  //Sets up all alien Ships
  void setUpAliens(float downSpeed, float leftRightSpeed) {
    aliens = new ArrayList<Alien>();
    int x = grid;
    int y = (height / 2) /2;
    for (int i = 0; i < numberOfAliens; i++) {
      if (x >= width -grid) {
        y += grid * 2; 
        x = grid;
      }

      //changing image depending on y position
      switch(y) {
      case 175:
        aliens.add(new Alien(x, y, alienImg1, 500, downSpeed, leftRightSpeed));
        break;
      case 225:
        aliens.add(new Alien(x, y, alienImg2, 400, downSpeed, leftRightSpeed));
        break;
      case 275:
        aliens.add(new Alien(x, y, alienImg3, 225, downSpeed, leftRightSpeed));
        break;
      default:
        aliens.add(new Alien(x, y, alienImg4, 125, downSpeed, leftRightSpeed));
        break;
      }
      x += grid * 2;
    }
  }
}
