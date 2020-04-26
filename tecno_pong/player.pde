

final class Player extends GameObject {

  private int playerNumber; // 1 = left, 2  = right

  private int maxSpeed; // part of game difficulty

  private boolean autoMode; // means this player is computer controlled

  final int w = 20; // the width of the paddle
  private int l; // the lenght of the paddle, can change during a game


  Player(int x, int y, int maxSpeed, boolean auto, int playerNUmber) {
    this.x = x;
    this.y = y;

    this.maxSpeed = maxSpeed;

    this.autoMode = auto;

    this.playerNumber = playerNumber;
  }
}
