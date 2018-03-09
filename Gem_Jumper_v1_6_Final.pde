
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//vars

Guy dude;
Enemy enemy;
Dark dark;
HealthBar hp;
Minim minim;
AudioPlayer song;
PFont font;
PImage ground, splodeImg, badSplodeImg, blingImg, buttonImg, buttonPress;
PImage gemImg, enemyIcon;
PImage bg, bgMenu;
String screenStatus = "mainMenu";
String onButton = "none";
float centerX, centerY;
float collisionCount=0,scoreCount=0;
int numFloor, numGem, gemx, gemy;

int[] gx= new int[100];
int[] gy= new int[100];



//setup
void setup(){
//basic
  size(600,400);
  frameRate(50);
  font = loadFont("EurostileRegular-48.vlw");
  textFont(font,30);
  smooth();

//define class instances
  dude = new Guy();
  enemy = new Enemy();
  dark = new Dark();
  hp = new HealthBar();

//execute load voids
  dude.loadSprites();
  enemy.loadEnemy();
  dark.loadDark();

//load images
  splodeImg = loadImage("tealsplode.png");
  badSplodeImg = loadImage("redsplode.png");
  blingImg = loadImage("shine.png");
  buttonImg = loadImage("buttonRed0.gif");
  buttonPress = loadImage("buttonRed1.gif");
  ground = loadImage("tile.gif");
  ground.resize(50,35);
  bg = loadImage("cave.png");
  bg.resize(width,height);
  bgMenu = loadImage("BG_Cave2.png");
  bgMenu.resize(width,height);
  gemImg = loadImage("gemteal.gif");
  enemyIcon = loadImage("HitmonIcon.gif");
  
  minim=new Minim(this);
  song=minim.loadFile("Lufia_Dungeon.mp3");

//define vars
  scoreCount=0;
  centerX = 0;
  centerY = 0;

//gem instances
  for(int i=0;i<gy.length;i++){
    gx[i]=int(100+random(6*width+500));
    gy[i]=int(random(260,350));
  }
//dark instance
  for(int s =0;s<dark.imgD.length;s++){
    dark.imgD[s]=int(width/2);
  }
  
}//end setup


//draw
void draw(){
  keys();
  
//start menu
  if(screenStatus == "mainMenu"){
    Menu();
  }
  else if(screenStatus == "Game"){
    Game();
  }
  else if(screenStatus == "gameOver"){
    gameOver();
  }
  else if(screenStatus == "Victory"){
    Victory();
  }
  else if(screenStatus == "Instruction"){
    Instruction();
  }

}//end draw


//keys()
void keys(){
  //keyPressed
  if(keyPressed){
    //left key
    if(keyCode==LEFT){
      dude.face="left";
    }
    //right key
    if(keyCode==RIGHT){
      dude.face="right";
    }
    //space key
    if(key==' ' && dude.jumping=="no"){
      dude.jumping="jump";
    }
  }//end keyPressed

  //mousePressed
  if(mousePressed){
    if(mouseX>=width/2-40 && mouseX < width/2+60 && mouseY >= height/2+50 && mouseY < height/2+75){
        onButton = "pressMain";
    } 
  if(mouseX>=width/2-40 && mouseX < width/2+60 && mouseY >= height/2+85 && mouseY < height/2+110){
        onButton = "pressHelp";
 }
    if(mouseX>=width/2-40 && mouseX < width/2+60 && mouseY >= height-50 && mouseY < height-25){
      onButton = "pressHelpPage";
  } 
  }//end mousePressed
}//end keys


//mouseRelease
void mouseReleased(){
  if(onButton == "pressMain"){
    if(screenStatus == "mainMenu" || screenStatus == "gameOver" || screenStatus == "Victory"){
      screenStatus = "Game";
      onButton = "none";
      redraw();
      setup();
      collisionCount=0;
      enemy.expos=0;
    }

  }else if(onButton == "pressHelp"){
    screenStatus = "Instruction";
    onButton = "none";
  
  }else if(onButton == "pressHelpPage"){
    screenStatus = "mainMenu";
    onButton = "none";
  
  }
}//end mouseRelease


//keyReleased
void keyReleased(){
  //right key
  if(keyCode==RIGHT){
    dude.standing();
  }
  //left key
  if(keyCode==LEFT){
    dude.standing();
  }
  //space key
  if(key==' '){
    dude.jumping="fall";
  }
}//end keyReleased


//floor 
void drawFloor(int screenSet){
  image(ground,numFloor*width+centerX-50,365);
  image(ground,numFloor*width+centerX,365);
  image(ground,numFloor*width+centerX+50,365);
  image(ground,numFloor*width+centerX+100,365);
  image(ground,numFloor*width+centerX+150,365);
  image(ground,numFloor*width+centerX+200,365);
  image(ground,numFloor*width+centerX+250,365);
  image(ground,numFloor*width+centerX+300,365);
  image(ground,numFloor*width+centerX+350,365);
  image(ground,numFloor*width+centerX+400,365);
  image(ground,numFloor*width+centerX+450,365);
  image(ground,numFloor*width+centerX+500,365);

  numFloor=screenSet;
}//end floor


//score
void drawScore(){
  fill(255);
  textSize(18);
  text("Score:"+scoreCount,(450+dude.xpos),30);
}//end score


void Game(){
  background(bg);
  pushMatrix();
  translate(centerX-dude.xpos+40,centerY);
  fill(0);
  rect(4150,0,600,height);
 
  //execute voids
  dude.display();
  enemy.displayEnemy();
  dark.animateDark(4000,240);
  drawScore();

  //floor
  drawFloor(0);
  drawFloor(1);
  drawFloor(2);
  drawFloor(3);
  drawFloor(4);
  drawFloor(5);
  drawFloor(6);

  //hp
  hp.barDisplay(centerX+dude.xpos,hp.hpyDisp);
  hp.fillDisplay(centerX+dude.xpos);

  //draw character
  //initial image
  image(dude.imgRight[0],dude.xpos,dude.ypos);
  //run left
  if(dude.face=="left"){
    image(dude.imgLeft[dude.indexLeft],dude.xpos,dude.ypos);
  }
  //run right
  else if(dude.face=="right"){
    image(dude.imgRight[dude.indexRight],dude.xpos,dude.ypos);
  }
  //stand
  if(dude.face=="stand"){
    if(dude.stillFace=="rightStand"){
      image(dude.imgRight[0],dude.xpos,dude.ypos);
    }
    if(dude.stillFace=="leftStand"){
      image(dude.imgLeft[0],dude.xpos,dude.ypos);
    }
  }
  //jump/fall
  if(dude.jumping=="jump" || dude.jumping=="fall"){
    if(dude.stillFace=="leftStand"){
      image(dude.imgLeft[2],dude.xpos,dude.ypos);
    }
    else if (dude.stillFace=="rightStand"){
      image(dude.imgRight[2],dude.xpos,dude.ypos);
    }
  }//end draw character  

  //goal collision
  if(dude.xpos>=dark.darkXpos+10 && dude.xpos < dark.darkXpos+70 && dude.ypos <= dark.darkYpos+60){
    dark.animate=false;
    screenStatus = "Victory";
  }

  //gem array data
  for(int j=0; j<gx.length;j++){
    image(gemImg,gx[j],gy[j]);
    gemx=gx[j];
    gemy=gy[j];

    //erase gem on collision
    if(dude.xpos+21> gx[j] && dude.xpos<= gx[j]+14 && dude.ypos<=gy[j]+13 && dude.ypos+31>gy[j]){
      gx[j]=0;
      gy[j]=0;
      scoreCount++;
      image(blingImg,gemx,gemy);
    }
  }//end gem array data
  
  popMatrix();

}//end main game draw



//Screens
//Main Menu
void Menu(){
  background(bgMenu);
  imageMode(CORNER);
  tint(0);
  song.loop();
  image(buttonImg,width/2-38,height/2+52);
  image(buttonImg,width/2-38,height/2+87);
  noTint();
  if(onButton == "none"){
    image(buttonImg,width/2-40,height/2+50);
    image(buttonImg,width/2-40,height/2+85);
  }else if(onButton == "pressMain"){
    image(buttonPress,width/2-40,height/2+50);
    image(buttonImg,width/2-40,height/2+85);
  }else if(onButton == "pressHelp"){
    image(buttonImg,width/2-40,height/2+50);
    image(buttonPress,width/2-40,height/2+85);
  }

  fill(0);
  textSize(55);
  text("GEM JUMPER",width/4+12,height/2+2);
  fill(180,175,50);
  textSize(55);
  text("GEM JUMPER",width/4+10,height/2);
  fill(0);
  textSize(18);
  text("Start",width/2-5,height/2+68);
  text("Help",width/2-1,height/2+103);
}//end Main Menu

void Instruction(){
   background(bgMenu);
  imageMode(CORNER);
  screenGems();
  tint(0);
  image(buttonImg,width/2-38,height-48);
  noTint();
  image(dude.icon,width/2-50,height/2-25);
  image(enemyIcon, width/2+50,height/2-25);

  dark.animateDark(width/2-30, height/2+30);
  if(onButton == "none"){
    image(buttonImg,width/2-40,height-50);
  }
  else if(onButton == "pressHelpPage"){
    image(buttonPress,width/2-40,height-50);
  }
  fill(180,175,50);
    textSize(18);
  text("Use the left and right arrow keys to move your character across the screen.",26,height/4-29);
  text("Press the space bar to jump to collect gems or pound enemies.",66,height/4-9);
  text("Enemies can be defeated by jumping on their heads. If you run into them head on,",6,height/4+11);
  text("you will suffer damage. Be careful, if your health reaches 0, the game is over!",21,height/4+31);
  text("Your overall goal is to reach the vortex safely. Once you find it, jump in to win!",21,height/4+51);
  fill(0);
  text("Back",width/2-5,height-32);
  text("Use the left and right arrow keys to move your character across the screen.",25,height/4-30);
  text("Press the space bar to jump to collect gems or pound enemies.",65,height/4-10);
  text("Enemies can be defeated by jumping on their heads. If you run into them head on,",5,height/4+10);
  text("you will suffer damage. Be careful, if your health reaches 0, the game is over!",20,height/4+30);
  text("Your overall goal is to reach the vortex safely. Once you find it, jump in to win!",20,height/4+50);
  textSize(14);
  fill(255);
  text("Your Character", width/2-79,height/2+16);
  text("Enemy", width/2+46,height/2+16);
  text("Vortex",width/2-4,height/2+41);
     fill(0);
  text("Your Character", width/2-80,height/2+15);
  text("Enemy", width/2+45,height/2+15);
  text("Vortex",width/2-5,height/2+40);

   textSize(30);
    text("Instructions",width/2-48,42);
   fill(180,175,50);
   text("Instructions",width/2-50,40);
}

//Game Over
void gameOver(){
  tint(255,0,0);
  background(0);
  image(dude.icon,width/2,height/2+5);
  fill(200);
  textSize(40);
  text("DEAD",width/4+115,height/2);
  noTint();
  imageMode(CORNER);
  if(onButton == "none"){
    image(buttonImg,width/2-40,height/2+50);
  }
  else if(onButton == "pressMain"){
    image(buttonPress,width/2-40,height/2+50);
  }
  fill(0);
  textSize(16);
  text("Restart",width/2-8,height/2+68);
}//end Game Over

//Victory
void Victory(){
  background(bgMenu);
  tint(0);
  image(buttonImg,width/2-38,height/2+52);
  noTint();
  if(onButton == "none"){
    image(buttonImg,width/2-40,height/2+50);
  }
  else if(onButton == "pressMain"){
    image(buttonPress,width/2-40,height/2+50);
  }
  fill(0);
  textSize(55);
  text("VICTORY",width/2-80,height/2-18);
  fill(180,175,50);
  text("VICTORY",width/2-82,height/2-20);
  textSize(30);
  fill(0);
  text("Score:"+scoreCount,width/2-48,height/2+13);
  fill(180,175,50);
  text("Score:"+scoreCount,width/2-50,height/2+15);
  fill(0);
  textSize(18);
  text("Again",width/2-5,height/2+68);
}//end Victory

void screenGems(){
  //left gems
  image(gemImg,80,height/2-40);
  image(gemImg,130,height/2-20);
  image(gemImg,180,height/2);
  
  image(gemImg,30,height/2);
  image(gemImg,80,height/2+20);
  image(gemImg,130,height/2+40);
  image(gemImg,180,height/2+60);
  
  image(gemImg,30,height/2+60);
  image(gemImg,80,height/2+80);
  image(gemImg,130,height/2+100);
  image(gemImg,180,height/2+120);
  
  image(gemImg,30,height/2+120);
  image(gemImg,80,height/2+140);
  image(gemImg,130,height/2+160);
  
  image(gemImg,30,height/2+180);
  
  
  //right gems
  image(gemImg,520,height/2-40);
  image(gemImg,470,height/2-20);
  image(gemImg,420,height/2);
  
  image(gemImg,570,height/2);
  image(gemImg,520,height/2+20);
  image(gemImg,470,height/2+40);
  image(gemImg,420,height/2+60);
  
  image(gemImg,570,height/2+60);
  image(gemImg,520,height/2+80);
  image(gemImg,470,height/2+100);
  image(gemImg,420,height/2+120);
  
  image(gemImg,570,height/2+120);
  image(gemImg,520,height/2+140);
  image(gemImg,470,height/2+160);
  
  image(gemImg,570,height/2+180);
}

void stop(){
  song.close();
  minim.stop();
  super.stop();
}