PImage backGround, soil, cabbage, gameOver, life1, life2, restartHovered, 
restartNormal, soldier, startHovered, startNormal, title, groundhogIdle;

final float GRIDSIZE = 80;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;

int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

float soldierX=0;
float soldierY;
float soldierSpeed = 2;
float soldierWidth = 80;
float soldierHeight = 80;

float cabbageX;
float cabbageY;

float groundhogIdleX = GRIDSIZE*4;
float groundhogIdleY = GRIDSIZE;
float groundhogIdleWidth = 80;
float groundhogIdleHeight = 80;

int lifeNumber;
int life1X = 10;
int life1Y = 10;
int life2X = 80;
int life2Y = 10;


void setup(){
  size(640,480,P2D);
  backGround = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life1 = loadImage("img/life.png");
  life2 = loadImage("img/life.png");
  groundhogIdle =loadImage("img/groundhogIdle.png") ;
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  title = loadImage("img/title.jpg");
 
  
  soldierY=floor(random(2,6));

  gameState = GAME_START;
  
}

void draw(){


  switch (gameState){
    case GAME_START:
      image(title,0,0);
      image(startNormal,248,360);
      
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT 
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        if(mousePressed){
          gameState = GAME_RUN;
        }else{
          image(startHovered,248,360);
        }
      }
      break;
      
    case GAME_RUN:
        lifeNumber = 2;

        soldierX +=soldierSpeed;
        if(soldierX>width){
          soldierX = -GRIDSIZE;
        }
         
        if (groundhogIdleX + groundhogIdleWidth> width){
          groundhogIdleX = width-GRIDSIZE;
        }
         
        if (groundhogIdleX <= 0){
          groundhogIdleX = 0;
        }
         
        if (groundhogIdleY + groundhogIdleWidth >= height){
           groundhogIdleY = height-GRIDSIZE;
        } 
        
        image(backGround,0,0);
        image(soil,0,160);
        image(life1,life1X, life1Y);
        image(life2,life2X, life2Y);
        
        noStroke();
        fill(124,204,25);
        rect(0,145,width,15);
        
        fill(255,255,0);
        ellipse(width-50,50,130,130);
        fill(253,184,19);
        ellipse(width-50,50,120,120);
        
        image(groundhogIdle,groundhogIdleX,groundhogIdleY);
        image(cabbage,GRIDSIZE*7,GRIDSIZE*2);
        image(soldier,soldierX,soldierY*GRIDSIZE);
          
        if(groundhogIdleX < soldierX + soldierWidth && 
          groundhogIdleX + groundhogIdleWidth > soldierX &&
          groundhogIdleY < soldierY*GRIDSIZE + soldierHeight &&
          groundhogIdleY + groundhogIdleHeight > soldierY*GRIDSIZE){
            lifeNumber --;           
           
            if(lifeNumber == 1){
              life2X = width + 50;
              life2Y = height + 50;
              groundhogIdleX = GRIDSIZE*4;
              groundhogIdleY = GRIDSIZE;
            }if(lifeNumber == 0){
              gameState = GAME_OVER;          
            }
         }       
        break;
        
    case GAME_OVER:
      image(gameOver,0,0);
      image(restartNormal,248,360);
      
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT 
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        if(mousePressed){
          gameState = GAME_RUN;
        }else{
          image(restartHovered,248,360);
        }
      }
      break;
        
      } 
    }
    
void keyPressed(){
    if (key == CODED) {
      switch (keyCode){
        case DOWN:
          groundhogIdleY += GRIDSIZE; 
          break;
        case LEFT:
          groundhogIdleX -= GRIDSIZE; 
          break;
        case RIGHT:
          groundhogIdleX += GRIDSIZE; 
          break;
      }
    }
}
