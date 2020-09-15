class Camera {
  float relativeWidth;
  float transX;
  float transY;
  float zoom;
  
  Camera(){
    relativeWidth = 400;
    transX = 0;
    transY = 0;
    zoom = width/relativeWidth;
  }

  void update(Spaceship s) {
    transX = s.location.x-relativeWidth/2;
    transY = s.location.y-relativeWidth/2;
  }
}
