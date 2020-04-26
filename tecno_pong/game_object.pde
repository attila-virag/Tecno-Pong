
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
  public int objectType;
  boolean markForDelete;

  protected int updateInterval = 40; // in ms - this adds a partial delay effect to user controls, should be between 0-300ms
  protected int lastControlTime;
  protected boolean allowControl;

  protected Logger logger;
  private void LogMessage(String msg) {
    String message =  objName+">>" + msg;
    logger.LogMessage(message);
  }

  public GameObject(Logger logger, int x, int y, int vX, int vY, int maxSpeedX, int maxSpeedY, String name, int objectType) {
    this.logger = logger;
    this.x = x;
    this.y = y;
    this.vX = vX;
    this.vY = vY;
    this.maxSpeedX = maxSpeedX;
    this.maxSpeedY = maxSpeedY;
    this.objName = name + ", ID: " + nf(++objectNumber, 5);
    this.objectType = objectType;
    this.markForDelete = false;
    this.lastControlTime = millis();
    this.allowControl = true;
    LogMessage("Object Created");
  }
  
  public void drawObject() {
    return;
  }

  public void UpdateObjectState() {
    return;
    // check if control allowed timer is up, etc implement in child classes
  }
  
  public void UpdatePosition() {
   x = x+vX;
   y = y+vY;
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
    if (y2 > GameBoundaries.PLAY_BOTTOM) {
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
    return false;
  }

  public boolean AllowControl() {
    return allowControl;
  }

  public void LockControl() {
    allowControl = false;
  }

  public void ResetAllowControl() {
    allowControl = true;
  }

  public void Increase_vX() {
    if (allowControl) { //<>//
      if (abs(vX) < maxSpeedX) {
        vX++;
        lastControlTime = millis();
        allowControl = false;
      }
    }
  }

  public void Decrease_vX() {
    if (allowControl) {
      if (abs(vX) < maxSpeedX) {
        vX--;
        lastControlTime = millis();
        allowControl = false;
      }
    }
  }

  public void Increase_vY() {
    if (allowControl) {
      if (abs(vY) < maxSpeedY) {
        vY++;
        lastControlTime = millis();
        allowControl = false;
      }
    }
  }
  public void Decrease_vY() {
    if (allowControl) {
      if (abs(vY) < maxSpeedY) {
        vY--;
        lastControlTime = millis();
        allowControl = false;
      }
    }
  }
}
