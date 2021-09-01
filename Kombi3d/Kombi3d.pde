float cameraRotateX;
float cameraRotateY;
float cameraSpeed;
float t3;
float t4;
float angle;
float expessura = 0.8;

void setup(){ 
  size(1000, 500, P3D);
  cameraRotateX = -PI/6;
  cameraRotateY = 0;
  cameraSpeed = TWO_PI / width;
  t3 = 0;
  t4 = 0;
}


void draw(){
  
  ambientLight(90, 110, 120);
  spotLight(255, 255, 255, mouseX, mouseY, 2000, 0, 0, -1, 2, 10000);
  directionalLight(255, 255, 126, 1, 1, 0);
  background(#343434);
  perspective();
  translate(width/2+30, height/2, t3/7);

  if(mousePressed && mouseButton==LEFT){
     cameraRotateX += (pmouseX - mouseX) * cameraSpeed;
     cameraRotateY += (pmouseY - mouseY) * cameraSpeed;
     cameraRotateX = constrain(cameraRotateX, -PI, 0);
     cameraRotateY = constrain(cameraRotateY, -PI/8, 0);
     rotateY(-cameraRotateX);
     rotateX(+cameraRotateY);
  }
  else{
    rotateY(-cameraRotateX);
    rotateX(+cameraRotateY);
  } 
  
  if(mousePressed && mouseButton==RIGHT){
     rotateY(-cameraRotateX);
     rotateX(+cameraRotateY);
     t4 += (pmouseY - mouseY);
     translate(0, t4, 0); 
  }
  
  else{
    translate(0, t4, 0);
    rotateY(-cameraRotateX);
    rotateX(+cameraRotateY);
  }
  
  translate(50, 100,  -80);
  
  // kombi fairing
  
  fill(#A7A6A6);
  noStroke();
  
  pushMatrix();
    
    translate(0, -190, 0);
    for(int i = 0; i<240; i++){    
      if(i<=30 || i>=110){
        fill(#00DE35);
        box(300+log(pow(i, 14)), expessura, 195 + log(pow(i, 4)));
      }
      else{
        fill(#6ADDFF);
        box(290+log(pow(i, 14)), expessura, 190 + log(pow(i, 4)));
      }
      
      translate(0, expessura, 0);
    }
  popMatrix();
  
  
  fill(#A7A6A6);
  pushMatrix();
    translate(0, -4, 0);
    box(380, 8, 220);
  popMatrix();
  
  
  pushMatrix();
    noStroke();
    for(int i = 0; i<8; i=i+1){
      box(390+i, expessura, 220 - sqrt(pow(i, 3)));
      translate(0, expessura, 0);
    }
    translate(0, -40, 0);
  popMatrix();
  
  // tires
  pushMatrix();
    fill(0);
    
    stroke(#151515);
    rotateX(PI/2);
    
    // front-right
    translate(-100, 90, -10);
    cylinder(38, 38, 30, 15); 
    
    // front-left
    translate(0, -210, 0);
    cylinder(38, 38, 30, 15); 
    
    // back-left
    translate(200, 2, 0);
    cylinder(38, 38, 30, 15); 
    
    // back-right
    translate(0, 210, 0);
    cylinder(38, 38, 30, 15); 
  popMatrix();
  
  
  // headLights
  pushMatrix();
    rotateZ(HALF_PI);
    noStroke();
    
    fill(#FAA158);
    translate(-20, 180, 70);
    cylinder(5, 10, 10, 15); 
    fill(#FAA158, 90);
    sphere(14);
    
    fill(#FAA158);
    translate(0, 0, -140);
    cylinder(5, 10, 10, 15); 
    fill(#FAA158, 90);
    sphere(14);
    
    fill(#FAA158);
    translate(-40, 0, -15);
    cylinder(5, 12, 10, 15);
    fill(#FAA158, 90);
    sphere(14);
    
    fill(#FAA158);
    translate(0, 0, 170);
    cylinder(5, 12, 10, 15);
    fill(#FAA158, 90);
    sphere(14);  
  popMatrix();
  
  print("\n\nmouse X: ", mouseX); //380
  print("\nmouse Y: ", mouseY);// 290
  
  
}
void mouseWheel(MouseEvent event){
  t3 += event.getCount()*50;
}


void cylinder(float bottom, float top, float h, int sides)
{
  pushMatrix();
  
  translate(0,h/2,0);
  
  float angle;
  float[] x = new float[sides+1];
  float[] z = new float[sides+1];
  
  float[] x2 = new float[sides+1];
  float[] z2 = new float[sides+1];
 
  
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x[i] = sin(angle) * bottom;
    z[i] = cos(angle) * bottom;
  }
  
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x2[i] = sin(angle) * top;
    z2[i] = cos(angle) * top;
  }
 
  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN);
 
  vertex(0,   -h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
  }
 
  endShape();
 
  //draw the center of the cylinder
  beginShape(QUAD_STRIP); 
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
    vertex(x2[i], h/2, z2[i]);
  }
 
  endShape();
 
  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN); 
 
  vertex(0,   h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x2[i], h/2, z2[i]);
  }
 
  endShape();
  
  popMatrix();
}
