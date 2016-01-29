import processing.video.*;

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
      float rx = random(width-80);
      float ry = random(height-60);
    }        
  
	int vtlSz = vidTimeLine.size();
	if(vtlSz > 30){
		image(vidTimeLine.get(vtlSz-1), 0,0);
		image(vidTimeLine.get(vtlSz-10), width/3,0);
		image(vidTimeLine.get(vtlSz-20), 2*(width/3),0);
		// why are all three images the exact same when they are pulling from different index locations in the array?
	}
  
}
 
 // With this sketch I'm trying to figure out how to save frames from the camera to a PImage Arraylist 
 // and then show three images from the ArrayList. The problem I'm having is that even though I'm using three different 
 // locations in the array, I keep getting three of the exact same images. Am I not referencing different locations in the ArrayList correctly?
 