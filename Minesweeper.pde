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
  //surface.setLocation(5, 0);
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
