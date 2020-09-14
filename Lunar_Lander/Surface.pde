//The Linesegment idea was rather data-inefficient so instead we are just going to make the surface have a list of points and landingplatforms

//Composition over inheritance!!!!
class LandingPlatform{
  PVector p1, p2;
  int point;
  
  LandingPlatform(int x1, int y1, int x2, int y2, int point_){
    p1 = new PVector(x1, y1);
    p2 = new PVector(x2, y2);
    point = point_;
  }
  
  void draw(){
    pushMatrix();
      fill(255);
      rect(p1.x, p1.y, (p2.x-p1.x), 5);
      //WE ALSO NEED TO DRAW HOW MANY POINT THIS LANDINGPLATFORM GIVES
    popMatrix();
  }
}

class Surface{
  ArrayList<PVector> points = new ArrayList<PVector>();  
  ArrayList<LandingPlatform> platforms = new ArrayList<LandingPlatform>();
  Surface(){
    //For a start lets just generate the points randomly
    //Later we should probably just read it from a file, that would be the best idea.
    int numOfPoints = 50;
    for(int i = 0; i < numOfPoints; i++){
      points.add(new PVector(width/numOfPoints*i, random(height-100, height-10)));
    }
  }
  Surface(String fileName){
    //We need to read everything from the file, process all the points and add them to the points list
    //Then we need to process all the landingplatforms and add them to the platforms
     String[] lines = loadStrings(fileName);
     String pointsString = lines[0];
     String platformsString = lines[1];
     //We process the pointsString
     Boolean parenthesesClosed = false;
     int x = 0;
     int y = 0;
     for(int i = 0; i < pointsString.length(); i++){
       if(parenthesesClosed){
         x = 0;
         y = 0;
         i += 2;
         
       }
     }
     for(String s : parenthesesClosed.split("((.*?,.*?))")){
       if
     }
     
  }
  
  void draw(){
    pushMatrix();
      stroke(200);
      noFill();
      beginShape();
        //Lefthand bottom most corner to avoid clipping
        vertex(0, height);
        //Drawing a polygon through all the points
        for(PVector point : points){
          vertex(point.x, point.y);
        }
        //Lefthand bottom most corner to avoid clipping
        vertex(width, height);
      endShape();
      for(LandingPlatform platform : platforms){
        platform.draw();
      }
    popMatrix();
  }
}
