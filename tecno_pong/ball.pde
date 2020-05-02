
final class Ball extends GameObject {

  private int ballRadius = 20;

  public Ball(Logger logger, int x, int y, int vX, int vY, int maxSpeedX, int maxSpeedY, String name) {
    super(logger, x, y, vX, vY, maxSpeedX, maxSpeedY, name, ObjectType.BALL);
  }

  public void drawObject() {
    push();

    int w = ballRadius*2;
    int l = ballRadius*2;
    int R = 0;
    int G = 0;
    int B = 255;

    stroke(R, G, B);
    strokeWeight(5);
    fill(0, 0, 0);
    ellipse(x, y, w, l);
    pop();
  }

  public void UpdateObjectState() {
    if (millis() - lastControlTime > updateInterval) {
      allowControl = true;
    }
    // update bounding rect
    x1 = x-ballRadius;
    x2 = x+ballRadius;
    y1 = y-ballRadius;
    y2 = y+ballRadius;
  }

  public boolean LeftBoundingBoxCollision(int X) {
    if (X >= x1) {
      // reset center point to be outside of colision surface
      x = X+ballRadius+1;
      return true;
    }
    return false;
  }

  public boolean RightBoundingBoxCollision(int X) {
    if (X <= x2) {
      // reset center point to be outside of colision surface
      x = X-ballRadius-1;
      return true;
    }
    return false;
  }

  public boolean TopBoundingBoxCollision(int Y) {
    if (Y >= y1) {
      // reset center point to be outside of colision surface
      y = Y+ballRadius+1;
      return true;
    }
    return false;
  }

  public boolean BottomBoundingBoxCollision(int Y) {
    if (Y <= y2) {
      // recet center point to be outside of colision surface
      y= Y-ballRadius-1;
      return true;
    }
    return false;
  }
}
