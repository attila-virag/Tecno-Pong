
int player1Score = 0;
int player2Score = 0;
int player1Coins = 0;
int player2Coins = 0;
int playtime = 0;
int seconds;
int maxCoins = 10;
int radius = 20;
int paddleLegth = 200;

int bonusLevel = 6;
int bonusTime = 10;
float randBonus1 = -1;
int player1BonusStart = -1;
int player2BonusStart = -1;
float randBonus2 = -1;

boolean player1Auto = true;
boolean player2Auto = false;

final class Ball{
 
  public int x,y; //position of the ball
  
  int xSpeed, ySpeed;  
  
  int type;
  
  int ballRadius;
  int R,G,B;  
  
  public Ball(int _x, int _y, int _xSpeed, int _ySpeed, int type) {
    this.x = _x;
    this.y = _y;
    this.xSpeed = _xSpeed;
    this.ySpeed = _ySpeed;
    
    this.type = type;
    
    this.ballRadius = radius; 
    
    if(type == 1) { // ball
      this.R = 0;
      this.G = 0;
      this.B = 255;
    }
    else { // coins
      this.R = 
      255;
      this.G = 0;
      this.B = 255;
    }
  }
  
  
  void drawBall(){
    int w = ballRadius*2;
    int l = ballRadius*2;
    
    if(type != 1) {
     w = 30; 
     l = 20;
    }
    
    stroke(R,G,B);
    strokeWeight(3);
    fill(0,0,0);
    ellipse(x,y,w,l);
   
  }
  
  void drawExplode() {
   stroke(R,G,B);
   strokeWeight(8);
   fill(R,G,B);
   ellipse(x,y,ballRadius*4, ballRadius*4);
  }
  
  void GetNextPosition() {
    x = x+xSpeed;
    y = y+ySpeed;
  }
  
  public void UpdateBallPosition() {
    GetNextPosition();
    drawBall();
  }
  
  public boolean BallIsOffScreenLeft() {
    if(x < 0) {
     return true; 
    }
    return false;
  }
  public boolean BallIsOffScreenRight() {
    if(x > 800) {
     return true; 
    }
    return false;
  }
  
  public void CollisionDetectionX(int xObstacleBegin, int xObstacleEnd) {
    int ballEdge = x;
    //if(xSpeed < 0) { // ball is moving left
    //   ballEdge = x-ballRadius;
    //}
    //else if(xSpeed > 0) {
    //   ballEdge = x+ballRadius; 
    //}
    
    if(ballEdge > xObstacleBegin && ballEdge < xObstacleEnd) {      
      xSpeed = -1*xSpeed;      
    }    
  }
  
  // check if the ball middle passes through the coin "box"
  public boolean DetectCoinCollision(int xEdge, int yEdge) {
    
    if(xEdge < x && xEdge+2*ballRadius > x && yEdge < y && yEdge+2*ballRadius > y) {
       return true; 
    }
    return false;
  }
  
  public void CollisionDetectionY(int yObstacle) { 
    if(ySpeed < 0 && yObstacle <= y) {
      if(yObstacle >= (y-ballRadius)) {
        ySpeed = -1*ySpeed;
      }
    }
    else if (yObstacle >= y) {
      if(yObstacle <= (y+ballRadius)) {
        ySpeed = -1*ySpeed;
      }
    }
  }  
}

final class Paddle { 
  public int x,y; // paddle position
  
  int maxSpeed;
  int velocity;
  
  boolean auto;
  
  public int w,l;
  
  public Paddle(int _x, int _y, int _speed, boolean auto) {
    this.x = _x;
    this.y = _y;
    this.maxSpeed = _speed;    
    
    this.w = 20;
    this.l = paddleLegth;
    
    this.auto = auto;
    
  }
  
  public void SetVelocity(int direction) {
   if(direction > 0) { 
     velocity--;
   }
   else if (direction < 0) {
     velocity++;
   }
   else {
     velocity = 0;
   }
  }
  
  void drawPaddle() {
    stroke(255,255,0);
    fill(0,0,0);
    rect(x,y,w,l);
  }
  
  void GetNextPosition() {    
    y = y+velocity;
    
    if(y <= 100) {
     y = 100;
     velocity = 0;
    }
    else if (y+l >= 900) {
     y = 900-l;
     velocity = 0;
    }   
  }
  
  void UpdatePaddlePosition() {
   GetNextPosition();
   drawPaddle();
  }
  
}

// creating canvas
void setup() {
  size(800, 900);
  //background(0,0,0);
}



void DrawScoreboard() {
  stroke(255,255,0);
  strokeWeight(5);
  line(0,100,800,100);
  line(0,898,800,898);
  
  textSize(50);
  fill(255, 0, 0);
  text(player1Score, 30, 40); 
  text(player2Score, 640, 40); 
  String timeMsg = "Timer: "+playtime;
  text(timeMsg, 250,50);
  
  //score 
  if(randBonus1 > -1) {
    text("BONUS", 30, 90);
  }
  else {
    text(player1Coins, 30, 90);
  }
  if(randBonus2 > -1) {
    text("BONUS", 610,90);
  }
  else {
    text(player2Coins, 640, 90);
  }
}

Paddle paddle_1 = new Paddle(60,100,1,player1Auto);
Paddle paddle_2 = new Paddle(740,100,7,player2Auto);

int GetBonus(float randBonus) {
  //return 4;
 if(randBonus < .25) {
  return 1; 
 }
 if(randBonus < .5) {
  return 2; 
 }
 if(randBonus < .75) {
  return 3; 
 }
 else if(randBonus <= 1) {
  return 4; 
 }
 return 0;
}

void MoveCoinsAwayFromBall(Ball coin,Ball ball) {
  if(coin.x > 60 && coin.x < ball.x && ball.x-coin.x < 100) {
    if(coin.xSpeed > 0) {
      coin.xSpeed = -1*coin.xSpeed;
    }
  }
  else if(coin.x < 740 && coin.x > ball.x && coin.x-ball.x < 100) {
    if(coin.xSpeed < 0) {
      coin.xSpeed = -1*coin.xSpeed;
    }
  }
  if(coin.y > 160 && coin.y < ball.y && ball.y-coin.y < 100) {
    if(coin.ySpeed > 0) {
      coin.ySpeed = -1*coin.ySpeed;
    }
  }
  else if(coin.y < 840 && coin.y > ball.y && coin.y-ball.y < 100) {
    if(coin.ySpeed < 0) {
      coin.ySpeed = -1*coin.ySpeed;
    }
  }
}

Ball SpawnBall(int type) {
  // spawn a new ball with random velocity in the middle
  int yMin,yMax,xMin,xMax;
  if(type ==1) {
    yMin = 1;
    yMax = 7;
    xMin = 4;
    xMax = 9;
  }
  else {
    yMin = 1;
    yMax = 9;
    xMin = 1;
    xMax = 9;
  }
  int xSpeed = int(random(xMin,xMax));
  int ySpeed = int(random(yMin,yMax));
  float xDirection = random(0,1);
  float yDirection = random(0,1);
  if(xDirection < 0.50) {
   xSpeed =xSpeed*-1; 
  }
  if(yDirection < 0.50) {
    ySpeed = ySpeed*-1;
  }
  return new Ball(400,500,xSpeed,ySpeed,type);
}

ArrayList<Ball> ballsInPlay = new ArrayList<Ball>();
ArrayList<Ball> coinsInPlay = new ArrayList<Ball>();

void keyPressed() {
    if(!paddle_2.auto){
      if (keyCode == UP) {
        paddle_2.SetVelocity(1);
      }
      if (keyCode == DOWN) {
        paddle_2.SetVelocity(-1);
      } 
      if(keyCode == LEFT || keyCode == RIGHT){
        paddle_2.SetVelocity(0);
      }
    }
    if(keyCode == SHIFT) {
      coinsInPlay.add(SpawnBall(2));
    }
    if (keyCode == BACKSPACE) {
     // reset timer and score
     player1Score = 0;
     player2Score = 0;
     playtime = 0;
    }
    if(!paddle_1.auto) {
       if (key == 'w' || key == 'W') { 
         paddle_1.SetVelocity(1);
       }
       if(key == 's' || key == 'S') { 
         paddle_1.SetVelocity(-1);
       }
       if(key == 'a' || key == 'd'){
          paddle_1.SetVelocity(0);
        }
    } 
}

void draw() {
  background(0,0,0);
  // the dispeser
  stroke(0,255  ,0);
  strokeWeight(5);
  fill(0,0,0);
  ellipse(400,500,40,40);
  
  
  // second update
  int prevTime = seconds;
  seconds = int(millis()/600);
  if(prevTime < seconds) {
    println(" Balls in play: ", ballsInPlay.size());
    println(" Coins in play: ", coinsInPlay.size());
    playtime++;
    if(ballsInPlay.size() == 0) {
      ballsInPlay.add(SpawnBall(1));
    }
    if(coinsInPlay.size() < maxCoins) {
      coinsInPlay.add(SpawnBall(2));
    }
    
    if(randBonus1 > -1) {
     if( player1BonusStart+bonusTime < seconds) {
      randBonus1 = -1;
      player1BonusStart = -1;
      // reset paddle legth
      paddle_1.l = paddleLegth;
      if(paddle_2.l < paddleLegth) {
        paddle_2.l = paddleLegth;
      }
     }
    }
    if(randBonus2 > -1) {
      if( player2BonusStart+bonusTime < seconds) {
      randBonus2 = -1;
      player2BonusStart = -1;
      paddle_2.l = paddleLegth;
      if(paddle_1.l < paddleLegth) {
        paddle_1.l = paddleLegth;
      }
     }
    }
  }
  
  
  DrawScoreboard();
  if(ballsInPlay.size() > 0) {
  for(Ball ball : ballsInPlay) {
  
      ball.UpdateBallPosition();
      ball.CollisionDetectionY(100);
      ball.CollisionDetectionY(900);
      
      // see if paddles are hit
      if(paddle_1.y < ball.y+ball.ballRadius && paddle_1.y+paddle_1.l > ball.y-ball.ballRadius){
       ball.CollisionDetectionX(paddle_1.x,paddle_1.x+paddle_1.w); 
      }
      if (player1Auto && ball.xSpeed < 0) {
        if(paddle_1.y+.5*paddle_1.l < ball.y) { // paddle is below ball
          paddle_1.SetVelocity(-1);
        }
        else if(paddle_1.y+.5*paddle_1.l > ball.y) {
          paddle_1.SetVelocity(1);
        }
        else {
         //paddle_1.SetVelocity(0); 
        }
      }
      if(paddle_2.y < ball.y+ball.ballRadius && paddle_2.y+paddle_2.l > ball.y-ball.ballRadius){
       ball.CollisionDetectionX(paddle_2.x,paddle_2.x+paddle_2.w); 
      }
      if (player2Auto && ball.xSpeed > 0) {
        if(paddle_2.y+.5*paddle_2.l < ball.y) { // paddle is below ball
          paddle_2.SetVelocity(-1);
        }
        else if(paddle_2.y+.5*paddle_2.l > ball.y) {
          paddle_2.SetVelocity(1);
        }
        else {
         //paddle_2.SetVelocity(0); 
        }
      }
      // if we are on auto and ball is traveling toward the paddle, change the paddle speed
      if(ball.xSpeed < 0) {
        
      }
      else {
        
      }
      
      // check each coin and see if we hit it
      for (int i = coinsInPlay.size() - 1; i >= 0; i--) {
        Ball coin = coinsInPlay.get(i);
        
        if(randBonus1 > -1) {
         if(ball.xSpeed < 0) {
          if(2 == GetBonus(randBonus1)) {
            MoveCoinsAwayFromBall(coin,ball);
          }
         }
        }
         if(randBonus2 > -1) {
         if(ball.xSpeed > 0) {
          if(2 == GetBonus(randBonus2)) {
            MoveCoinsAwayFromBall(coin,ball);
          }
         }
        }
        
        if(ball.DetectCoinCollision(coin.x-radius, coin.y-radius)) {
          // based on ball x speed we decide which player gets the credit for this coin 
          if(ball.xSpeed < 0) {
           if(randBonus2 < 0) {
             player2Coins++;
             if(player2Coins >= bonusLevel) {
               // start the bonus phase
               // generate a the random bonus number and start the bonus timer
               player2Coins = 0; //<>//
               player2BonusStart = seconds;
               randBonus2 = random(0,1);
               if(1 == GetBonus(randBonus2)) {
                 paddle_2.l = 2*paddleLegth;
               }
               if(4 == GetBonus(randBonus2)) {
                 paddle_1.l = paddleLegth/2;
               }
               if(3 == GetBonus(randBonus2)) {
                 // coin dump
                 for(int c = 0; c < 10; c++) {
                   coinsInPlay.add(SpawnBall(2));
                 }
               }
             }
           }
          }
          else {
            if(randBonus1 < 0) {
             player1Coins++;
             if(player1Coins >= bonusLevel) {
               player1Coins = 0;
               player1BonusStart = seconds;
               randBonus1 = random(0,1);
               if(1 == GetBonus(randBonus1)) {
                 paddle_1.l = 2*paddleLegth;
               }
               if(4 == GetBonus(randBonus2)) {
                 paddle_2.l = paddleLegth/2;
               }
               if(3 == GetBonus(randBonus1)) {
                 // coin dump
                 for(int c = 0; c < 10; c++) {
                   coinsInPlay.add(SpawnBall(2));
                 }
               }
             }
            }
          }
          // remove coin 
          coin.drawExplode();
          coinsInPlay.remove(i);
          
          // coin collisions will randomly change the ball ySpeed up or down
          ball.drawExplode();
          float rand = random(0,1);
          if(rand < 0.50) {
             ball.ySpeed = ball.ySpeed+4; 
          }
          else {
              ball.ySpeed = ball.ySpeed-4;
          }
        }
        
      }
      
    }
  }
  // update all coin movement
  if(coinsInPlay.size() > 0) {
  for(Ball ball : coinsInPlay) {
    
      ball.UpdateBallPosition();
      ball.CollisionDetectionY(100);
      ball.CollisionDetectionY(900);
      ball.CollisionDetectionX(-50,0);
      ball.CollisionDetectionX(800,850);
  }
    }
  keyPressed();
  
  paddle_1.UpdatePaddlePosition();
  paddle_2.UpdatePaddlePosition();
  
  // remove balls that are off the screen, increment scores
  for (int i = ballsInPlay.size() - 1; i >= 0; i--) {
    Ball ball = ballsInPlay.get(i);
    if (ball.BallIsOffScreenLeft()) {
      // player 2 score
      player2Score++;
      ballsInPlay.remove(i);
    }
    else if(ball.BallIsOffScreenRight()) {
     // player 1 score
     player1Score++;
     ballsInPlay.remove(i);
    }
  }
}
  
