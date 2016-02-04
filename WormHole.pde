class WormHole{
	  int durrStart, durr;
	  PVector loc;
	  // float zDepth;
	  ArrayList<TimeSlice> timeSlices;

	WormHole(){
		// durrStart = millis();
		loc = new PVector();
	}

	void update(){
		loc.x = mouseX;
		loc.y = mouseY;
		// create 6 TimeSlice objects
		TimeSlice nt;
		for (int i = 0; i < 5; i++) {
			nt = new TimeSlice();
			nt.tsRad = i/5*(width/2);
			nt.tsRTOffset = 2.5 - (2.5*(i/5)); // 2.5 secs is the max timeDepth here with .5 secs between each timeSlice
			nt.tsFrame = vidTimeLine.get(int(nt.tsRTOffset * 15)); // 15 is the fps
			nt.tsLoc = loc;
			timeSlices.add(nt);
		}
	}

	void render(){
		for (int i = 0; i < 5; i++) {
			TimeSlice t = timeSlices.get(i);
			t.render();
		}
	}

}