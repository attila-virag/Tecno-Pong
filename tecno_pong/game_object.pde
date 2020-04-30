 //<>//
// all game objects have a bounding box and collision detection based on the bounding box
// all objects are derived from this
// since each object is a different shape, the objetc are responsible to update the bounding box every turn
public abstract class GameObject {

  protected int x1, x2; // bounding box x
  protected int y1, y2; // bounding box y

  protected int x, y; // all objects have a position, where this actually is with respect to the bounding box is a derived object implementation
  protected int vX, vY; // all object have some velocity
  protected int maxSpeedX, maxSpeedY; // magnitude, max speed an object can have

  protected String objName; // mainly for logging
  public int objectType;
  boolean markForDelete;

  protected int updateInterval = 40; // in ms - this adds a partial delay effect to user controls, should be between 0-300ms
  protected int lastControlTime;
  protected boolean allowControl; // if this object can be controlled right now

  protected Logger logger;
  private void LogMessage(String msg) {
    String message =  objName+">>" + msg;
    logger.LogMessage(message);
  }

  public GameObject(Logger logger, int x, int y, int vX, int vY, int maxSpeedX, int maxSpeedY, String name, int objectType) {
    this.logger = logger; //<>//
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
    UpdateObjectState();
    LogMessage("Object Created");
  }

  public abstract void drawObject();

  public abstract void UpdateObjectState();


  public int GetObjectYPosition() {
    return y;
  }


  public void UpdatePosition() {
    x = x+vX;
    y = y+vY;
  }

  // hit test methods:

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

  // checks if a given X,Y is inside the current bounding box
  public abstract boolean IsPointInsideBoundingBox(int X, int Y);

  // checks if left bounding box has moved past test point X
  // resets object x to place left bounding box at the edge of X
  public abstract boolean LeftBoundingBoxCollision(int X); 

  // checks if right bounding box has moved past test point X
  // resets object x to place right bounding box at the edge of X
  public abstract boolean RightBoundingBoxCollision(int X);

  // checks if top bounding box has moved past test point Y
  // resets object y to place top bounding box at the edge of Y
  public abstract boolean TopBoundingBoxCollision(int Y);

  // checks if right bounding box has moved past test point X
  // resets object x to place right bounding box at the edge of X
  public abstract boolean BottomBoundingBoxCollision(int Y);

  boolean LeftWallCollision() {
    if (LeftBoundingBoxCollision(GameBoundaries.PLAY_LEFT)) {
      LogMessage("Collision with Left Boundary");
      // we will also move the object back to the boundary
      return true;
    }
    return false;
  }

  boolean RightWallCollision() {
    if (RightBoundingBoxCollision(GameBoundaries.PLAY_RIGHT)) {
      LogMessage("Collision with Right Boundary");
      return true;
    }
    return false;
  }

  boolean TopWallCollision() {
    if (TopBoundingBoxCollision(GameBoundaries.PLAY_TOP)) {
      LogMessage("Collision with Top Boundary");
      return true;
    }
    return false;
  }

  boolean BottomWallCollision() {
    if (BottomBoundingBoxCollision(GameBoundaries.PLAY_BOTTOM)) {
      LogMessage("Collision with Bottom Boundary");
      return true;
    }
    return false;
  }

  // marks object for delet if off screen
  boolean IsObjectOffScreen() {
    if (x < GameBoundaries.PLAY_LEFT-50 || x > GameBoundaries.PLAY_RIGHT+50) {
      LogMessage("Off Screen X axis, mark for delete ");
      markForDelete = true;
      return true;
    }
    if (y < GameBoundaries.PLAY_TOP-50 || y > GameBoundaries.PLAY_BOTTOM +50) {
      LogMessage("Off Screen Y axis, mark for delete ");
      markForDelete = true;
      return true;
    }
    return false;
  }

  // end hit test methods

  public boolean AllowControl() {
    return allowControl;
  }

  public void LockControl() {
    allowControl = false;
  }

  public void ResetAllowControl() {
    allowControl = true;
  }

  public void SetvX(int vX) {
    if (abs(vX) > maxSpeedX) {
      if (vX < 0) {
        this.vX = -maxSpeedX;
      } else {
        this.vX = maxSpeedX;
      }
    } else {
      this.vX = vX;
    }

    lastControlTime = millis();
    allowControl = false;
  }

  public void SetvY(int vY) {
    if (abs(vY) > maxSpeedY) {
      if (vY < 0) {
        this.vY = -maxSpeedY;
      } else {
        this.vY = maxSpeedY;
      }
    } else {
      this.vY = vY;
    }

    lastControlTime = millis();
    allowControl = false;
  }

  public void Reverse_vY() {
    this.vY = -1*this.vY;
  }
  
  public void Reverse_vX() {
    this.vX = -1*this.vX;
  }

  public void Increase_vX() {
    if (allowControl) {
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
