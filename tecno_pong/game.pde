
// gamestate
static abstract class GameState {
  static final int START_SCREEN = 0;
  static final int PLAYING = 1;
  static final int PAUSE = 2;
  static final int END_SCREEN = 3;
}

final class Game 
{ 
  int gameState;
  // should only be constructed at the beginning of the program
  public Game() {   
    this.gameState = GameState.START_SCREEN;    
  }
  
  // this method return us to the starting state
  // 
  public void ResetGame() {
    this.gameState = GameState.START_SCREEN;    
  }
  // this method transitions to gameplay state
  public void SartGame() {
    this.gameState = GameState.PLAYING;
  }
  
  public void 
  
  
  void SetState(int gameState) {
   this.gameState = gameState;  
  }
  
  int GetGameState() {return this.gameState;}
  
  
  
  
  
  
}
