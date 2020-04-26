static int objectNumber = 0;

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
    
    
    // create the players
    // max speed
    this.player1 = new Player(this.logger,60, 100,0,0, 0,15,"Player1",1);
    allGameObjects.add(this.player1);
    this.player2 = new Player(this.logger,740, 100,0,0, 0,15,"Player2",2);
    allGameObjects.add(this.player2);
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
      drawStartScreen(); break;
      case (GameState.PLAYING) : 
      drawPlayScreen(); break;
      case (GameState.PAUSE) : 
      drawPauseScreen(); break;
      case (GameState.END_SCREEN) : 
      drawEndScreen(); break;
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

  private void drawPlayScreen() {
    background(0,0,0);
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
      updatePauseScreen(); 
      break;
      case (GameState.END_SCREEN) : 
      updateEndScreen(); 
      break;
    default : 
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
    
    // update position of all objects
    for(GameObject obj : allGameObjects) {
     // update position of all objects
     obj.UpdatePosition();
     
     //check for collisions
    
    // check boundary collisions
    // TODO there is a bug in this as objects can still "push through"
    if(obj.TopWallCollision() || obj.BottomWallCollision()) {
      if(obj.objectType == ObjectType.PLAYER_1 || obj.objectType == ObjectType.PLAYER_2) { 
        obj.vY=0;  // if paddle
      }
      // for ball we need to reflect vY
    }
    
    // check for object collisions
    
    // update all other object states
      obj.UpdateObjectState();
    }

    
    // update all other object states
    for(GameObject obj : allGameObjects) {
     obj.UpdateObjectState();
    }
    
    // check for any user inputs
  }

  private void updatePauseScreen() {
  }
 //<>//
  private void updateEndScreen() {
  } //<>//
  
}
