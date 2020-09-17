class Camera {
  float relativeWidth;
  float transX;
  float transY;
  float zoom;
  float boundaryLeftX;
  float boundaryRightX;
  float boundaryY;


  Camera() {
    relativeWidth = 400;
    transX = 0;
    transY = 0;
    zoom = width/relativeWidth;
    boundaryLeftX = width/7;
    boundaryRightX = width-width/7;
    boundaryY = height/7;
  }

  void update(Spaceship s) {
    transX = s.location.x-relativeWidth/2;
    transY = s.location.y-relativeWidth/2;
  }

  void followSpaceship(Spaceship s) {
    //Move camera up
    if (s.location.y<boundaryY) {
      translate(0, -s.location.y+boundaryY);
    }
    //Move camera to the left
    if (s.location.x<boundaryLeftX) {
      translate(-s.location.x+boundaryLeftX, 0);
      //Move camera to the rigth
    } else if (s.location.x>boundaryRightX) {
      translate(-s.location.x+boundaryRightX, 0);
    }
  }
}
