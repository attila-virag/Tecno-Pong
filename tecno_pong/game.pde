static int objectNumber = 0; //<>// //<>// //<>// //<>//

// gamestate
static abstract class GameState {
  static final int START_SCREEN = 0;
  static final int PLAYING = 1;
  static final int PAUSE = 2;
  static final int END_SCREEN = 3;
}

// gameObjects
static abstract class ObjectType {
  static final int PLAYER_1 = 1;
  static final int PLAYER_2 = 2;
  static final int BALL = 3;
  static final int COIN = 4;
}

final class Logger {
  private int loggerType;

  public Logger(int type) {
    // type 0 is none, type 1 is console, type 2 is to file
    this.loggerType = type;
  }

  public void LogMessage(String msg) {
    if (loggerType == 0) {
      return;
    }
    String message =  str(millis()) + ">>" + msg;
    if (loggerType == 1) {
      println(message);
    } else if (loggerType == 2) {
      println("Error: logger not implemented");
    } else {
      println("Error: logger not implemented");
    }
  }
}

final class Game 
{ 

  public Player player1;
  public Player player2;
  private ArrayList<GameObject> allGameObjects;

  private int player1Score;
  private int player2Score;

  private int gameTime; // in seconds

  private Logger logger;
  private void LogMessage(String msg) {
    String message =  "Game"+">>" + msg;
    logger.LogMessage(message);
  }

  private int gameState;
  // should only be constructed at the beginning of the program
  public Game() {   

    this.logger = new Logger(1);
    LogMessage("Game Created");

    SetState(GameState.START_SCREEN);
  }

  // set gamestate methods, this should be triggered by user actions
  // set up whatever specific actions are needed at each state transition
  public void ResetGame() {
    SetState(GameState.START_SCREEN);
  }
  // this method transitions to gameplay state
  public void StartGame() {
    SetState(GameState.PLAYING);
    allGameObjects = new ArrayList();
    player1Score = 0;
    player2Score = 0;

    // set game time zero
    this.gameTime = 0;

    // create the players
    // max speed
    this.player1 = new Player(this.logger, 60, 300, 0, 0, 0, 15, "Player1", 1);
    allGameObjects.add(this.player1);
    this.player2 = new Player(this.logger, 740, 300, 0, 0, 0, 15, "Player2", 2);
    allGameObjects.add(this.player2);
  }

  private GameObject SpawnBall() {
    int yMin, yMax, xMin, xMax;
    yMin = 1;
    yMax = 7;
    xMin = 4;
    xMax = 9;

    int vX = int(random(xMin, xMax));
    int vY = int(random(yMin, yMax));
    float xDirection = random(0, 1);
    float yDirection = random(0, 1);
    if (xDirection < 0.50) {
      vX =vX*-1;
    }
    if (yDirection < 0.50) {
      vY = vY*-1;
    }
    return new Ball(this.logger, 400, 500, vX, vY, 10, 10, "Ball");
  }

  // paused
  public void Pause() {
    SetState(GameState.PAUSE);
  }

  // unpaused
  public void UnPause() {
    SetState(GameState.PLAYING);
  }

  // transition to game over screen
  public void GameOver() {
    SetState(GameState.END_SCREEN);
  }


  private void SetState(int gameState) {
    LogMessage("Gamestate changed to state "+gameState);
    this.gameState = gameState;
  }

  int GetGameState() {
    return this.gameState;
  }

  // end gamestate methods

  // draw screen methods
  // this is where we draw all the objects at every draw cycle
  public void drawScreen() {

    switch(GetGameState()) {
      case (GameState.START_SCREEN) : 
      drawStartScreen(); 
      break;
      case (GameState.PLAYING) : 
      drawPlayScreen(); 
      break;
      case (GameState.PAUSE) : 
      drawPauseScreen(); 
      break;
      case (GameState.END_SCREEN) : 
      drawEndScreen(); 
      break;
    default : 
      LogMessage("Error: invalid gamestate");
    }
  }

  private void drawStartScreen() {
    // temp, add functionality
    size(800, 900);
    background(0, 0, 0);
    textSize(80);
    fill(255, 0, 255);
    text("TECNO", 120, 250);
    fill(0, 0, 255);
    text("PONG", 400, 250);
    fill(255, 0, 0);
    text("START", 250, 400);
    fill(0, 255, 0);
    text("HOW TO PLAY", 100, 520);
    fill(168, 0, 104);
    text("INTERACTIVE ART", 40, 640);
    fill(0, 0, 0);
    stroke(255, 115, 0);
    strokeWeight(4);
    rect(-2, -2, 803, 160);
    stroke(0, 255, 166);
    ellipse(380, 100, 60, 60);
  }

  void DrawScoreboard() {
    stroke(255, 255, 0);
    strokeWeight(5);
    line(0, 100, 800, 100);
    line(0, 898, 800, 898);

    textSize(50);
    fill(255, 0, 0);
    text(player1Score, 30, 40); 
    text(player2Score, 640, 40); 
    String timeMsg = "Timer: "+gameTime;
    text(timeMsg, 250, 50);

    //score 
    //if (randBonus1 > -1) {
    //  text("BONUS", 30, 90);
    //} else {
    //  text(player1Coins, 30, 90);
    //}
    //if (randBonus2 > -1) {
    //  text("BONUS", 610, 90);
    //} else {
    //  text(player2Coins, 640, 90);
    //}
  }


  private void drawPlayScreen() {
    // draw score board and other base screen features
    background(0, 0, 0);
    // the dispeser
    stroke(0, 255, 0);
    strokeWeight(5);
    fill(0, 0, 0);
    ellipse(400, 500, 40, 40);

    DrawScoreboard();

    for (GameObject obj : allGameObjects) {
      obj.drawObject();
    }
  }

  private void drawPauseScreen() {
  }

  private void drawEndScreen() {
  }

  // we call this after draw game screen every draw cycle
  public void UpdateGame() {
    switch(GetGameState()) {
      case (GameState.START_SCREEN) : 
      updateStartScreen(); 
      break;
      case (GameState.PLAYING) : 
      updatePlayState(); 
      break;
      case (GameState.PAUSE) : 
      //updatePauseScreen(); 
      break;
      case (GameState.END_SCREEN) : 
      //updateEndScreen(); 
      break;
    default :  //<>//
      println("Error: invalid gamestate");
    }
    // first move all obe
  }


  private void updateStartScreen() {
    // for now just check if we pressend
    // checkForPlayerControls();
  }

  private void updatePlayState() {
    // delete any object marked for delete first

    for (int i = allGameObjects.size()-1; i >= 0; i--) {
      GameObject obj = allGameObjects.get(i);
      if (obj.markForDelete) {
        obj.LogMessage("Object was removed");
        allGameObjects.remove(i);
      }
    }

    // keep track of balls in play
    int ballsInPlay = 0;
    // keep track of coins in play
    int coinsInPlay = 0;

    // update position of all objects
    for (GameObject obj : allGameObjects) {
      if (obj.objectType == ObjectType.BALL) {
        ballsInPlay++;
      }
      if (obj.objectType == ObjectType.COIN) {
        coinsInPlay++;
      }
      // update position of all objects
      obj.UpdatePosition();

      // check if object has left the screen, object will be marked for delete
      if (obj.IsObjectOffScreen()) {
        // if the object is a ball we can record a score here
        continue;
      }

      //check for collisions

      // check boundary collisions
      if (obj.TopWallCollision()) {
        // case paddle object
        if (obj.objectType == ObjectType.PLAYER_1 || obj.objectType == ObjectType.PLAYER_2) {
          obj.SetvY(1);
        } else if (obj.objectType == ObjectType.BALL) {
          obj.Reverse_vY();
        }
      }
      if (obj.BottomWallCollision()) {
        if (obj.objectType == ObjectType.PLAYER_1 || obj.objectType == ObjectType.PLAYER_2) {
          obj.SetvY(-1);
        } else if (obj.objectType == ObjectType.BALL) {
          obj.Reverse_vY();
        }
      }

      // do special collision detection in case of ball
      if (obj.objectType == ObjectType.BALL) {
        if (obj.vX < 0) { // object is moving left
          if (player1.y1 < obj.y2 && player1.y2 > obj.y1) { // obj and paddle could collide
            if (player1.x1 < obj.x) { // ball did not move past the paddle yet
              if (obj.LeftBoundingBoxCollision(player1.x2)) { // collision
                obj.LogMessage("Collision with player 1");
                obj.Reverse_vX();
              }
            }
          } else if (player1.autoMode) { // stear the paddle toward the ball
            // accelerate paddle up
            if (player1.y1 > obj.y2) {
              player1.Decrease_vY();
            } else if (player1.y2 < obj.y1) {
              player1.Increase_vY();
            }
          }
        } else if (obj.vX > 0) { // obj is moving right
          if (player2.y1 < obj.y2 && player2.y2 > obj.y1) {
            if (player2.x2 > obj.x) {
              if (obj.RightBoundingBoxCollision(player2.x1)) {
                obj.LogMessage("Collision with player 2");
                obj.Reverse_vX();
              }
            }
          } else if (player2.autoMode) {
             // accelerate paddle up
            if (player2.y1 > obj.y2) {
              player2.Decrease_vY();
            } else if (player2.y2 < obj.y1) {
              player2.Increase_vY();
            }
          }
        }
      }
    }

    // check for object collisions

    // spawn new objects as needed
    if (ballsInPlay < 1) {
      allGameObjects.add(SpawnBall());
    }


    // update all other object states
    for (GameObject obj : allGameObjects) {
      obj.UpdateObjectState();
    }

    // check for any user inputs
  }
}
