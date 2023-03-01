/**
 * Circle Dodge Game's main file CircleDodge.pde
 * 
 * @author Taisann Kham
 * @version 1.0 Course : ITEC 2140, Fall, 2020 Written: Spring 2020 (Janurary - May)
 * 
 * This file is similar to a Java class that contains the main method. 
 * The Processing game engine ("the main method") starts executing the game by 
 * invoking the method setup() and then will invoke draw() 60 times/sec (the default frame rate).
 * The frame rate can be changed.
 *          
 * The two most important methods in this file:
 *  setup():  Initilize variables when app is started, only one time.
 *  draw():   Update variables. Executed over and over again.
 */
import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;
import java.awt.event.KeyEvent;
import javax.swing.*;

final public int BLACK = color(0, 0, 0);
final public int SKY = color(113, 212, 240);
final public int RED = color(255, 0, 0);
final public int RASPBERRY = color(235, 68, 126);

//public Player player;
public Enemy[] enemies;

public int guess;
public int quizSize;
public int quizIndex;
public int healthPoints;
public int possiblePoints;
public int correct;
public int scenario;

public boolean start; // a boolean variable that represents whetner the game is started.
public int score = 0; // score earned. Potential points earned is based on whether or not they guess wrong. 1000 points for each question, a wrong answer reduces this by 250
public int hitPoints = 5; //player starts with 5 hit points, they lose hit points whenever they get questions wrong. Players can earn back 1 hit point every 6 questions
public ArrayList<Question> questions = new ArrayList<Question>();
public Scanner input = new Scanner(System.in);


/**
 * Method: setup()
 *
 * This method is only invoked once when the game is started.
 * It does a couple of standard things, such as initializes window size, applies background color.
 * Then it initializes variables, such as player location, score, and etc.
 */
 void setup() {
  // Initilize the window size.
  // size() must be called before all other Processing method calls, such as noStroke(). 
  // Both parameters have to be constant: the first is width and the second is height.
  size(900, 900);
  
  // Disable the layer.
  noStroke();
  
  // Load all the questions [Make sure this arraylist can be called from anywhere in this program
  
  //ArrayList<Question> questions = new ArrayList<Question>();
  questions = loadQuestions();
  quizSize = questions.size();
  quizIndex = 0;
  healthPoints = 5;
  guess = 5;
  possiblePoints = 1000;
  scenario = 1; //1: display question, 2: tell the player their guess was correct, 3: tell the player their guess was incorrect
  
  
  // Background color to be black
  background(SKY); //this screen color gets overwritten in the draw() method

  start = false;  //Before player click to start the game, it is set to false
  score = 0;      //set score to 0

  //player = new Player(this);
  enemies = new Enemy[4];
  for (int i =0; i<4; i++) {
    enemies[i] = new Enemy(this); //an enemy is declared, we must ensure we get one of each type
  }

}


/*  
 * Method: draw
 
 * This method will be invoked in a loop, each iteration drawing a frame as in a movie.
 * The default frame rate (which can be changed) is 60 frames/sec.
 *
 * Any change to the game (variable changes) should happen here. 
 * Note that drawing in Processing uses the rule of stack:
 * - First shape/img will be at the bottom. 
 * - Shape/image drawn later will be on top.
 *
 * When the game hasn't started yet, display instruction.
 * When the game has started, display score and draw player.
 * Increase the score by 1.
 */
void draw() {
  if (!start) {
    quizIndex = 0;
    score = 0;
    healthPoints = 5;
    guess = 5;
    possiblePoints = 1000;
    scenario = 1;
    background(SKY);
    displayInst(); //display instruction if not started yet
  }
  if (start) {
    background(SKY);
    /*
    if(healthPoints == 0) {
        scenario = 4;  
        System.out.println("Game over!");
        fill(RASPBERRY);
        text("Game over... Final Score: " + score, 450, 450);
       // delay(5000);
        //start = false;
      }
      */
    if(scenario == 2) {
      delay(3000);
    }
    if(scenario == 3) {
      delay(1500);
    }
    if(scenario == 4) {
      start = false;
      delay(5000);
    }
    
    if(scenario != 1) {
      scenario = 1;
      guess = 5;
      delay(500);
    }
    if(scenario == 1) {
      try {
        displayScore();
        fill(RASPBERRY);
        text("Health points: " + healthPoints, 5, 50);
        
        int x = 150;
        int y = 300;
        correct = questions.get(quizIndex).getCorrect();
        
        fill(RASPBERRY);
        text(questions.get(quizIndex).getText(), 450, 100); //Aim for the top middle of the screen)
        for(int j = 1; (j - 1) < questions.get(quizIndex).getAnswers().size(); j++) {
          //**To-do**: Edit this block of codeto draw fruit and write text to line up with said fruit
          fill(RASPBERRY);
          text(j + ": " + questions.get(quizIndex).getAnswers().get(j-1), x, y);
          y+= 125;
        }
      
        guess = 5;
      } catch(IndexOutOfBoundsException ex) {//appears to be triggering, seeing as the player returns to the start screen 
        scenario = 4;
        System.out.println("The quiz is over");
        //fill(RASPBERRY);
        text("You win! Final Score: " + score, 450, 450); //is not displaying for some reason
        //delay(5000);
        //start = false;
      }
    }
    
    //the drawing methods will later be reworked
    //"enemies" should move much slower (if at all), only have 4 total (each a different type of fruit),
    //and have an answer mapped to it
    /*
    for (int i = 0; i<4; i++) {
      enemies[i].drawEnemy();
    }
    */
  }
}

/*  
 * Method: displayInst
 * 
 * Display a text at the upper left corner of the window, starting at coordinates (5, 25).
 */
public void displayInst() {
  //Consider adding fruit raining on this screen. I have tried this, but for some reason it breaks the game, put this task on the back-log
  textSize(20);
  fill(RED);
  text("Click to start game", 5, 25);
}

/*  
 * Method: displayScore
 * 
 * Display the score at the upper left corner of the window, starting at coordinates (5, 25).
 */
 
public void displayScore() {
  textSize(20);
  fill(RED);
  text("Score: " + score, 5, 25);
}





/**
 * Method: keyPressed
 *
 * Called when a key is pressed. 
 * 
 * If the key pressed is the ENTER key, start the game.
 */
public void keyPressed() {
  if (key == ENTER) {
    start = true;
    return;
  }
  
  if(start) {
  if(keyCode == UP) {
    guess = 1;
  }
  if(keyCode == DOWN) {
    guess = 2;
  }
  if(keyCode == LEFT) {
    guess = 3;
  }
  if(keyCode == RIGHT) {
    guess = 4;
  }
  
  //Up: 1, Down: 2, Left: 3, Right: 4
      guess --; //corrects for answers index for the sake of conventionality
      //changing this wouldn't result in major consequences
  
  if(guess == correct) {
        //Despawn fruit
        scenario = 2;
        System.out.println("A correct guess was made");
        fill(RASPBERRY);
        text("That's correct!", 450, 450); //Currently only displays at the end of the quiz, rather than the intended text from the catch block
        //delay(3000);
        score += possiblePoints;
        quizIndex++;
        possiblePoints = 1000;
        
      } else if((guess != 4) && (guess != correct)) { //recall that the default value for guess, 5, got reduced by one
        healthPoints--;
        
        if(healthPoints == 0) {
        scenario = 4;  
        System.out.println("Game over!");
        fill(RASPBERRY);
        text("Health points: " + healthPoints, 5, 50); //health points display is currently a little buggy
        fill(RASPBERRY);
        text("Game over... Final Score: " + score, 450, 450);
       // delay(5000);
        //start = false;
      } else {
          scenario = 3;
          System.out.println("An incorrect guess was made");
          fill(RASPBERRY);
          text("That's incorrect, try again!", 450, 450); //currently only displays if you run out of health points, rather than the intended game-over scenario
          //delay(1500);
          possiblePoints -= 250;
        }
      }
  }
}

/**
 * Method: mouseClicked
 *
 * Called when mouses is clicked to start the game.
 */
public void mouseClicked(){
  start = true;
}


/**
 * Method: loadQuestions
 *
 * Called upon startup
 * 
 * Puts all of the questions into an ArrayList
*/
public ArrayList<Question> loadQuestions() {
  ArrayList<Question> questions = new ArrayList<Question>();
  while(true) {
      try {
        Scanner inputFile = new Scanner(new File("C:\\Users\\jtspo\\Downloads\\CircleDodge\\FruitRain\\FruitRain\\Test2.csv")); //replace with actual file location
        String regex = "(\\s)*,(\\s)*";
        inputFile.useDelimiter(regex);
        int index = 0;
        while(inputFile.hasNext()) {
          String question = inputFile.next();
          String id = inputFile.next();
          int type = Integer.parseInt(inputFile.next());
          String a1 = inputFile.next();
          String a2 = inputFile.next();
          ArrayList<String> answers = new ArrayList<String>();
          answers.add(a1);
          answers.add(a2);
          if(type == 1) {
            String a3 = inputFile.next();
            String a4 = inputFile.next();
            answers.add(a3);
            answers.add(a4);
          }
          int correct = Integer.parseInt(inputFile.next());
          questions.add(new Question(question, id, type));
          questions.get(index).setAnswers(answers);
          questions.get(index).setCorrect(correct);
          index++;
        }
        inputFile.close();
        break;
      } catch(FileNotFoundException ex) {
        System.out.println("file not found, make sure the file is in the correct location");
        break;
      }
    }
    return questions;
}
