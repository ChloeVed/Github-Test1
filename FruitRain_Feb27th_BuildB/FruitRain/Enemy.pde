/**
 * Circle Dodge Game's enemy class, Enemy.
 * 
 * @author Taisann Kham
 * @version 1.0 Course : ITEC 2140, Fall, 2020 Written: Spring 2020 (Janurary - May)
 * 
 * Enemy class contains the attributes and methods for an enemy.
 */
public class Enemy {
  final private int BLACK = color(0, 0, 0);  
  final private int RED = color(255, 0, 0);
  final private int GREEN = color(0, 255, 0); 
  //final private int PURPLE = color(255, 0, 255);
  final private int YELLOW = color(255, 255, 0);
  private int enemyStartingEdge; //enemy's random starting location (either x or y)
  private float enemyX;     //x coordinate of the center of the enemy circle
  private float enemyY;     //y coordinate of the center of the enemy circle
  private int enemySize;    //diameter of the enemy circle
  private color enemyColor; //color of the enemy circle
  private float enemySpeed; //enemy's moving speed
  private float enemySpeedAdjustor = 0.5;  /* Use a value between 0.1 and 1.0 
to change the enemy speed. Smaller value will slow down the enemy, making
it easier for testing the game. */
//We probably want the "enemies" to either move very slowly or not move at all
  private FruitRain game;
  private int type;
  private int timeSinceSpawned;
  
  /**
   * Method: Enemy class constructor
   *
   * Initialize the attributes.
   * For type:
   *   1 purple chaser (will die after chasing for 300 frames' time)
   *   2 yellow fast
   *   3 gree big slow
   *   4 red regular
   *
   *   Colors may be changed if we can't get pngs of fruit working or something
   */
  public Enemy(FruitRain game) {
    this.game = game;
    spawnEnemy();
  }
  
  /**
   * Method: getEnemyX
   */
  public float getEnemyX() {
    return enemyX;
    
  }

  /**
   * Method: getEnemyY
   */
  public float getEnemyY() {
    return enemyY;
    
  }

  /**
   * Method: getEnemySize
   */
  public float getEnemySize() {
    return enemySize;
    
  }

  /**
   * Method: spawnEnemy
   *
   * This method will create an enemy circle just outside of the window.
   */
  public void spawnEnemy()
  {
    timeSinceSpawned = 0;
    type = 2 + (int) random(3); //type is randomly generated (1 to 4).
    //We need to make it so that we get one of each type of fruit
    /*
    if(type == 1) //Chaser Enemy
    {
      enemySize = 50;
      enemyColor = PURPLE;
      enemySpeed = 4;
    }
    */
    if (type == 2) //Fast Enemy
    {
      enemySize = 20;
      enemyColor = YELLOW;
      enemySpeed = 11;
    }
    else if (type == 3) //Big Enemy
    {
      enemySize = 200;
      enemyColor = GREEN;
      enemySpeed = 4;
    }    
    else     //Regular Enemy
    {
      enemySize = 50;
      enemyColor = RED;
      enemySpeed = 7;
    }
    
    //random(4) generate a random float value in range [0, 4)
    //after converting to int, it has possible values 0, 1, 2, and 3.
    //0 - left, 1 - right, 2 - top, 3 - bottom
    //enemyStartingEdge = (int) random(4); 
    enemyStartingEdge = 2;
    /*
    if(enemyStartingEdge == 0) //Spawn from Left Edge of the Window 
    {
      //set x to a value that is to the left of the window's left edge. 
      //The enemy circle will be invisible
      enemyX = 0 - enemySize - 5;
      //set y to a random value between 0 and the window's height.
      enemyY = random(0, game.height);
    }
    else if(enemyStartingEdge == 1)  //Spawn from Right Edge of the Window 
    {
      //set x to be outside the right edge of the window
      enemyX = game.width + enemySize + 5;  
      //set y to a random value between 0 and the window's height
      enemyY = random(0, game.height); 
    }
    */
    if(enemyStartingEdge == 2) //Spawn from Top Edge of the Window 
    {
      //set x to a random value between 0 and the window's width
      enemyX = random(0, game.width); 
      //set y to be above the top edge of the window
      enemyY = 0 - enemySize - 5; 
    }
    /*
    else  //enemyStartingEdge == 3: Spawn from Bottom Edge of the Window 
    {
      //set x to a random value between 0 and the window's width
      enemyX = random(0, game.width); 
      //set y to be below the bottom edge of the window
      enemyY = game.height + enemySize + 5; 
    }
    */
    
    fill(enemyColor);
    circle(enemyX, enemyY, enemySize);
  }
  
  /**
   * Method: drawEnemy
   *
   * This method will move the enemy to its next location and 
   * then draw the circle representing the enemy.
   */
  public void drawEnemy()
  {
    timeSinceSpawned ++;
    
    //calculate the shift from current location to the next
    float positionDelta = enemySpeed * enemySpeedAdjustor;
    
    if(outOfSight()) /*Currently meant to determine if an enemy
    leaves the game window and therefore whether or not to de-spawn/re-spawn them
    
    We will alter this method to always de-spawn the fruit (and depending on if it's
    a regular question or a bonus round, possibly penalize the player.
    We may choose to have fruit stationary for the regular questions
    */
    {
      spawnEnemy();
    }
    
    
    /* Unused starting edges
    else if(enemyStartingEdge == 0)//left spawn, move righward
    {
      //add change to the enemy's x coordinate
      enemyX += positionDelta;
    }
    else if (enemyStartingEdge == 1)//right spawn, move leftward
    {
      //subtract change from the enemy's x coordinate
      enemyX -= positionDelta;
    }
    */
    
    if (enemyStartingEdge == 2)//top spawn, move downward
    {
      //add change to the enemy's y coordinate
      enemyY += positionDelta;
    }
    
    /*
    else//bottom spawn, move upward
    {
      //subtract change from the enemy's y coordinate
      enemyY -= positionDelta;
    }
    */
    
    fill(enemyColor);
    circle(enemyX, enemyY, enemySize); 
  }
  
  /**
   * Method: outOfSight
   *
   * This method will detect when the enemy moves out of the game window.
   * then draw the circle representing the enemy.
   *
   * @return whether the enemy's location will make the enemy disappear 
   *         from the game window
   */
  public boolean outOfSight()
  {
    //left spawned and disappeared into the right edge
    if(enemyStartingEdge == 0 && enemyX >= game.width + enemySize + 5)
    {
      return true;
    }  
    //right spawned and disappeared into the left edge
    else if (enemyStartingEdge == 1 && enemyX <= 0 - enemySize - 5)
    {
      return true;
    }
    //top spawned and disappeared into the bottom edge
    else if (enemyStartingEdge == 2 && enemyY >= game.height + enemySize + 5)
    {
      return true;
    } 
    //bottom spawned and disappeared into the top edge
    else if(enemyY <= 0 - enemySize - 5)
    {
      return true;
    }
    
    //For type 1 chaser enemy, if the time passed since spawned
    //is greater than 300, it also disappears.
    if(type == 1 && timeSinceSpawned > 300)
    {
      return true;
    }
    
    return false;
  }
}
