//You should implement your assign3 here.
/* ps. I freezed the following lines to prevent the unnecessary troubles.*/
/* HP -20 *//* Enemy acceleration *//* Enemy proximity */ 

PImage startPlain, startHover;
PImage bgOne, bgTwo, healthFrame;
PImage treasureE, fighter, enemyLeft;
PImage endPlain, endHover;

float scrollRight;
int hpBar;
final int HP_PERCENT = 2;
final int HP_MAX = 100*HP_PERCENT;

int gameState;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int enemyState;
final int ENEMY_LINE = 0;
final int ENEMY_SLASH = 1;
final int ENEMY_QUAD = 2;     
float treasureX;
float treasureY;
float fighterX;
float fighterY;
float enemyFlyX;
float enemyFlyY;

float fighterSpeed;
float enemySpeed;
float addSpeed = 0.02;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup () {  
  size (640,480) ;    
  
  startPlain = loadImage ("img/start2.png") ;
  startHover = loadImage ("img/start1.png") ;  
  bgOne = loadImage ("img/bg1.png") ;
  bgTwo = loadImage ("img/bg2.png") ;
  healthFrame = loadImage ("img/hp.png") ;
  treasureE = loadImage ("img/treasure.png") ;
  fighter = loadImage ("img/fighter.png") ;
  enemyLeft = loadImage ("img/enemy.png") ;  
  endPlain = loadImage ("img/end2.png") ;
  endHover = loadImage ("img/end1.png") ;
  
  hpBar = 20*HP_PERCENT;
  gameState = 0;
  enemyState = 0;
  
  treasureX = floor( random(50, 600) );
  treasureY = floor( random(50, 420) );
  fighterX = 575 ;
  fighterY = 240 ;
  enemyFlyX = -50 ;
  enemyFlyY = floor( random(50, 420) );
  
  fighterSpeed = 6 ;
  enemySpeed = 3 ;
}

void draw() {
  
  background(255) ; 
  
  switch (gameState) {
    
    case GAME_START:
    
      image (startPlain, 0, 0) ;
      if (mouseX > 200 && mouseX < 470 && mouseY > 370 && mouseY < 420){
         if (mousePressed) {
           if (mouseButton == LEFT) {
             gameState = 1;
           }
         }else{
           image(startHover, 0, 0);
         }
      } 
    break; 
      
    case GAME_RUN:
    
    //BACKGROUND
      image (bgTwo, scrollRight, 0);
      image (bgOne, scrollRight - 640, 0);
      image (bgTwo, scrollRight - 1280, 0); 
      scrollRight += 2 ;
      scrollRight %= 1280 ;
      
    //TREASURE
      image (treasureE, treasureX, treasureY);    
      
      /* Avoid Repeatition */  
        if(treasureX >= 545 && treasureX <= 605 && 
          treasureY >= 210 && treasureY <= 270){         
          treasureX = floor( random(50,600) );
          treasureY = floor( random(50,420) );
        }    
      
    //FIGHTER
      image(fighter, fighterX, fighterY);
      if (upPressed) {
        if (fighterY > 0) {
          fighterY -= fighterSpeed ;
        }
      }
      if (downPressed) {
        if (fighterY < 430) {
          fighterY += fighterSpeed ;
        }
      }
      if (leftPressed) {
        if (fighterX > 0) {
          fighterX -= fighterSpeed ;
        }
      }
      if (rightPressed) {
        if (fighterX < 590) {
          fighterX += fighterSpeed ;
        }
      }  
      
    //HP_BAR
      fill (#FF0000);
      rect (35, 15, hpBar, 30);
      image(healthFrame, 28, 15); 
      /* HP +10 */         
        if (fighterX >= treasureX - 30 && fighterX <= treasureX + 30 &&
           fighterY >= treasureY - 30 && fighterY <= treasureY + 30) {
               
          if (hpBar < HP_MAX) {
            hpBar += 10*HP_PERCENT;
            treasureX = floor( random(50,600) );         
            treasureY = floor( random(50,420) );
          } else if (hpBar >= HP_MAX) {
            treasureX = floor( random(50,600) );
            treasureY = floor( random(50,420) );
          }
        }
      /* HP -20 */    
        //if(fighterX >= enemyFlyX - 30 && fighterX <= enemyFlyX + 30 &&
        //  fighterY >= enemyFlyY - 50 && fighterY <= enemyFlyY + 50){
        //  hpBar -= 20*HP_PERCENT;
        //  enemyFlyX = -100 ;
        //  enemyFlyY = floor( random(50,420) );
        //} else if (hpBar <= 0) {
        //  gameState = 2 ;
        //  hpBar = 20*HP_PERCENT;
        //  fighterX = 575 ;
        //  fighterY = 240 ;
        //  }  
      
    //ENEMY
      enemyFlyX += enemySpeed;
      enemyFlyX %= width + 420;
      enemyFlyY %= height;
      
      if (enemyFlyX == 0) {
        enemyFlyY = floor( random(50,420) );
      }  
      
      switch (enemyState) {
        
        case ENEMY_LINE :
        
          for (int i = 0; i > -400; i -= 80) {
            image(enemyLeft, enemyFlyX + i, enemyFlyY);
          }   
          if (enemyFlyX > width + 400) {        
            enemyFlyX = -50 ;
            enemyFlyX += enemySpeed ;
            enemyFlyY = floor( random(50,420) );
            enemyState = 1 ;
          }
          
        break;       
        
        case ENEMY_SLASH :
        
          for (int i = 0; i > -400; i -= 80) {
            for (int j = 0; j < 200; j += 40) {
              if (i == -j * 2) {
                image(enemyLeft, enemyFlyX + i, enemyFlyY + j);
              }
            }
          }  
          if(enemyFlyX > width + 400){
            enemyFlyX = -50 ;
            enemyFlyX += enemySpeed ;
            enemyFlyY = floor( random(50,420) );
            enemyState = 2 ;
          }
          
        break;        
        
        case ENEMY_QUAD :
        
          for(int i = 0; i > -180; i -= 60){
            image(enemyLeft, enemyFlyX + i, enemyFlyY + i);
            image(enemyLeft, enemyFlyX + i, enemyFlyY - i);
            image(enemyLeft, enemyFlyX - 180, enemyFlyY - 60);
            image(enemyLeft, enemyFlyX - 180, enemyFlyY + 60);
            image(enemyLeft, enemyFlyX - 240, enemyFlyY);
          }    
          if(enemyFlyX > width + 400){
            enemyFlyX = -50 ;
            enemyFlyX += enemySpeed ;
            enemyFlyY = floor( random(50,420) );
            enemyState = 0 ;
          }  
          
        break;
      }
      
      /* Enemy acceleration */
        //enemyFlyX += addSpeed * enemyFlyX;
        
      /* Enemy proximity */
        //if(enemyFlyX > 150){
        //  if(enemyFlyY >= fighterY){
        //    enemyFlyY -= enemySpeed;
        //  }
        //  if(enemyFlyY < fighterY){
        //    enemyFlyY += enemySpeed;
        //  }
        //}   
      
    break;
      
    case GAME_LOSE :
    
      image(endPlain, 0, 0);  
        if(mouseX > 200 && mouseX < 470 && mouseY > 300 && mouseY < 350){
          if(mousePressed){  
            treasureX = floor( random(50,600) );
            treasureY = floor( random(50,420) );
            if(mouseButton == LEFT){
              gameState = 1 ; 
            }
          }else{
            image(endHover, 0, 0);
          }
        }
        
    break;
  }
  
}

void keyPressed () {
  
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
  
}
  
void keyReleased () {
  
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
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
