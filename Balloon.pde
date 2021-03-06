class Balloon{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float topspeed = 2;
  float size;
  int opacity;
  color balloonColor;
  
  Balloon(float tempM, float tempX, float tempY, color tempFillColor) {
    location = new PVector(tempX,tempY);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = tempM;
    size = tempM/6;
    balloonColor = tempFillColor;
    opacity = 80;
  }
  
  void applyForces(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
     
  }
  
  void display() {
    
    
    if (opacity > 80){
      opacity -= 2;
    }
    
    fill(balloonColor, opacity);
    
    stroke(255,20);
    ellipse(location.x, location.y, size, size);
    
  }
  
  void checkEdges() {

    if (location.y < (size/2)) {
      location.y = (size/2); 
      velocity.y *= -.8;
      opacity = 180;
    } else if (location.y > height - (size/2)) {
      location.y = height - (size/2); 
      velocity.y *= -.8;
      opacity = 180;
    }
    
    if (location.x < (size/2)) {
      location.x = (size/2); 
      velocity.x *= -.8;
      opacity = 180;
    } else if (location.x > width- (size/2)) {
      location.x = width - (size/2); 
      velocity.x *= -.8;
      opacity = 180;
    }
  }
  
  
  void mouseAction() {
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(location);
    float distance = mouse.mag();
    distance = constrain(distance, 25, 500);
    //change the number here for the gravitational constant
    float grav = (mouseVector * mass) / ( distance * distance);
    mouse.normalize();
    mouse.mult(grav);
    acceleration.add(mouse);
  }
  
  //function to have each balloon be attracted to every other
  PVector attract(Balloon b) {
   PVector force = PVector.sub(location,b.location);
   float distance = force.mag();
   distance = constrain(distance,50,200);
   force.normalize();
   //gravitational constant
   float G = 0.005;
   float strength = (mouseVector * G * mass * b.mass) / (distance * distance);
   force.mult(strength);
   return force;
  }
  
  
  void changeColor() {
  if (balloonColor == color(0,150,219)){
    balloonColor = color(165,33,26);
  } else {
    balloonColor = color(0,150,219);
  } 
  }
  
}


