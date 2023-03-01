/**
 * Circle Dodge Game's player class, Player.
 * 
 * @author Taisann Kham
 * @version 1.0 Course : ITEC 2140, Fall, 2020 Written: Spring 2020 (Janurary - May)
 * 
 * Player class contains the attributes and methods for the player.
 */
public class Player {
  final private int AQUA = color(0, 255, 255);
  private float playerX;  //x coordinate of the center of the player circle
  private float playerY;  //y coordinate of the center of the playe circle
  private int playerSize; //diameter of the player circle
  private color playerColor = AQUA; //color of the player circle
  private FruitRain game; 
  
  /**
   * Method: Player class constructor
   *
   * Initialize the attributes.
   */
  public Player(FruitRain game) {
    this.game = game;
    playerX = game.width/2;  //player x is in the middle of the window's width
    playerY = game.height/2; //player y is in the middle of the window's height
    playerSize = 50;         //player diameter is 50
  
    fill(playerColor);   //set the fill color
    circle(playerX, playerY, playerSize);  //display the circle
  }
  
  /**
   * Method: getPlayerX
   */
  public float getPlayerX() {
    return playerX;
    
  }

  /**
   * Method: getPlayerY
   */
  public float getPlayerY() {
    return playerY;
    
  }
  
  /**
   * Method: drawPlayer
   * 
   * Set the player's coordinates where the mouse cursor is.
   * Then draw a circle at the location.
   */ 
  public void drawPlayer()
  {
    playerX = mouseX;
    playerY = mouseY;
    fill(playerColor);
    circle(playerX, playerY, playerSize);
  }
  
  
  
  /**
   * Method: collide
   *
   * Check whether the player circle overlaps with an enemy circle,
   * if so, a collision occurs and the game is over.
   */
  
  /*
   This method is no longer relevant
  private void collide(Enemy e) {
    //distance between the centers of the player and the enemy
    float distance = dist(this.playerX, this.playerY, e.getEnemyX(), e.getEnemyY());
    float playerRadius = this.playerSize/2;  //diameter / 2 is radius
    float enemyRadius = e.getEnemySize()/2;
    
    // distance between two centers < the sum of two radii: collision
    if(distance < enemyRadius + playerRadius) {
      System.out.println(e.type);
      System.out.println(distance);
      System.out.println(enemyRadius);
      System.out.println(playerRadius);
      game.setup();  //restart the game
    }
  }
  */
}
