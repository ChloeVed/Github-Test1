import java.util.ArrayList;

public class Question {
  
  private String text;
  private String id;
  private int type; //indicates whether the question has 4 answers (type 1), or 2 answers (type 2)
  private ArrayList<String> answers;
  private int correct;
  
  public Question(String text, String id, int type) {
    this.text = text;
    this.id = id;
    this.type = type;
    answers = new ArrayList<String>();
  }
  
  public String getText() {
    return this.text;
  }
  
  public void setAnswers(ArrayList<String> answers) {
    for(int i = 0; i < answers.size(); i++) {
      this.answers.add(answers.get(i));
    }
  }
  
  public void setCorrect(int index) {
    if(index > this.answers.size()) {
      //throw custom exception
    }
    else {
      correct = index;
    }
    
  }
  
  public ArrayList<String> getAnswers() {
    return this.answers;
  }
  
  public int getType() {
    return this.type;
  }
  
  public int getCorrect() {
    return this.correct;
  }
  
}
