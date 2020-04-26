

final class Player extends GameObject {

  private boolean autoMode = false; // means this player is computer controlled

  final int w = 20; // the width of the paddle
  private int l = 200; // the lenght of the paddle, can change during a game
  private int strokeW = 5;

  public Player(Logger logger, int x, int y, int vX, int vY, int maxSpeedX, int maxSpeedY, String name, int objectType) {
   super(logger,x,y,vX,vY, maxSpeedX,maxSpeedY, name, objectType);
  }

  public void drawObject() {
    push();
    
    strokeWeight(strokeW);
    stroke(255,255,0);
    fill(0,0,0);
    rect(x,y,w,l);
    
    pop();
  }
  
  public void UpdateObjectState() {
    if(millis() - lastControlTime > updateInterval) {
      allowControl = true;
    }
    // update bounding rect
    x1 = x;
    y1 = y-10;
    x2 = x+w;
    y2 = y+l+100;
  }
}
