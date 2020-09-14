class LandingPlatform{
  PVector p1, p2;
  Boolean done = false;
  int YCOOR = 0;
  int point = 0;//We will need to change these manually in the text file.
  LandingPlatform(){
    p1 = new PVector();
    p2 = new PVector();
  }
  void addPoint(int x, int y){
    if(p1.mag() == 0){
      p1 = new PVector(x, y);
      YCOOR = y;
    }else{
      p2 = new PVector(x, YCOOR);
      done = true;
    }
  }
}

class Surface{
  ArrayList<PVector> points = new ArrayList<PVector>();  
  ArrayList<LandingPlatform> landingPlatforms = new ArrayList<LandingPlatform>();  
  
  Surface(){
  }
  
  void addPoint(int x, int y){
    points.add(new PVector(x, y));
  }
  String pointsToText(){
    String s = "";
    for(PVector point : points){
      s += "("+Integer.toString(int(point.x))+","+Integer.toString(int(point.x))+"),";
    }
    return s;
  }
  String landingPlatformsToText(){
    String s = "";
    for(LandingPlatform platform : landingPlatforms){
      s += "("+Integer.toString(int(platform.p1.x))+","+Integer.toString(int(platform.p1.x))+","+Integer.toString(int(platform.p2.x))+","+Integer.toString(int(platform.p2.x))+",POINT),";
    }
    return s;
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
      fill(255, 0, 0);
      for(PVector point : points){
          circle(point.x, point.y, 5);
      }
    popMatrix();
  }
}
