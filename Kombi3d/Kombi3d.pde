import java.io.PrintStream;
import java.io.OutputStream;
import processing.sound.*;
SoundFile motor;
SoundFile buzina;

boolean lMotor = false;
boolean headlight = false;
boolean lArrow = false;
boolean rArrow = false;
boolean earView = false;
boolean retracting = true;
boolean wiping = false;
boolean orthographic = false;
int ArrowDelay = 0;
int x = -50;
int y = -75; 
int tothe = 0;

float theta; 
float newX = x, newY = y;
float cameraRotateX;
float cameraRotateY;
float cameraSpeed;
float t3;
float t4;
float angle;
float expessura = 0.8;

void setup() { 
  size(1000, 1000, P3D);
  motor = new SoundFile(this, "Ligando.mp3");
  buzina = new SoundFile(this, "audioZap.mp3");
  cameraRotateX = -PI/6;
  cameraRotateY = 0;
  cameraSpeed = TWO_PI / width;
  t3 = 0;
  t4 = 0;
}

void draw() {
  
  background(#343434);
  ambientLight(80, 100, 110);
  //spotLight(255, 255, 255, mouseX, mouseY, 2000, 0, 0, -1, 2, 10000);
  directionalLight(255, 255, 126, 1, 1, 0);
  
  camera();
  
  texts();
  
  if(orthographic) ortho();
  else perspective();
  translate(width/2+30, height/2, t3/7);
  if (mousePressed && mouseButton==LEFT) {
    cameraRotateX += (pmouseX - mouseX) * cameraSpeed;
    //cameraRotateY += (pmouseY - mouseY) * cameraSpeed;
    //cameraRotateX = constrain(cameraRotateX, -PI, 0);
    cameraRotateY = constrain(cameraRotateY, -PI/8, 0);
    rotateY(-cameraRotateX);
    rotateX(-cameraRotateY);
    translate(0, t4, 0);
  } else {
    rotateY(-cameraRotateX);
    rotateX(-cameraRotateY);
    translate(0, t4, 0);
  } 

  if (mousePressed && mouseButton==RIGHT) {
    rotateY(-cameraRotateX);
    rotateX(+cameraRotateY);
    t4 += (pmouseY - mouseY)/2;
    translate(0, t4, 0);
  } else {
    translate(0, t4, 0);
    rotateY(-cameraRotateX);
    rotateX(+cameraRotateY);
  }

  translate(50, 100, -80);

  // kombi fairing

  fill(#A7A6A6);
  noStroke();

  pushMatrix();

  translate(0, -190, 0);
  for (int i = 0; i<240; i++) {    
    if (i<=30 || i>=110) {
      fill(#00DE35);
      box(300+log(pow(i, 14)), expessura, 195 + log(pow(i, 4)));
    } else {
      fill(#6ADDFF, 70);
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
  for (int i = 0; i<8; i=i+1) {
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

  // step
  translate(115, -95, 70);
  rotate(HALF_PI);
  rotateX(-0.05);
  rotateZ(0.07);
  cylinder(38, 38, 30, 15); 

  popMatrix();


  // headLights
  pushMatrix();
  rotateZ(HALF_PI);
  stroke(#FAA158);

  // left little headLights
  if (lArrow == true && ArrowDelay<=10) stroke(#FAA158);
  else noStroke();
  fill(#FAA158);
  translate(-20, 180, 70);
  cylinder(5, 10, 10, 15); 
  fill(#FAA158, 90);
  sphere(14);

  // back left little headLights
  pushMatrix();
  fill(#A00000, 90);
  rotateX(PI);
  if (lArrow == true && ArrowDelay<=10) stroke(#A00000);
  else noStroke();
  translate(0, +360, 0);
  cylinder(5, 10, 10, 15); 
  sphere(14);
  popMatrix();

  // right little headLights
  if (rArrow == true && ArrowDelay<=10) stroke(#FAA158);
  else noStroke();
  fill(#FAA158);
  translate(0, 0, -140);
  cylinder(5, 10, 10, 15); 
  fill(#FAA158, 90);
  sphere(14);

  // back right little headLights
  pushMatrix();
  fill(#A00000, 90);
  rotateX(PI);
  if (rArrow == true && ArrowDelay<=10) stroke(#A00000);
  else noStroke();
  translate(0, +360, 0);
  cylinder(5, 10, 10, 15); 
  sphere(14);
  popMatrix();


  // headLights
  if (headlight==true) stroke(#FAA158);
  else noStroke();
  
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

  if (ArrowDelay == 20) ArrowDelay = 0;
  ArrowDelay++;

  popMatrix();


  // friso
  noStroke();
  fill(#CBCBCB);
  pushMatrix();
  translate(-173, -135, 0);
  rotate(QUARTER_PI-0.65);
  box(5, 65, 5);
  popMatrix();

  pushMatrix();
  translate(-173, -134, 102);
  rotate(QUARTER_PI-0.65);
  rotateX(QUARTER_PI-0.75);
  box(5, 65, 5);
  popMatrix();

  //right frisos
  pushMatrix();
  translate(-60, -134, 99.5);
  rotate(QUARTER_PI-0.8);
  rotateX(QUARTER_PI-0.75);
  box(20, 65, 10);
  popMatrix();

  pushMatrix();
  translate(60, -134, 99.5);
  rotate(QUARTER_PI-0.8);
  rotateX(QUARTER_PI-0.75);
  box(20, 65, 10);
  popMatrix();

  pushMatrix();
  translate(170, -134, 99.5);
  rotate(QUARTER_PI-0.9);
  rotateX(QUARTER_PI-0.75);
  box(10, 65, 10);
  popMatrix();


  pushMatrix();
  translate(-173, -134, -99.5);
  rotate(QUARTER_PI-0.65);
  rotateX(QUARTER_PI-0.82);
  box(5, 65, 5);
  popMatrix();

  //left frisos
  pushMatrix();
  translate(-60, -134, -102);
  rotate(QUARTER_PI-0.8);
  rotateX(QUARTER_PI-0.82);
  box(20, 65, 5);
  popMatrix();

  pushMatrix();
  translate(60, -134, -102);
  rotate(QUARTER_PI-0.8);
  rotateX(QUARTER_PI-0.82);
  box(20, 65, 5);
  popMatrix();

  pushMatrix();
  translate(170, -134, -102);
  rotate(QUARTER_PI-0.9);
  rotateX(QUARTER_PI-0.82);
  box(10, 65, 5);
  popMatrix();

  // logo
  pushMatrix();
    translate(-50, -100, 80);
    translate(-155, -110, -270); 
    rotateY(HALF_PI+3.2);
    scale(0.4);
    logo();
  popMatrix();
  
  // wipers
  pushMatrix();
    //left wiper
    translate(-600, 0, 0);
    line(0, 0, newX, newY);
    fill(#000000);
    ellipse(0,0,7,7);
    //right wiper
    translate(280, 0);
    ellipse(0,0,7,7);
    line(0, 0, newX, newY);
    
    if(wiping == true){
    newX = x*cos(theta)- y*sin(theta);
    newY = x*sin(theta)+ y*cos(theta);
    if(theta < PI/2 + 0.55 && tothe == 0) {
      theta = theta + PI/15;
      if(theta > PI/2 + 0.55) tothe = 1;
    }
    if (tothe == 1) {
      theta = theta - PI/15;
      if(theta < -PI/2 + 0.8) tothe = 0;
    }
  }
  popMatrix();
}


void mouseWheel(MouseEvent event) {
  t3 += event.getCount()*50;
}


void cylinder(float bottom, float top, float h, int sides)
{
  pushMatrix();
  translate(0, h/2, 0);

  float angle;
  float[] x = new float[sides+1];
  float[] z = new float[sides+1];

  float[] x2 = new float[sides+1];
  float[] z2 = new float[sides+1];


  for (int i=0; i < x.length; i++) {
    angle = TWO_PI / (sides) * i;
    x[i] = sin(angle) * bottom;
    z[i] = cos(angle) * bottom;
  }
  for (int i=0; i < x.length; i++) {
    angle = TWO_PI / (sides) * i;
    x2[i] = sin(angle) * top;
    z2[i] = cos(angle) * top;
  }

  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN);

  vertex(0, -h/2, 0);

  for (int i=0; i < x.length; i++) {
    vertex(x[i], -h/2, z[i]);
  }

  endShape();

  //draw the center of the cylinder
  beginShape(QUAD_STRIP); 
  for (int i=0; i < x.length; i++) {
    vertex(x[i], -h/2, z[i]);
    vertex(x2[i], h/2, z2[i]);
  }
  endShape();

  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN); 
  vertex(0, h/2, 0);

  for (int i=0; i < x.length; i++) {
    vertex(x2[i], h/2, z2[i]);
  }

  endShape();
  popMatrix();
}

void logo() {

  //logo
  pushMatrix();
  //noStroke();
  strokeWeight(8);
  fill(#FFFFFF);
  ellipse(487, 390, 140, 100);
  triangle(412, 440, 425, 412, 452, 432);
  stroke(#FFFFFF);
  strokeWeight(3);
  line(425, 412, 412, 440);
  line(452, 432, 412, 440);
  arc(487, 390, 140, 100, PI-0.50, TWO_PI+2.1);
  popMatrix();


  //inside the logo
  pushMatrix();
  translate(0, 0, 2);
  stroke(255);
  strokeWeight(5);
  fill(#45FC4C);
  triangle(440, 410, 450, 418, 430, 426);
  fill(#45FC4C);
  ellipse(487, 390, 110, 77);
  popMatrix();


  //phone
  translate(0, 0, 3);
  strokeWeight(3);
  stroke(#FFFFFF);
  fill(#FFFFFF, 0);
  arc(508, 375, 110, 77, HALF_PI, PI);
  fill(#FFFFFF);
  arc(464, 375, 20, 14, PI+QUARTER_PI-0.8, TWO_PI-1); 
  arc(496, 405, 48, 20, PI+2.6, TWO_PI+1);
  fill(#FFFFFF, 0);
  arc(518, 387, 95, 38, HALF_PI+0.55, PI);
  line(470, 369, 475, 382);
  line(502, 394, 515, 398);
  line(475, 382, 470, 388);
  line(502, 394, 494, 402);


  //phone color inside the logo

  translate(0, 0, 2);
  strokeWeight(1);
  noStroke();
  fill(#FFFFFF);
  circle(505, 405, 15);
  circle(510, 405, 13);
  circle(515, 405, 8.5);
  circle(503, 399, 7);
  circle(509, 400, 7); 
  circle(514, 402, 7);
  circle(505, 400, 7);
  circle(503, 398, 4);
  circle(498, 406, 8.5);
  circle(500, 404, 8.5);
  circle(498, 408, 8.5);
  circle(493, 408, 7.4);
  circle(489, 407, 7.4);
  circle(489, 407, 7.4);
  circle(487, 406, 7.4);
  circle(486, 405, 7.2);
  circle(484, 406, 7);
  circle(484, 406, 7);
  circle(500, 410, 7);
  circle(458, 377, 7);
  circle(462, 377, 7);
  circle(467, 372, 7);
  circle(469, 376, 7);
  circle(469, 378, 7);
  circle(469, 380, 7);
  circle(471, 380, 7);
  circle(464, 380, 7);
  circle(458, 380, 7);
  circle(458, 383, 7);
  circle(462, 383, 7);
  circle(465, 383, 7);
  circle(471, 382, 7);
  circle(465, 385, 7);
  circle(468, 385, 6);
  circle(465, 387, 6);
  circle(462, 387, 6);
  circle(460, 387, 6);
  circle(461, 389, 6);
  circle(462, 389, 6);
  circle(465, 390, 6);
  circle(462, 390, 6);
  circle(464, 393, 6);
  circle(466, 393, 6);
  circle(469, 392, 6);
  circle(469, 396, 6);
  circle(467, 396, 6);
  circle(471, 399, 6);
  circle(474, 398, 6);
  circle(474, 401, 6);
  circle(479, 402, 7);
}

void keyPressed() {
  //Motor
  if ((key == 'm' || key == 'M') && lMotor == false) {
    motor.play();
    lMotor = true;
  } else if ((key == 'm' || key == 'M') && lMotor == true) {
    motor.stop();
    lMotor = false;
  }

  //Horn
  if ((key == 'b' || key == 'B')) {
    buzina.play();
  }
  
  // headLights
  if ((key == 'f' || key == 'F') && headlight==false) headlight = true;
  else if ((key == 'f' || key == 'F') && headlight==true) headlight = false;
  
  // arrows
  if (keyCode == LEFT && lArrow == false) {
    lArrow = true;
    rArrow = false;
    ArrowDelay = 0;
  }else if (keyCode == LEFT && lArrow == true) {
    lArrow = false;
    ArrowDelay = 0;
  }
  if ( keyCode == RIGHT && rArrow == false) {
    lArrow = false;
    rArrow = true;
    ArrowDelay = 0;
  }else if ( keyCode == RIGHT && rArrow == true) {
    rArrow = false;
    ArrowDelay = 0;
  } 

  // flash alert
  if ((key == 'a' || key == 'A') && rArrow == false && lArrow == false) {
    rArrow = true;
    lArrow = true;
  }else if ((key == 'a' || key == 'A') && rArrow == true && lArrow == true) {
    rArrow = false;
    lArrow = false;
  }
  
  // wipers  
  if((key == 'l' || key == 'L') && wiping == true) wiping = false;
  else if((key == 'l' || key == 'L') && wiping == false) wiping = true;
  
  // Projections
  if((key == 'o' || key == 'O') && orthographic == true) orthographic = false;
  else if((key == 'o' || key == 'O') && orthographic == false) orthographic = true;
  
}

void texts(){
  textSize(18);
  fill(#FFFFFF);
  if(headlight==true) text("Farol Ligado - (f/F)", 10, 30);
  else text("Farol Desligado - (f/F)", 10, 30);
  if(lMotor==true) text("Motor Ligado - (m/M)", 10, 50);
  else text("Motor Desligado - (m/M)", 10, 50);
  if(lArrow==true) text("Seta à Esquerda do Motorista Ligada - (<-)", 10, 70);
  else text("Seta à Esquerda do Motorista Desligada - (<-)", 10, 70);
  if(rArrow==true) text("Seta à Direita do Motorista Ligada - (->)", 10, 90);
  else text("Seta à Direita do Motorista Desligada  - (->)", 10, 90);
  if(rArrow==true && lArrow==true) text("Pisca Alerta Ligado  - (a/A)", 10, 110);
  else text("Pisca Alerta Desligado - (a/A)", 10, 110);
  if(orthographic==true) text("Projeção Ortográfica Ligada - (o/O)", 10, 130);
  else text("Projeção Perspectiva Ligada - (o/O)", 10, 130);
  text("\nMovimento da câmera: \nScroll (controle de distância de visão)\nMouse1 (Câmera) \nMouse2 (Altura da câmera) \n", 10, 150);
}
