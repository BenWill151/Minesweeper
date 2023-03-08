public void displayLosingMessage()
{
  for (int c = 0; c < mines.size(); c++) {
    mines.get(c).clicked = true;
  }
  int hh = 500;
  int ww = 200;
  String str = "YOU ARE LOSE";
  new winLoseDisplay( width/2-hh/2, height/2-ww/2, hh, ww, str);   
  noLoop();
}
public void displayWinningMessage()
{
  int hh = 500;
  int ww = 200;
  String str = "YOU ARE WIN";
  new winLoseDisplay( width/2-hh/2, height/2-ww/2, hh, ww, str);   
  noLoop();
}



public void setMines()
{
  while (mines.size() < NUM_MINES) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[r][c])) {
      mines.add(buttons[r][c]);
    }
  }
}


public boolean isValid(int r, int c)
{
  return (r>=0 && r<NUM_ROWS) && (c>=0 && c<NUM_COLS);
}
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int r = row-1; r<=row+1; r++) {
    for (int c = col-1; c<=col+1; c++) {
      if (isValid(r, c) && mines.contains(buttons[r][c])) {
        numMines++;
      }
    }
  }
  return numMines;
}


public void buttonInit(int NUM_ROWS, int NUM_COLS) {
  buttons = new MSButton[NUM_ROWS][NUM_COLS];

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
}
public class startButton
{
  public float x, y, width1, height1, width, height;
  public boolean clicked, terminate;
  public startButton ( float xx, float yy, float w, float h)
  {
    x = xx; 
    y = yy; 
    width = (int)w; 
    height = (int)h;
    width1 = w; 
    height1 = h;
    clicked = false;
    terminate = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager

  public void mousePressed () 
  {
    if (mouseButton == LEFT && clicked == false && terminate == false) {
      clicked = true;
      invis();
    } else {
      clicked = false;
    }
  }

  public void draw () 
  {
    strokeWeight(5);
    if (clicked == true && terminate == false) {
      fill(200);    
      stroke(50);

      rect(x, y, width1, height1, 10);
      stroke(0);          
      textSize(141);
      fill(0);
      text("Start", 1000/2, 1000/2-10);
    } else {
      fill(255);   
      stroke(100);
      rect(x, y, width1, height1, 10);
      stroke(0);          
      textSize(141);
      fill(0);
      text("Start", 1000/2, 1000/2-10);
    }
  }
  public boolean getClicked() {
    if (clicked == true) {
      return true;
    }
    return false;
  }
  public boolean setClicked() {
    clicked = false;
    terminate = true;
    return false;
  }
  public void invis()
  {

    x = 10000;
    y = 10000;
  }
}

public class winLoseDisplay
{
  float x, y, width1, height1;
  boolean on;
  String str;

  winLoseDisplay ( float xx, float yy, float w, float h, String s)
  {
    x = xx; 
    y = yy; 
    width1 = w; 
    height1 = h;
    str = s;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager

  void mousePressed () 
  {
    on = !on;
  }

  void draw () 
  {
    fill(255);
    rect(1050, 1050, .01, .01);
    fill(255);
    stroke(255);
    strokeWeight(5);
    textSize(141);
    text(str, width/2, height/2);
  }
}
public void drawMine(int centerX, int centerY) {
  int radius = 5;
  fill(0);
  stroke(0);

  // Begin drawing the mine shape

  // Draw a circle for the mine
  ellipse(centerX, centerY, radius*2, radius*2);


  // vert
  int detonatorX = centerX ;
  int detonatorY = centerY;
  int detonatorWidth = radius/4;
  int detonatorHeight = radius*3;
  rect(detonatorX, detonatorY, detonatorWidth, detonatorHeight);
  //hori
  int detonatorX1 = centerX ;
  int detonatorY1 = centerY;
  int detonatorWidth1 = radius*3;
  int detonatorHeight1 = radius/4;
  rect(detonatorX1, detonatorY1, detonatorWidth1, detonatorHeight1);
  //beginShape();
  //translate(centerX, centerY-141);
  //rotate(PI/4.0);
  //// Draw a circle for the mine
  //for (float i = 0; i < TWO_PI; i += PI/3200) {
  //  float x = centerX + cos(i) * radius;
  //  float y = centerY + sin(i) * radius;
  //  vertex(x, y);
  //}
  //endShape(CLOSE);

  //// vert
  //int detonatorX3 = centerX ;
  //int detonatorY3 = centerY;
  //int detonatorWidth3 = radius/4;
  //int detonatorHeight3 = radius*3;
  //rect(detonatorX3, detonatorY3, detonatorWidth3, detonatorHeight3);
  ////hori
  //int detonatorX13 = centerX ;
  //int detonatorY13 = centerY;
  //int detonatorWidth13 = radius*3;
  //int detonatorHeight13 = radius/4;
  fill(255, 0, 0);
  //rect(detonatorX13, detonatorY13, detonatorWidth13, detonatorHeight13);
}
