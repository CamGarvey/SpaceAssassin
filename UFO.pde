public class UFO extends Ship {
  
  boolean direction;
  PImage ufoImg;
  int timer;
  int timerInverval = 1000;
  float speed = 2;
  boolean hit = false;
  
  public UFO() {
    int d = floor(random(2));
    switch(d){
      case 0:
        this.pos.x = 0 - 100;
        direction = false;
        break;
      case 1:
        direction = true;
        this.pos.x = width;
        break;
    }
    this.pos.y = 150;
    ufoImg = loadImage("images/ufo.png");
    this.img = ufoImg;
    timer = millis();
  }
  
  public void show(){
    this.w = grid * 2;
    image(img, pos.x,pos.y, grid * 2, grid); 
  }
  
  public void update(){
    if (dead){
      img = explode;
       if (checkTimer()){
         resetUFO();
       }
    }
    else {
      if (millis() > timer + timerInverval){
        if (!direction) {
            this.pos.x -= speed;
        }
        else {
            this.pos.x += speed;
        }
        if (pos.x > width + 50 & direction || pos.x < -100 & !direction){
          resetUFO();
        }
      }
    }
  }
  
  
  void resetUFO(){
    timer = millis();
    direction = !direction;
    if (direction){
      pos.x = 0 - grid * 3;
    }
    else {
      pos.x = width;
    }    
  }

  

  
  
  
  
  
  
  
}
