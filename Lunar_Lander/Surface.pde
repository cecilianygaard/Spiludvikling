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
       points.add(new PVector(int(pointStrings[i]), int(pointStrings[i+1])));
     }
     
     //We process the pointsString
     String[] platformStrings = platformsString.split(" ");
     for(int i = 0; i < platformStrings.length; i+=5){
       //We do two at a time
       platforms.add(new LandingPlatform(int(platformStrings[i]), int(platformStrings[i+1]), int(platformStrings[i+2]), int(platformStrings[i+3]), int(platformStrings[i+4])));
     }
  }
  //Done
  Boolean pointUnderLine(PVector point, PVector p1, PVector p2){
    float a = (p2.y-p1.y)/(p2.x-p1.x);
    float yCollide = p1.y + a*(point.x-p1.x);
    return yCollide <= point.y;
  }
  //Done
  void updateDistanceToSpaceship(Spaceship s, PVector p1, PVector p2){
    float a = (p2.y-p1.y)/(p2.x-p1.x);
    float yCollide = p1.y + a*(s.location.x-p1.x);
    s.distToSurf = s.location.y - yCollide;
  }
  
  //In this we also update the distance from the spaceship to the 
  Boolean collisionWithSpaceship(Spaceship s){
    
    //These are the basic difference vectors.
    PVector TopLeft = new PVector(-s.w/2, -s.h/2);
    PVector TopRight = new PVector(s.w/2, -s.h/2);
    PVector BottomLeft = new PVector(-s.w/2, s.h/2);
    PVector BottomRight = new PVector(s.w/2, s.h/2);
    //We rotate them so that they are in line with the spaceship's rotation
    TopLeft.rotate(s.angle);
    TopRight.rotate(s.angle);
    BottomLeft.rotate(s.angle);
    BottomRight.rotate(s.angle);
    //We make them to actual coordinates by adding the location of the spaceship (the center of the spaceship)
    TopLeft.add(s.location);
    TopRight.add(s.location);
    BottomLeft.add(s.location);
    BottomRight.add(s.location);
    //Now they are proper coordinates
    PVector[] corners = {TopLeft, TopRight, BottomLeft, BottomRight};
    //We go through every point but the last one since we use the one in front as well.
    for(int i = 0; i < points.size()-1; i++){
      PVector p1 = points.get(i);
      PVector p2 = points.get(i+1);
      for(PVector point : corners){
        //If the point is within the boundaries of the 
        if(p1.x <= point.x && p2.x >= point.x){
          //If the point is under the line we have 
          return pointUnderLine(point, p1, p2);
          }
        }
      }
    return false;
  }
  
  //Done
  LandingPlatform spaceshipWithinLandingPlatform(Spaceship s){
    //We go through all of these and return that which it is between, though lookout!!! we return NULL!!!!! if it is not within any landingplatform.
    for(LandingPlatform platform : platforms){
      if(platform.p1.x <= s.location.x && platform.p2.x >= s.location.x){
        return platform;
      }
    }
    return null;
  }
  
  void collisionSpaceship(Spaceship s){}
  
  void draw(){
    pushMatrix();
      stroke(200);
      fill(0);
      beginShape();
        //Lefthand bottom most corner to avoid clipping
        vertex(-10, height);
        //Drawing a polygon through all the points
        for(PVector point : points){
          vertex(point.x, point.y);
        }
        //Lefthand bottom most corner to avoid clipping
        vertex(width+10, height);
      endShape();
      for(LandingPlatform platform : platforms){
        platform.draw();
      }
    popMatrix();
  }
}
