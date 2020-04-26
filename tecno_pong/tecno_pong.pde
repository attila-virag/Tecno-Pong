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
  size(xSize, ySize);
  //background(0,0,0);
}

void draw() {
 
  game.drawScreen();
  
  //game.updateState();
  
}
