final int  xSize = 800;
final int ySize = 900;

// gameObjects
static abstract class GameBoundaries {
  static final int PLAY_TOP = 100;
  static final int PLAY_LEFT = 0;
  static final int PLAY_RIGHT = 800;
  static final int PLAY_BOTTOM = 900;
}

Game game = new Game();

// creating canvas
void setup() {
  size(800, 900);
  //background(0,0,0);
}

int i;
// key code for the enter button is 10
void keyPressed() {
  // depensing on the game state we listen for different keys
  switch(game.GetGameState()) {
    case (GameState.START_SCREEN) : 
    {
      if (keyCode == 10) { // enter button
        game.StartGame();
      }

      break;
    }
    case (GameState.PLAYING) : 
    {
      // player 1 controls
      if (key == 'w' || key == 'W') { 
        game.player1.Decrease_vY();
      }
      if (key == 's' || key == 'S') { 
        game.player1.Increase_vY();
      }

      // player 2 controls
      if (keyCode == UP) {
        game.player2.Increase_vY();
      }
      if (keyCode == DOWN) {
        game.player2.Decrease_vY();
      } 
      break;
    }
    case (GameState.PAUSE) : 
    {
    }
    case (GameState.END_SCREEN) : 
    {
    }
  default :
  }
}
// 
void keyReleased() { 
  // depensing on the game state we listen for different keys
  switch(game.GetGameState()) {
    case (GameState.START_SCREEN) : 
    {
      if (keyCode == 10) {
        // start game
        println("control" + ++i);
        //game.LockControl();
      }
      break;
    }
    case (GameState.PLAYING) : 
    {
      if (keyCode == UP || keyCode == DOWN) {
        game.player2.ResetAllowControl();
      }
      if (key == 'w' || key == 's') { 
        game.player1.ResetAllowControl();
      }
    }
    case (GameState.PAUSE) : 
    {
    }
    case (GameState.END_SCREEN) : 
    {
    }
  default :
  }
}

void draw() {

  game.drawScreen();

  game.UpdateGame();

  //println(str(millis()));
}
