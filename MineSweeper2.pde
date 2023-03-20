import de.bezier.guido.*;
public static int NUM_ROWS;
public static int NUM_COLS;
public static int NUM_MINES;
public int minesFound = 0;
public float sValue;
public MSButton[][] buttons; //2d array of minesweeper buttons
public ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
winLoseDisplay button;
Slider diffSlider;
int boardSize;
startButton sButton;

void setup ()
{
  size(1000, 1000);
  Interactive.make( this ); 
  sButton  = new startButton(width/2-500/2, height/2-200/2, 500, 200);
  surface.setLocation(5, 0);
  textAlign(CENTER, CENTER);

  diffSlider = new Slider ( 10, 35, width-20, 20 );
  Interactive.on( diffSlider, "valueChanged", this, "radiusChanged" );
}
public void keyPressed() {
  if (key == 'r')
    loop();
  clear();
  setup();
  draw();
}
void draw ()
{
  boardSize = (int)sValue/12+3;

  background( 0 );

  if (sButton.getClicked() == true && sButton.terminate == false ) {    
    fill(0);
    rect(0, 0, 1010, 1010);
    NUM_ROWS = boardSize;
    NUM_COLS = boardSize;
    NUM_MINES = (int)((boardSize*boardSize)*.10)+1;
    sButton.setClicked();
    buttonInit(NUM_COLS, NUM_ROWS);
    setMines();
    diffSlider.invis();
  } else {   
    fill(255);
    textSize(50);
    text("Difficulty", width/2, 150);
    text("board size = "+boardSize, width/2, 250);
    text("mine count = "+(int)(((boardSize*boardSize)*.10)+1), width/2, 300);
  }
  if (minesFound >= NUM_MINES && NUM_ROWS > 0) {
    displayWinningMessage();
  }
}

void radiusChanged ( float v ) { 
  sValue = map( v, 0, 1, 1, width/2-20 );
} 


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
        System.out.println(minesFound+" of "+NUM_MINES);
      }

      if (mines.contains(this) && flagged == true) {
        minesFound--;
        System.out.println(minesFound+" of "+NUM_MINES);
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

public class Slider
{
  float x, y, width, height;
  float valueX = 0, value;
  boolean on;

  Slider ( float xx, float yy, float ww, float hh ) 
  {
    x = xx; 
    y = yy; 
    width = ww; 
    height = hh;

    valueX = x;

    Interactive.add( this );
  }

  void mouseEntered ( float mx, float my )
  {
    on = true;
  }

  void mouseExited ( float mx, float my )
  {
    on = false;
  }

  void mouseDragged ( float mx, float my, float dx, float dy )
  {
    valueX = mx - height/2;

    if ( valueX < x ) valueX = x;
    if ( valueX > x+width-height ) valueX = x+width-height;

    value = map( valueX, x, x+width-height, 0, 1 );

    Interactive.send( this, "valueChanged", value );
  }

  public void draw ()
  {
    noStroke();

    fill( 100 );
    rect( x, y, width, height );

    fill( on ? 200 : 120 );
    rect( valueX, y, height, height );
  }
  public void invis()
  {

    x = 10000;
    y = 10000;
  }
}

public class MultiSlider
{
  float x, y, width, height;
  float pressedX, pressedY;
  float pressedXLeft, pressedYLeft, pressedXRight, pressedYRight;
  boolean on = false;

  SliderHandle left, right, activeHandle;

  float values[];

  MultiSlider ( float xx, float yy, float ww, float hh )
  {
    this.x = xx; 
    this.y = yy; 
    this.width = ww; 
    this.height = hh;

    left  = new SliderHandle( x, y, height, height );
    right = new SliderHandle( x+width-height, y, height, height );

    values = new float[]{0, 1};

    Interactive.add( this );
  }

  void mouseEntered ( float mx, float my )
  {
    on = true;
  }

  void mouseExited ( float mx, float my )
  {
    on = false;
  }

  void mousePressed ( float mx, float my )
  {
    if ( left.isInside( mx, my ) )       activeHandle = left;
    else if ( right.isInside( mx, my ) ) activeHandle = right;
    else                                 activeHandle = null;

    pressedX = mx;
    pressedXLeft  = left.x;
    pressedXRight = right.x;
  }

  void mouseDragged ( float mx, float my, float dx, float dy )
  {
    float vx = mx - left.width/2;
    vx = constrain( vx, x, x+width-left.width );

    if ( activeHandle == left )
    {
      if ( vx > right.x-left.width ) vx = right.x-left.width;
      values[0] = map( vx, x, x+width-left.width, 0, 1 );

      Interactive.send( this, "leftValueChanged", values[0] );
    } else if ( activeHandle == right )
    {
      if ( vx < left.x+left.width ) vx = left.x+left.width;
      values[1] = map( vx, x, x+width-left.width, 0, 1 );

      Interactive.send( this, "rightValueChanged", values[1] );
    } else // dragging in between handles
    {
      float dx2 = mx-pressedX;

      if ( pressedXLeft + dx2 >= x && pressedXRight + dx2 <= x+(width-right.width) )
      {
        values[0] = map( pressedXLeft + dx2, x, x+width-left.width, 0, 1 );
        left.x = pressedXLeft + dx2;

        values[1] = map( pressedXRight + dx2, x, x+width-left.width, 0, 1 );
        right.x = pressedXRight + dx2;

        Interactive.send( this, "leftValueChanged", values[0] );
        Interactive.send( this, "rightValueChanged", values[1] );
      }
    }

    if ( activeHandle != null ) activeHandle.x = vx;
  }

  void draw ()
  {
    noStroke();
    fill( 120 );
    rect( x, y, width, height );
    fill( on ? 200 : 150 );
    rect( left.x, left.y, right.x-left.x+right.width, right.height );
  }

  public boolean isInside ( float mx, float my )
  {
    return left.isInside(mx, my) || right.isInside(mx, my) || Interactive.insideRect( left.x, left.y, (right.x+right.width)-left.x, height, mx, my );
  }
  public void invis()
  {

    x = 10000;
    y = 10000;
  }
}

class SliderHandle
{
  float x, y, width, height;

  SliderHandle ( float xx, float yy, float ww, float hh )
  {
    this.x = xx; 
    this.y = yy; 
    this.width = ww; 
    this.height = hh;
  }

  void draw ()
  {
    rect( x, y, width, height );
  }

  public boolean isInside ( float mx, float my )
  {
    return Interactive.insideRect( x, y, width, height, mx, my );
  }
  public void invis()
  {

    x = 10000;
    y = 10000;
  }
}
