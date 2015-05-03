Balloon[] balloons = new Balloon[100];

int mouseVector = -1;
color backColor = color(235);
color fillColor = color(165,33,26);

void setup() {
  size(600 , 600);
  smooth();
  //initialize our balls
  for (int i = 0; i < balloons.length; i++) { 
    balloons[i] = new Balloon(random(200, 400.0),random(50, width - 50),random(50, height - 50), fillColor);
  }
 }

void draw() {
  background(backColor);
  
  //for every balloon 
  for (int i = 0; i < balloons.length; i++) {
    
    //add friction to our world, so they don't bounce around forever
    float c = 0.8;
    PVector friction = balloons[i].velocity.get();
      friction.mult(-1);
      friction.normalize();
      friction.mult(c);
    
    
    //apply friction
    balloons[i].applyForces(friction);
    
    //have the balloons be attracted to each other
//    for (int j = 0; j < balloons.length; j++) {
//       if (i != j){
//         PVector force = balloons[j].attract(balloons[i]);
//         balloons[i].applyForces(force); 
//       }
//    }
       
    //update position, draw them, check to see if they are hitting the walls
    balloons[i].mouseAction(); 
    balloons[i].update();
    balloons[i].checkEdges();
    balloons[i].display();
       
    }
   }


void mousePressed() {
  if (mouseVector == -1){
    mouseVector = 1;
  } else if (mouseVector == 1){
    mouseVector = -1;
  }
  
  if (backColor == color(235)){
    backColor = color(20);
  } else {
    backColor = color(235);
  }
  
  for (int i = 0; i < balloons.length; i++) {
    balloons[i].changeColor();
  }
}

void keyPressed() {
  save("screenshot####.jpg");
}
