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
  size(320, 240);
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

  if (vtlSz > 199) { // 500 = approx 33 seconds at 15fps 
    for (int i = 0; i < 10; i++) {
      showSlice(i);
    }
  }
  if (PDFOUT) exit();
}

void showSlice(int _i){
  float portalDia = map(_i, 0, 10, 0, 220);
  PGraphics msk = createGraphics(width, height);
  msk.beginDraw();
  msk.background(255);
  msk.fill(0);
  msk.noStroke();
  msk.ellipse(mouseX, mouseY, portalDia, portalDia);
  msk.endDraw();
  PImage f = vidTimeLine.get(_i*3);
  PImage fm = f.get();
  fm.mask(msk);
  image(fm, 0, 0);

}

void keyPressed() {
  // if (key == 'S') screenCap(".tif");
}

void mousePressed() {
}