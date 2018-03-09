//Health Bar
class HealthBar{
  String hpStatus="full";
  float hpxDisp=40, hpyDisp=20, hpxSize=100, hpySize=15;
  color hpfill = color(0,255,50);
  PImage portrait=loadImage("snorDown0.gif");

  //display Bar
  void barDisplay(float x, float y){
    hpxDisp=x;
    hpyDisp=y;
    noFill();
    stroke(0);
    rect(hpxDisp,hpyDisp,100,15);
    image(portrait,centerX+(dude.xpos-30),15);
  }//end display Bar

//display Fill
  void fillDisplay(float fillx){
    hpxDisp=fillx;
    
    //collision vs. health data
    if(collisionCount==0){
      hp.hpStatus="full";
    }
    else if(collisionCount==1){
      hp.hpStatus="1hit";
    }
    else if(collisionCount==2){
      hp.hpStatus="2hit";
    }
    else if(collisionCount==3){
      hp.hpStatus="3hit";
    }
    else if(collisionCount==4){
      hp.hpStatus="4hit";
      screenStatus="gameOver";
    }//end collision vs. health data
    
    //damage status data
    if(hpStatus=="full"){
      noStroke();
      fill(hpfill);
      rect(hpxDisp,hpyDisp,100,15);
    }
    else if(hpStatus=="1hit"){
      noStroke();
      fill(hpfill);
      rect(hpxDisp,hpyDisp,75,15);
    }
    else if(hpStatus=="2hit"){
      noStroke();
      fill(hpfill);
      rect(hpxDisp,hpyDisp,50,15);
    }
    else if(hpStatus=="3hit"){
      noStroke();
      fill(hpfill);
      rect(hpxDisp,hpyDisp,25,15);
    }
    else if(hpStatus=="4hit"){
      fill(200,20,20);
      text("DEAD",hpxDisp+30,hpyDisp+15);
    }//end damage status data
  }//end display Fill
}//end class Health Bar



//Dark
class Dark{
  int maxImg=11;
  int darkIndex=0;
  float darkXpos, darkYpos;
  PImage[] img;
  boolean animate=true;
  int [] imgD = new int[500];

//load Dark
  void loadDark(){
    img = new PImage[maxImg];
    img[0] = loadImage("darkPortal0.png");
    img[1] = loadImage("darkPortal1.png");
    img[2] = loadImage("darkPortal2.png");
    img[3] = loadImage("darkPortal3.png");
    img[4] = loadImage("darkPortal4.png");
    img[5] = loadImage("darkPortal5.png");
    img[6] = loadImage("darkPortal6.png");
    img[7] = loadImage("darkPortal7.png");
    img[8] = loadImage("darkPortal8.png");
    img[9] = loadImage("darkPortal9.png");
    img[10] = loadImage("darkPortal10.png");
  }//end load Dark
  
//animate Dark
  void animateDark(int x, int y){
    //Dark array data
    for(int b=0; b<imgD.length;b++){
      if(animate){
        darkXpos=x;
        darkYpos=y;
      //  darkXpos=4000;
      //  darkYpos=240;
        image(img[darkIndex],darkXpos,darkYpos);
      }
      else{
        imgD[b]=0;
      }
    }//end Dark array data
    
    //Dark animation loop
    if(darkIndex==0){
      darkIndex=1;
    }
    else if(darkIndex==1){
      darkIndex=2;
    }
    else if(darkIndex==2){
      darkIndex=3;
    }
    else if(darkIndex==3){
      darkIndex=4;
    }
    else if(darkIndex==4){
      darkIndex=5;
    }
    else if(darkIndex==5){
      darkIndex=6;
    }
    else if(darkIndex==6){
      darkIndex=7;
    }
    else if(darkIndex==7){
      darkIndex=8;
    }
    else if(darkIndex==8){
      darkIndex=9;
    }
    else if(darkIndex==9){
      darkIndex=10;
    }
    else if(darkIndex==10){
      darkIndex=0;
    }//end Dark animation loop
  }//end animate Dark
}//end class Dark