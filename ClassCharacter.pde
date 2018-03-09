//Class Character

class Guy{

  //properties  
  int maxImgRight=3;
  int indexRight=0;
  int maxImgLeft=3;
  int indexLeft=0;
  int jumpcap=height-140;

  float xpos=40;
  float ypos=height-65;

  String jumping = "no";
  String face = "standing";
  String stillFace = "rightStand";

  PImage icon=loadImage("snorDown0.gif");
  PImage[] imgRight = new PImage[maxImgRight];
  PImage[] imgLeft = new PImage[maxImgLeft];
  //end properties

  //load character sprites
  void loadSprites(){
    for(int i =0;i<imgRight.length;i++){
      imgRight[i]=loadImage("snorRight"+i+".gif");
    }
    for(int j =0;j<imgRight.length;j++){
      imgLeft[j]=loadImage("snorLeft"+j+".gif");
    }
  }//end load character sprites


  //runLeft
  void runLeft(){
    face="left";

    //sprite run left animation
    if(indexLeft<3){
      indexLeft+=1;
      //left boundary
      if(xpos>=0){
        xpos-=2;
      }
      else if(xpos<0){
        xpos-=0;
      }//end left boundary
    }
    if(indexLeft>=3){
      indexLeft=0;
    }//end sprite run left animation

  }//end runLeft


  //runRight
  void runRight(){
    face="right";

    //sprite run right animation
    if(indexRight<3){
      indexRight+=1;
      //right boundary
      if(xpos<4129){
        xpos+=2;
      }
      else if(xpos>=4129){
        xpos-=0;
      }//end right boundary
    }
    if(indexRight>=3){
      indexRight=0;
    }//end run right animation

  }//end runRight


  //standing
  void standing(){
    face="stand";
    //face direction
    if(stillFace=="rightStand"){
      indexRight=0;
    }
    if(stillFace=="leftStand"){
      indexLeft=0;  
    }
    xpos-=0;
  }//end standing


  //jump
  void jump(){
    if(jumping == "jump"){
      ypos-=5*.9;
      if(ypos<=jumpcap){
        jumping = "fall";
      }
    }
  }//end jump


  //fall
  void fall(){
    if(jumping =="fall"){
      ypos+=7*.9;
      if(ypos>=height-65){
        jumping = "no";
        ypos = height-65;
      }
    }
  }//end fall



  //display
  void display(){

    //left
    if(face=="left"){
      runLeft();
      stillFace="leftStand";
    }
    //right
    else if(face=="right"){
      runRight();
      stillFace="rightStand";
    }
    //standing
    else if(face=="stand"){
      standing();
    }
    //jumping
    if(jumping=="jump"){
      jump();
    }
    //falling
    else if(jumping=="fall"){
      fall();
    }

  }

}//end class