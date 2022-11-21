float ballSize=60; //size of the ball
float playerSize=30; //size of the player
float projectileSize=15; //size of the projectiles
float ballX,ballY; //x and y coordinates for the ball
float ballSpeed=3; //speed of the ball
float directionX=1; //horizontal movement of the ball
float directionY=1; //vertical movement of the ball

PVector[] mouse = new PVector[10]; //array with length of 10 to store coordinates where mouse is clicked
PVector[] velocity = new PVector[10]; //array with length of 10 for the speed of the projectiles
PVector[] location = new PVector[10]; //array with length of 10 for the location of the projectiles
boolean[] shoot = new boolean[10];  //array with length of 10 for if projectiles are being shot

void setup() {
  size(700,400); //size of the run window
  ballX=width/2; //initial x-coordinate for the ball
  ballY=height/2; //initial y-coordinate for the ball
  createProjectiles(); //sets up projectiles
}

void draw() {
  background(#8E8E8E); //gray background
  player(); //draws the player
  ball(); //draws the ball
  projectiles(); //draws the projectiles
  collisionDetection(); //enables collision detection
}

void player() {
  circle(width/2,height/2,playerSize); //draws player circle in the middle of the run window
}

void createProjectiles() {
  for(int index=0;index<location.length;index++) { //index variable has an initial value of 0,  must be less than the length of location array, and increases by increments of 1
    velocity[index]=new PVector(); //intial velocity of the projectiles is 0
    location[index]=new PVector(width/2,height/2); //initial locatiion of the projectiles is in the middle of the run window
    shoot[index]=false; //projectile is not shot
  }
}

void projectiles() {
  for(int index=0;index<location.length;index++) { //index variable has an initial value of 0,  must be less than the length of location array, and increases by increments of 1
    if(shoot[index]) { //if projectile is shot
      location[index].add(velocity[index]); //the location of the projectile is location plus velocity
      circle(location[index].x,location[index].y,projectileSize);  //creates a projectiles that moves from the middle of the screen to where the mouse was clicked
    }
  if(location[index].x>width || location[index].x<0 || location[index].y>height || location[index].y<0) { //if projectile exceeds the boundaries of the run window
    location[index]=new PVector(width/2,height/2); //resets the location of the projectile to the middle of the run window
    velocity[index]=new PVector(); //resets the velocity of the projectile to 0
    shoot[index]=false; //projectile is not shot
    }
  }
}

void mousePressed() {
  for(int index=0;index<location.length;index++) { //index variable has an initial value of 0,  must be less than the length of location array, and increases by increments of 1
    if(shoot[index]==false) { //if projectile is not shot
      shoot[index]=true; //projectile is shot
      mouse[index]=new PVector(mouseX,mouseY); //stores the coordinates where the mouse was clicked
      velocity[index]=PVector.sub(mouse[index],location[index]); //velocity of the projectiles is equal to velocity minus the coordinates of where the mouse was clicked and the location of the projectiles
      velocity[index].normalize(); //sets velocity PVector to have a magnitude of 1
      velocity[index].mult(7); //sets velocity PVector to have a magnitude of 7
      break; //exits the for loop which runs through the arrays
    }
  }
}

void ball() {
  ballX=ballX+(ballSpeed*directionX); //updates the x-coordinate of the ball
  ballY= ballY+(ballSpeed*directionY); //updates the y-coordinate of the ball
  if(ballX>width-ballSize/2 || ballX<ballSize/2) { //if the ball exceeds the left or right boundaries of the run window
    directionX*=-1; //change horizontal direction
  }
  if(ballY>height-ballSize/2 || ballY<ballSize/2) { //if the ball exceeds the top or bottom of the run window
    directionY*=-1; //change vertical direction
  }
  noStroke(); //disables the borders of shapes
  circle(ballX,ballY,ballSize); //draws the ball
}

void collisionDetection() {
  for(int index=0;index<location.length;index++) { //index variable has an initial value of 0,  must be less than the length of location array, and increases by increments of 1
    if(dist(location[index].x,location[index].y,ballX,ballY)<projectileSize/2+ballSize/2) { //if a projectile collides with the ball
      ballX=random(ballSize,width-ballSize); //randomizes the x-coordinate of the ball
      ballY=random(ballSize,height-ballSize); //randomizes the y-coordinate of the ball
      location[index]=new PVector(width/2,height/2); //resets the location of the projectile to the middle of the screen
      velocity[index]=new PVector(); //resets the velocity of the projectile to 0
      shoot[index]=false; //projectile is not shot
    }
  }
}
