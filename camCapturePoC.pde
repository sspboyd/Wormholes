import processing.video.*;

 // I'm trying to save frames from my MacBook's web camera to an Arraylist<PImage> 
 // and then show three images from the ArrayList. The problem I'm having is that 
 // even though I'm pulling PImages from three different locations in the array 
 // I keep getting three of the exact same most recent images. Am I not referencing 
 // different locations in the ArrayList correctly?
 // Am I not referencing different locations in the ArrayList correctly?
 
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
  if (cam.available() == true) {
    cam.read();
    PImage f = cam;
    vidTimeLine.add(f);
  }        
  
	int vtlSz = vidTimeLine.size();
	if(vtlSz > 150){ // 150 = 10 seconds at 15fps 
		image(vidTimeLine.get(vtlSz-1), 0,0);             // most recent frame
		image(vidTimeLine.get(vtlSz-75), width/3,0);      // about 5 seconds into the past
		image(vidTimeLine.get(vtlSz-135), 2*(width/3),0); // about 9 seconds into the past
		// Why are all three images the exact same when they are pulling from different index locations in the array?
	}
}