
// all game objects have a bounding box and collision detection based on the bounding box
// all objects are derived from this
// since each object is a different shape, the objetc are responsible to update the bounding box every turn
public abstract class GameObject {

  protected int x1, x2; // bounding box x
  protected int y1, y2; // bounding box y

  protected int x, y; // all objects have a position
  protected int vX, vY; // all object have some velocity
  protected int maxSpeedX, maxSpeedY; // magnitude, max speed an object can have

  protected String objName;
  boolean markForDelete;

  protected Logger logger;
  private void LogMessage(String msg) {
    String message =  objName+">>" + msg;
  }

  public GameObject(Logger logger, int x, int y, int vX, int vY, int maxSpeedX, int maxSpeedY, String name) {
    this.logger = logger;
    this.x = x;
    this.y = y;
    this.vX = vX;
    this.vY = vY;
    this.maxSpeedX = maxSpeedX;
    this.maxSpeedY = maxSpeedY;
    this.objName = name + ", ID: " + nf(++objectNumber, 5);
    this.markForDelete = false;
    LogMessage("Object Created");
  }


  // collision detector for all objects
  boolean DetectObjectCollision(GameObject other) {
    if (this.x1 < other.x1 + other.x2 &&
      this.x1 + this.x2 > other.x1 &&
      this.y1 < other.y1 + other.y2 &&
      this.y1 + this.y2 > other.y1) {
      // collision detected!
      LogMessage("Collision with object " + other.objName);
      return true;
    }
    return false;
  }

  boolean LeftWallCollision() {
    if (x1 < GameBoundaries.PLAY_LEFT) {
      LogMessage("Collision with Left Boundary");
      return true;
    }
    return false;
  }

  boolean RightWallCollision() {
    if (x2 > GameBoundaries.PLAY_LEFT) {
      LogMessage("Collision with Left Boundary");
      return true;
    }
    return false;
  }

  boolean TopWallCollision() {
    if (y1 < GameBoundaries.PLAY_TOP) {
      LogMessage("Collision with Top Boundary");
      return true;
    }
    return false;
  }
  
  boolean BottomWallCollision() {
    if (y1 > GameBoundaries.PLAY_BOTTOM) {
      LogMessage("Collision with Bottom Boundary");
      return true;
    }
    return false;
  }
  //
  boolean IsObjectOffScreen() {
    if (x < GameBoundaries.PLAY_LEFT-50 || x > GameBoundaries.PLAY_RIGHT+50) {
      LogMessage("Off Screen X axis, mark for delete ");
      return true;
    }
    if (y < GameBoundaries.PLAY_TOP-50 || y > GameBoundaries.PLAY_BOTTOM +50) {
      LogMessage("Off Screen Y axis, mark for delete ");
      return true;
    }
  }
}
