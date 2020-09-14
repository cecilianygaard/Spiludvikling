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
      rectMode(CORNER);
      fill(255);
      println((p2.x-p1.x));
      rect(p1.x, p1.y, (p2.x-p1.x), 5);
      //WE ALSO NEED TO DRAW HOW MANY POINT THIS LANDINGPLATFORM GIVES
    popMatrix();
  }
}

class Surface{
  ArrayList<PVector> points = new ArrayList<PVector>();  
  ArrayList<LandingPlatform> platforms = new ArrayList<LandingPlatform>();

  Surface(String fileName){
    //We need to read everything from the file, process all the points and add them to the points list
    //Then we need to process all the landingplatforms and add them to the platforms
     String[] lines = loadStrings(fileName);
     String pointsString = lines[0];
     String platformsString = lines[1];
     
     //We process the pointsString
     String[] pointStrings = pointsString.split(" ");
     for(int i = 0; i < pointStrings.length; i+=2){
       //We do two at a time
       //println(int(pointStrings[i]), int(pointStrings[i+1]));
       points.add(new PVector(int(pointStrings[i]), int(pointStrings[i+1])));
     }
     
     //We process the pointsString
     String[] platformStrings = platformsString.split(" ");
     for(int i = 0; i < platformStrings.length; i+=5){
       //We do two at a time
       //println(int(pointStrings[i]), int(pointStrings[i+1]));
       platforms.add(new LandingPlatform(int(platformStrings[i]), int(platformStrings[i+1]), int(platformStrings[i+2]), int(platformStrings[i+3]), int(platformStrings[i+4])));
     }
   }
     
  
  void draw(){
    pushMatrix();
      stroke(200);
      fill(0);
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
