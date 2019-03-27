float soils = 80,groundhogX = soils*4,groundhogY = soils,groundhogW,groundhogH,groundhogSpeed = 80/16,sodierSpeed = 4 ,
sodierX=-80,sodierY,sodierH,sodierW,cabbageX,cabbageY,cabbageH,cabbageW;
final int 
GO_RIGHT = 0,GO_DOWN = 1,GO_LEFT = 2,NO_GO = 3,
GAME_START = 0,GAME_RUN = 1,GAME_OVER = 2,
BUTTON_TOP = 360,BUTTON_BOTTOM = 360+60,BUTTON_LEFT = 248,BUTTON_RIGHT = 248+144,
HEART2 = 0,HEART1 = 1,HEART0 = 2,HEART3 = 3; 
int moveW = 0,move = NO_GO,gameState = GAME_START,heart = 2;
boolean downPressed = false,leftPressed = false,rightPressed = false;

void setup() {
	size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  life2 = loadImage("img/life.png");
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  gameover = loadImage("img/gameover.jpg");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
    sodierY = soils*(floor(random(2,6))); 
    cabbageX = soils*(floor(random(0,7)));
    cabbageY = soils*(floor(random(2,5)));
}
void draw() {
  switch(gameState){
    case GAME_START:      
    //START GAME IS HERE
       image(title,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT    //about change color
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, BUTTON_LEFT, BUTTON_TOP);
      }
    break;
    case GAME_RUN:                                              //RUN GAME IS HERE
      image(bg,0,0);     //sun
      fill(255,255,0);
      noStroke();
      ellipse(590,50,130,130);
      fill(253,184,19);
      noStroke();    //soil
      ellipse(590,50,120,120);
      image(soil,0,160); 
      fill(124,204,25);    //grass
      noStroke();
      rectMode(CORNERS);
      rect(0,145,640,160);
      image(groundhogIdle,groundhogX,groundhogY);    //hog
        groundhogW = groundhogX+80;
        groundhogH = groundhogY+80;
      image(cabbage,cabbageX,cabbageY);    //cabbage
        cabbageH = cabbageY+80;
        cabbageW = cabbageX+80;
      image(soldier,sodierX,sodierY);    //sodier's move

      sodierX += sodierSpeed;
      if(sodierX > 720) sodierX = -80;
      sodierH = sodierY+80;
      sodierW = sodierX+80;

       if(groundhogX < cabbageW && groundhogW > cabbageX  //touch the cabbage
      && groundhogY < cabbageH && groundhogH > cabbageY){
        heart ++;
        cabbageY = 750;
        cabbageX = 750;
      }

      if(groundhogX < sodierW && groundhogW > sodierX  //touch the sodier
      && groundhogY < sodierH && groundhogH > sodierY){
      moveW = 80;
      move = NO_GO;
      groundhogX = soils*4;
      groundhogY = soils;
       heart -- ;
      }
      if(heart == 0){  //all about heart count
      gameState = GAME_OVER;
      }
      if(heart == 1){
      image(life,10,10);
      }
      if(heart == 2){
      image(life,10,10); 
      image(life2,80,10);
      }  
       if(heart == 3){
      image(life,10,10); 
      image(life2,80,10);
      image(life2,150,10);
       }
    break;
    case GAME_OVER:                                             //GAME OVER IS HERE
      heart = 2; //reset heart
    image(gameover,0,0);
    if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT  //about change color
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
            sodierY = soils*(floor(random(2,6))); 
            cabbageX = soils*(floor(random(0,7)));
            cabbageY = soils*(floor(random(2,5)));
        }
      }else{
        image(restartNormal, BUTTON_LEFT, BUTTON_TOP);
      }
    break;
  }
  if (downPressed) {
      move = GO_DOWN;
    }
    if (leftPressed) {
     move = GO_LEFT;
    }
    if (rightPressed) {
      move = GO_RIGHT; 
    }
   switch(move){  //all groundhog to move
    case NO_GO:                                          //STOP
      groundhogIdle = loadImage("img/groundhogIdle.png");
      moveW = 0;
      downPressed = false;
      leftPressed = false;
      rightPressed = false;
      break;
    case GO_DOWN:                                         //DOWN
      groundhogIdle = loadImage("img/groundhogDown.png");
      if(moveW <= 79 || moveW == 79){
         groundhogY += groundhogSpeed ;
         moveW += groundhogSpeed;
       }else{
         move = NO_GO;
        }
      if(groundhogY>480-soils) groundhogY = 480-soils;
      break;
    case GO_LEFT:                                        //LEFT
       groundhogIdle = loadImage("img/groundhogLeft.png");
       if(moveW <= 79 || moveW == 79){
         groundhogX -= groundhogSpeed ;
         moveW += groundhogSpeed;
       }else{
         move = NO_GO;
        }
      if(groundhogX<0) groundhogX = 0;
      break;
    case GO_RIGHT:                                        //RIGHT
     groundhogIdle = loadImage("img/groundhogRight.png");
      if(moveW <= 79 || moveW == 79){
         groundhogX += groundhogSpeed ;
         moveW += groundhogSpeed;
       }else{
         move = NO_GO;
        }
      if(groundhogX>640-soils) groundhogX = 640-soils;
      break;
    }
}
void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case DOWN:
      if(move == NO_GO) downPressed = true;
        break;
      case LEFT:
        if(move == NO_GO) leftPressed = true;
        break;
      case RIGHT:
        if(move == NO_GO) rightPressed = true;
        break;
    }
  }
}
void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
