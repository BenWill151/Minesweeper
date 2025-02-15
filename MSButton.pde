import de.bezier.guido.*;
public class MSButton
{
  private int myRow, myCol;
  public float x, y, width, height, width1, height1;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int R, int C )
  {
    width = 1000/NUM_COLS;
    height = 1000/NUM_ROWS;
    width1 = 1000/NUM_COLS;
    height1 = 1000/NUM_ROWS;

    myRow =R;
    myCol = C; 
    x = myCol*width1;
    y = myRow*height1;
    myLabel = "";
    flagged = clicked = false;

    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    if (mouseButton == LEFT && flagged == false) {
      clicked = true;
    }

    if (mouseButton == RIGHT && clicked == false) {
      if (mines.contains(this) && flagged == false) {
        minesFound++;
        //System.out.println(minesFound+" of "+NUM_MINES);
      }

      if (mines.contains(this) && flagged == true) {
        minesFound--;
        //System.out.println(minesFound+" of "+NUM_MINES);
      }
      flagged = !flagged;
    } else if (mouseButton == LEFT && mines.contains(this) && flagged == false) {     
      displayLosingMessage();
    } else if (mouseButton == LEFT && countMines(myRow, myCol) > 0 && flagged == false) {
      myLabel = countMines(myRow, myCol)+"";
    } else {
      if (isValid(myRow - 1, myCol) == true && buttons[myRow - 1][myCol].clicked == false)
      {
        buttons[myRow - 1][myCol].mousePressed();
      }
      if (isValid(myRow + 1, myCol) == true && buttons[myRow + 1][myCol].clicked == false)
      {
        buttons[myRow + 1][myCol].mousePressed();
      }
      if (isValid(myRow, myCol - 1) == true && buttons[myRow ][myCol-1].clicked == false)
      {
        buttons[myRow][myCol - 1].mousePressed();
      }
      if (isValid(myRow, myCol + 1) == true && buttons[myRow ][myCol+1].clicked == false)
      {
        buttons[myRow][myCol + 1].mousePressed();
      }
      if (isValid(myRow + 1, myCol - 1) == true && buttons[myRow + 1][myCol-1].clicked == false)
      {
        buttons[myRow + 1][myCol - 1].mousePressed();
      }
      if (isValid(myRow - 1, myCol + 1) == true && buttons[myRow - 1][myCol+1].clicked == false )
      {
        buttons[myRow - 1][myCol + 1].mousePressed();
      }
      if (isValid(myRow + 1, myCol + 1) == true && buttons[myRow + 1][myCol+1].clicked == false)
      {
        buttons[myRow + 1][myCol + 1].mousePressed();
      }
      if (isValid(myRow - 1, myCol - 1) == true && buttons[myRow - 1][myCol-1].clicked == false )
      {
        buttons[myRow - 1][myCol - 1].mousePressed();
      }
    }
  }
  public void draw () 
  {   
    stroke(0);
    strokeWeight(width1/30);
    if (flagged) {
      fill(210, 210, 0);
      rect(x, y, width1, height1, 10);
      fill(255, 0, 0);
      noStroke();
      triangle(x+10, y+3, x+10, y+11, x+19, y+7);
      stroke(120);
      strokeWeight(1.5);
      line(x+10, y+3, x+10, y+20);
    } else if ( clicked && mines.contains(this) ) {   
      fill(255, 0, 0);
      rect(x, y, width1, height1, 10);
    } else if (clicked) {
      fill( 200 );
      rect(x, y, width1, height1, 10);
    } else {
      fill( 100 );
      rect(x, y, width1, height1, 10);
    }


    fill(0);
    textSize((int)width1);
    text(myLabel, x+width1/2, y+height1/2-5);
  }
  public void setLabel(String newLabel) {
    myLabel = newLabel;
  }

  public void setLabel(int newLabel) {
    myLabel = ""+ newLabel;
  }

  public String getLabelSTR() { 
    return myLabel;
  }

  public boolean isClicked() {
    return clicked;
  }

  public int getLabelINT() {
    return Integer.parseInt(myLabel);
  }

  public boolean isFlagged() {
    return flagged;
  }
}
