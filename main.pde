PImage space;
PImage spacecat;
ArrayList toys; 
int acc= 1;
int speed = 1;
int time;
int h = 1;
int score;
int screen;
boolean shoot;
boolean lose;
float strike;
float shots;
int starterTime; 


void setup()
{
  fullScreen();
  toys = new ArrayList();  //Array list for falling ellipses
  noCursor();
  spacecat= loadImage ("spacecat.png");   //downloads space images into gamescreen 
  space= loadImage ("realspace wallpaper.jpg");
  imageMode(CENTER);
  starterTime = frameCount; // coordinated frame count with timer
  frameRate(30);


}

void draw(){
 drawPhase1 ();
 drawPhase2 ();
 display(laser); 
  display (laser);
  drawMovingCircle();
  spawn ();
  drawTime();

 
 if (screen ==1) {    //screen switch from introductory scene to game screen 
   drawPhase1 ();
 }
 else if (screen == 2) {
   drawPhase2 ();
 }
}



void drawPhase1(){
  background(255);
  textSize (100);
    text ("SpaceCat", 400, 200);      //introductory screen content
    textSize (50);
    text ("Creator: Yasmeen Hmaidan", 390, 300);
    textSize (40);
    text ("Instructions:", 100, 400);
    text ("Move your Cat Eye Laser by moving your mouse", 100, 500);
    text ("Press the [Spacebar] to fire the laser at the approcahing Enemies.",100, 600);
    text ("Click your mouse to start your SpaceCat adventure!", 100, 800); 
  }

  
void drawPhase2 () { 
  
  colorMode(RGB, 255); 
  image(space, 960, 480); //places image of space as background


  image(spacecat, width/1.75, height/2); //up cat left
  image(spacecat, width/3, height/3); //up cat middle 
  imageMode (CENTER); 
  
  text("Destroy the enemy! Deploy the Cat Eye.", 850, 300);
  text("Roger that, Commander.", 1200, 700);
  
  int timer= (frameCount-time)/60;
  textSize (50);
  fill (155);
  text ("Time:", 1600, 1000);
  text (timer, 1750, 1000);
  
  if(!lose)
  {
   
    text("Score: " + score, 300, 1000);
    text("Level: " + speed, 700, 1000);
    text("Precision: " + h, 1100, 1000);
    if(shots != 0)
    {
      text("Precision: " + int(strike) + "/" + int(shots), 1100, 1000);
    }
    time++;
  }
  else
  {
    text("Meow, you lost! ",10,40);   //final screen display of game over
    text("Meowtastic Score: " + score,10,100);
  }

  shoot = false;


//void keyPressed()  //spacebar laser control
//{
  if (key==' ') {
  shoot = true;
  shots ++;
}
}
  
  class toys
{
  int x;
  int y;
  int r;
  int maxHealth;
  int health;
  float speed;
  
  toys(int tx, int tr, float tspeed, int th)
  {
    x = tx;
    r = tr;
    speed = tspeed;
    maxHealth = th;   //health bar stats
    health = maxHealth;
  }
  
  //void move
  {
    y += speed;
  }
  
  
 //moving of the circles 

 void display()
 {
   fill(255);
    ellipse(x,y,r,r);
    float hbar = health/maxHealth * 20;  //health bar limited
    println(health + "" + maxHealth);
    fill(255,0,0);
    text(health, x - 2, y + 5);
 }
   { for(int i = 0; i < toys.size(); i++)
  {
    toys comp = (toys)toys.get(i);
    comp.display();
    comp = null;
  }

  for(int i = 0; i < toys.size(); i++)
  {
    toys lime = (toys)toys.get(i); //one of the array list's get function

    lime = null;
  }
  fill(255);
  ellipse(mouseX-20,800,200, 40);   //laser gun makeup (vertical piece)
  fill(175);
  ellipse(mouseX-10,800,50, 40);    //laser gun makeup (horizontal piece)
  if(shoot)
  {
    stroke(99); 
    line(mouseX,0,mouseX,500);
   stroke(0);
  }
  }

  
 void spawn() {
 
  
  if(time == 30)
  {
    time = 0;
    toys lime = new toys(int(random(30,470)), int(random(20,40)), speed, h);
    toys.add(lime);  //one of the array list's add function
    lime = null;
    acc++;
  }
}
 }

void mousePressed () {
   screen += 1;
   if (screen >2) {
     screen = 1;
   }
}

float mouseLaser() {
  
  return map(mouseX, 0, width, 100, 500);
}
float addition(float x, float y) {
  float c = x + y;
  return c;
}
  



void pew()
{
  if(shoot)
  {
    for(int i = 0; i < toys.size(); i++)  //when laser hits target enemy, they shrink down in size
    {
      toys lime = (toys) toys.get(i); //second use of the array list's get function
      if(mouseX < lime.x + lime.r && mouseX > lime.x - lime.r)
      {
        lime.health -= 1;      //health bar scores
        if(lime.health <= 0)   // that determine loss and prompt end score
        {
          lime = null;
          toys.remove(i);  //one of the array list's remove function
          score += int(speed) + h;  //score determined by speed of enemies approaching space ship + cats & number of enemy aliens destroyed (per 3 strike)
        }
        strike ++;
        score ++;
      }
    }
  } 
}


void drawLossscreen()         //if a circle gets off screen= loss
  {
  for(int i = 0; i < toys.size(); i++)
  {
    toys lime = (toys) toys.get(i); //third use of the array list's get function
    if(lime.y > 500)
    {
      lose = true;          
    }
  }
}


void difficultyChange() {  //different difficulty (incorporates level concept)
  if(speed < 8 && acc>= 10)
  {
    speed = acc/ 10;
  }
  if(h < 3 && acc>= 10)
  {
    h = int(acc/ 10);
  }
}
