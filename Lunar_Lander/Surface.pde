//The Linesegment idea was rather data-inefficient so instead we are just going to make the surface have a list of points and landingplatforms

//Composition over inheritance!!!!
class LandingPlatform{
}

class Surface{
  ArrayList<PVector> points = new ArrayList<PVector>();  
  
  Surface(){
    //For a start lets just generate the points randomly
    //Later we should probably just read it from a file, that would be the best idea.
    int numOfPoints = 50;
    for(int i = 0; i < numOfPoints; i++){
      points.add(new PVector(width/numOfPoints*i, random(height-100, height-10)));
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
    popMatrix();
  }
}
