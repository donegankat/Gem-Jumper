//Enemy
class Enemy{

  //properties
  int expos, eypos;
  int eMaxImgLeft=4;
  int eIndexLeft=0;
  int eMaxImgRight=4;
  int eIndexRight=0;
  int[] ex= new int[25];
  int[] ey= new int[25];
  PImage[] eImgLeft, eImgRight;

  //load Enemy sprites
  void loadEnemy(){
    eImgLeft = new PImage[eMaxImgLeft];
    eImgRight = new PImage[eMaxImgRight];
    eImgLeft[0] = loadImage("HitmonLeft"+0+".gif");
    eImgLeft[1] = loadImage("HitmonLeft"+1+".gif");
    eImgLeft[2] = loadImage("HitmonLeft"+2+".gif");
    eImgLeft[3] = loadImage("HitmonLeft"+3+".gif");
    
    for(int a=0;a<ey.length;a++){
      ex[a]=int(250+random(6*width+800));
      ey[a]=int(height-60);
    }
  }//end load Enemy sprites

//display Enemy
  void displayEnemy(){
    //enemy sprite animation loop
    if(eIndexLeft==0){
      eIndexLeft=1;
    }
    else if(eIndexLeft==1){
      eIndexLeft=2;
    }
    else if(eIndexLeft==2){
      eIndexLeft=3;
    }
    else if(eIndexLeft==3){
      eIndexLeft=0;
    }//end enemy sprite animation loop

    //enemy array data
    for(int b=0; b<ex.length;b++){
      image(eImgLeft[eIndexLeft],ex[b],ey[b]);
      expos=ex[b];
      eypos=ey[b];
      ex[b]-=.5;

      //enemy hit collision
      if(dude.xpos+21 > ex[b] && dude.xpos <= ex[b]+25){
        if(dude.ypos+31<=ey[b] && dude.ypos+31>ey[b]-15){
          ex[b]=0;
          ey[b]=0;
          image(splodeImg,expos-10,eypos-20);
          scoreCount+=10;
        }
        else if(dude.ypos+5>=ey[b]){
          ex[b]=0;
          ey[b]=0;
          collisionCount+=1;
          scoreCount-=20;
          image(badSplodeImg,expos-10,eypos-20);
        }
      }
      //end enemy hit collision

    }//end enemy array data

  }//end display Enemy
}//end class Enemy