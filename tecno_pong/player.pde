

final class Player extends GameObject {

  private boolean autoMode = true; // means this player is computer controlled

  final int w = 20; // the width of the paddle
  private int l = 200; // the lenght of the paddle, can change during a game
  private int strokeW = 5;
  

  public Player(Logger logger, int x, int y, int vX, int vY, int maxSpeedX, int maxSpeedY, String name, int objectType) {
   super(logger,x,y,vX,vY, maxSpeedX,maxSpeedY, name, objectType); //<>//
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
   x2 = x+w;
   y1 = y;
   y2 = y+l;
  }
  
  public boolean LeftBoundingBoxCollision(int X) {
    if(X >= x1) {
     // reset center point to be outside of colision surface
     x = X+1;
     return true;
    }
    return false;
  }

  public boolean RightBoundingBoxCollision(int X){
    if(X <= x2) {
     // reset center point to be outside of colision surface
     x = X-w-1;
     return true;
    }
    return false;
  }
  
  public boolean TopBoundingBoxCollision(int Y){
    if(Y >= y1) {
     // reset center point to be outside of colision surface
     y = Y+1;
     return true;
    }
    return false;
  }
  
  public boolean BottomBoundingBoxCollision(int Y) {
    if(Y <= y2) {
     // recet center point to be outside of colision surface
     y= Y-l-1;
     return true;
    }
    return false;
  }
  

}
