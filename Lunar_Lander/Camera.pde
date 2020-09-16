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
    if (s.location.y<height/7) {
      translate(0, -s.location.y+height/7);
    }
    if (s.location.x<width/7) {
      translate(-s.location.x+width/7, 0);
    } else if (s.location.x>width-width/7) {
      translate(-s.location.x+width-width/7, 0);
    }
  }
}
