import processing.video.*;

// I'm trying to save frames from my MacBook's web camera to an Arraylist<PImage> 
// and then show three images from the ArrayList. The original problem which is 
// now fixed was that even though was pulling PImages from three different locations 
// in the array I kept getting three of the exact same most recent images. 

Capture cam;
ArrayList<PImage> vidTimeLine = new ArrayList<PImage>();

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  } else {
    cam = new Capture(this, cameras[1]); // 640x480@15fps
    cam.start();
  }
}

void draw() {
  frameRate(15);// added
  if (cam.available() == true) {
    cam.read();
    PImage f = cam.get();
    vidTimeLine.add(f);
  }        

  int vtlSz = vidTimeLine.size();
  if (vtlSz > 500) { // 500 = approx 33 seconds at 15fps 
    image(vidTimeLine.get(vtlSz-1), 0, 0);              // most recent frame
    image(vidTimeLine.get(vtlSz-250), width/3, 0);      // about 16 seconds into the past
    image(vidTimeLine.get(vtlSz-499), 2*(width/3), 0);  // about 30 seconds into the past
    // Why are all three images the exact same when they are pulling from different index 
    // locations in the array?
    // ANSWER!! Because I was only passing a reference to the cam into the ArrayList, not 
    // the actual image.
  }
}