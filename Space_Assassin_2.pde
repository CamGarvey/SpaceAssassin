import processing.sound.*;

PFont font;
int grid;
Assassin assassin;
int numberOfAliens = 36;
int maxLives = 3;
int lives = maxLives;
GameState gameState = GameState.MENU;
int rows;
int cols;
float m;
Shield[] shields;
int numOfShields;
float shootCount = 0;
//Alien Shoot rate, lower faster
float shootRate = 100;
float alienDownSpeed = .5;
float alienleftRightSpeed = 0.8;
int score;
int highScore;
boolean isHighScore = false;
int level;
ArrayList<Bullet> alienBullets;
AlienGroup aliens;
UFO ufo;

//Declaring Images
PImage assassinImg;
PImage AssassinBullet;
PImage assassinHitImg;
PImage alienBullet;
PImage explode;
//----------------

//Declaring Sounds
SoundFile asSound;
SoundFile alienSound;
SoundFile explodeSound;
SoundFile assassinHit;
//----------------





void setup() {
  loadImages();
  loadSounds();
  ufo = new UFO();
  font = createFont("ARCADE.TTF", 20);
  textFont(font);
  ellipseMode(CENTER);
  size(500, 700);
  grid = 25;
  //Creating an instance of the ship
  assassin = new Assassin(width/2, height - grid * 4, assassinImg);
  aliens = new AlienGroup(numberOfAliens, alienDownSpeed, alienleftRightSpeed);
  
  rows = height / grid;
  score = 0;
  numOfShields = 4;
  setUpShields();
  getHighScore();
  textAlign(RIGHT);
  text(highScore, width - grid, grid * 3);
  level = 1;
}

//Loads Images
void loadImages() {
  assassinImg = loadImage("images/GoodShip.png");
  alienBullet = loadImage("images/bBullet.png");
  AssassinBullet = loadImage("images/gBullet.png");
  assassinHitImg = loadImage("images/ShipHit.png");
  explode = loadImage("images/Explode.png");
}

//Loads Sounds
void loadSounds() {
  asSound = new SoundFile(this, "as.mp3");
  alienSound = new SoundFile(this, "AlienSound.mp3");
  explodeSound = new SoundFile(this, "AlienExplode.mp3");
  assassinHit = new SoundFile(this, "AssassinHit.mp3");

  //Volume of each sound
  asSound.amp(0.5);
  explodeSound.amp(0.3);
  alienSound.amp(0.2);
}

void draw() {
  background(0);
  switch(gameState) {
  case MENU:
    menu();
    break;
  case RUNNING:
    running();
    break;
  case GAMEOVER:
    gameOver();
    break;
  }
}

void menu() {
  fill(0, 200, 0);
  textAlign(CENTER);
  textSize(52);
  text("SPACE ASSASSIN", width/2, (height/2)/2);
  textSize(30);
  text("Press UP to begin", width/2, (height/2));
}

void gameOver() {
  fill(0, 200, 0);
  textAlign(CENTER);
  textSize(64);
  text("GAMEOVER", width/2, height/2);
  lives = maxLives;
  if (score > highScore) {
    highScore = score;
    saveHighScore();
    isHighScore = true;
  }
  if (isHighScore)
    text("HIGHSCORE!\n" + highScore, width/2, height/2 + 50);
  score = 0;
  setUpShields();
  aliens.setUpAliens(alienDownSpeed, alienleftRightSpeed);
  assassin.dead = false;
  alienBullets.clear();
  assassin.bullets.clear();
}

void running() {
  ufo.show();
  ufo.update();
  if (assassin.hit(ufo)){
    explodeSound.play();
    ufo.startTimer();
  }
  aliens.alienHitShields(shields);
  if (aliens.checkWin()) {
    shootRate -= 2;
    level++;
    setUpShields();
    aliens = new AlienGroup(numberOfAliens, alienDownSpeed *= 1.2, alienleftRightSpeed * 1.2);
  }
  if (lives != 0) {
    assassin.update();
  }
  aliens.updateBullets();
  assassin.show();
  aliens.updateAllAliens();
  for (Shield s : shields) {
    s.show();
    assassin.hit(s);
  }
  if (!assassin.dead) {
    if (aliens.alienHitAssassin(assassin)) {
      assassinHit.play();
      lives--;
      assassin.setImg(assassinHitImg);
      assassin.startTimer();
      if (lives == 0) {
        assassin.setImg(explode);
        assassin.dead = true;
        assassin.startTimer();
      }
    }
  }
  //adds score received by alien
  score += aliens.checkIfHit(assassin);

  //if timer has reached timerInterval reset img
  if (assassin.checkTimer()) {
    if (assassin.dead) {
      gameState = GameState.GAMEOVER;
    } else {
      assassin.setImg(assassinImg);
    }
  }

  drawUI();
}


// draws all interface elements score, lives left etc...
void drawUI() {
  //Creating a horizontal line under ship
  stroke(255);
  line(0, assassin.pos.y + 50, width, assassin.pos.y + 50);
  //Sets images of lives remaining
  textAlign(LEFT);
  textSize(20);
  text("LIVES", grid - 10, assassin.pos.y + 70);
  for (int i = 0; i < lives; i++) {
    image(assassinImg, (grid * i) * (1.2), assassin.pos.y + 70, grid, grid);
  }
  //Score Text
  fill(255);
  textSize(40);
  textAlign(LEFT);
  text("SCORE\n" + score, grid, grid * 3);
  //highScore Text
  fill(255);
  textSize(40);
  textAlign(RIGHT);
  text("HIGHSCORE\n" + highScore, width - grid, grid * 3);
  //Level
  fill(0, 200, 0);
  textSize(40);
  textAlign(RIGHT);
  text("LEVEL " + level, width - grid/2, assassin.pos.y + 95);
}


void keyPressed() {
  switch(keyCode) {
  case LEFT:
    assassin.leftDown = true;
    break;
  case RIGHT:
    assassin.rightDown = true;
    break;
  case UP:
    gameState = GameState.RUNNING;
    isHighScore = false;
    break;
  }
  if (key == ' ' && gameState == GameState.RUNNING) {
    assassin.shoot();
    asSound.play();
  }
}

void keyReleased() {
  switch(keyCode) {
  case LEFT:
    assassin.leftDown = false;
    break;
  case RIGHT:
    assassin.rightDown = false;
    break;
  }
}








//Sets up the shields
void setUpShields() {
  shields = new Shield[numOfShields];
  for (int i = 0; i < shields.length; i++) {
    shields[i] = new Shield(grid * 6 * i, height - grid * 6);
  }
}

void getHighScore() {
  String[] hscore = loadStrings("highscore.txt");
  highScore = int(hscore[0]);
}


//Have not implemented saving highscore
//Saves highScore
void saveHighScore() {
  Integer s = new Integer(highScore);
  String scoreS = s.toString();
  saveStrings("highscore.txt", new String[] {scoreS});
}
