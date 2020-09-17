PrintWriter surfaceText;
String mode = "point"; //other possible mode is landing platform which would be "landing"
Surface surf;
LandingPlatform platform;
PImage background;
int imgW = 2016;
int imgH = 1522;
void setup(){
  //Yeah 
  //W  = 700*(imgW/imgH) = 700*(2016/1522) = 927
  //H  = 700*(imgH/imgW) = 700*(1522/2016) = 529
  
  size(927, 529);
  surfaceText = createWriter("surface.txt");
  surf = new Surface();
  background = loadImage("background.png");
}

void update(){
  
}

void draw(){
  update();
  background(0);
  image(background, 0,0,width, height);
  fill(255, 0, 0);
  circle(mouseX, mouseY, 2);
  noFill();
  surf.draw();
  if(platform != null){
    platform.draw();
  }
  drawInfo();
}

void drawInfo(){
  textSize(12);
  textAlign(LEFT, TOP);
  text("COMMANDS> `S´ : (to save), `P´ : (to point mode), `L´ : (to landing mode), `O´ : (to save landing) ", 10, 10);
  text("COMMANDS> ESC : (to save file & close), BACKSPACE : (to delete a point )", 10, 50);
  text("CURRENT MODE: " + mode, 10, 90);  
}

void keyPressed(){
  //We safe to the file
  if(key == 's'){
    surfaceText.println(surf.pointsToText());
    surfaceText.println(surf.landingPlatformsToText());
    surfaceText.flush();
  }else if(key == 'p'){
    mode = "point";
  }else if(key == 'l'){
    mode = "landing";
    platform = new LandingPlatform();
  }else if(key == 'o'){
    if(platform!=null){
      surf.landingPlatforms.add(platform);
      println("PLATFORM SAVED");
      platform = new LandingPlatform();
    }
  }
  
  //We save to the file and close the file
  else if(key == ESC){
      surfaceText.flush();
      surfaceText.close();
  }else if(key == BACKSPACE){
    //We delete the last point
    if (mode == "point"){
      println("DELTED POINT");
      surf.points.remove(surf.points.get(surf.points.size()-1));
    }else if (mode == "landing"){
      println("DELTED LANDING");
      surf.points.remove(surf.points.get(surf.points.size()-1));
      //If the platform is done we know it is p2 that needs to be deleted
      if(platform.done){
        platform.p2.mult(0);
        platform.done = false;
      }else{
        platform.p1.mult(0);
        platform.YCOOR = 0;
      }
    }
  }
}

//When the mouse is pressed we add a point to the surface. Depending on the mode we could also add a landingPlatform
void mousePressed(){
  if(mode == "point"){
    surf.addPoint(mouseX, mouseY);
  }else if(mode == "landing"){
    if (platform.done){
      println("PLATFORM DONE");
    }else{
      if (platform.YCOOR == 0){
        surf.addPoint(mouseX, mouseY);
        platform.addPoint(mouseX, mouseY);
      }else{
        surf.addPoint(mouseX, platform.YCOOR);
        platform.addPoint(mouseX, mouseY);      
      }
    }
  }
}
