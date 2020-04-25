final int  xSize = 800;
final int ySize = 900;

//create game obj

Game game = new Game();

// creating canvas
void setup() {
  size(xSize, ySize);
  //background(0,0,0);
}

void draw() {
 
  game.drawScreen();
  
  game.updateState();
  
}
