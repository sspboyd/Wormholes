import processing.video.*;
import processing.pdf.*;

//Declare Globals
int rSn; // randomSeed number. put into var so can be saved in file name. defaults to 47
final float PHI = 0.618033989;

boolean PDFOUT = false;

Capture cam;
ArrayList<PImage> vidTimeLine = new ArrayList<PImage>();
int maxArrayListSz;

/*////////////////////////////////////////
 SETUP
 ////////////////////////////////////////*/
void setup() {
  size(640, 480);
  frameRate(15);

  rSn = 47; // 29, 18;
  randomSeed(rSn);
  println("setup done: " + nf(millis() / 1000.0, 1, 2));


  maxArrayListSz = 15 * 20; // 15 fps, and 20 seconds of history

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  } else {
    cam = new Capture(this, cameras[4]); // 320x240@15fps
    cam.start();
  }
}

void draw() {
  background(255);
  int vtlSz = vidTimeLine.size();
  if (cam.available() == true) {
    cam.read();
    PImage f = cam.get();
    vidTimeLine.add(f);
    if (vtlSz > maxArrayListSz) vidTimeLine.remove(0); // prevents Arraylist from getting too big and causing memory problems
  }        

  if (vtlSz > 299) { // 500 = approx 33 seconds at 15fps 
    image(vidTimeLine.get(vtlSz-1), 0, 0);              // most recent frame
    image(vidTimeLine.get(vtlSz-7), width/3, 0);      // about 16 seconds into the past
    image(vidTimeLine.get(vtlSz-30), 2*(width/3), 0);  // about 30 seconds into the past
  }
  if (PDFOUT) exit();
}


void keyPressed() {
  // if (key == 'S') screenCap(".tif");
}

void mousePressed() {
}