PFont fontMenu, fontTitulo;
PImage redBall, greenBall;
boolean select0=false;
boolean select1=false;
boolean select2=false;
boolean select3=false;

int opc = 0;

void setup() {
  background(183, 232, 129);
  size(1300, 900);
  frameRate(20);
  
  // carregar imagens
  //redBall = loadImage("img/bola_vermelha.png");
  //greenBall = loadImage("img/bola_verde.png");
  
  // fontes de texto
  fontMenu = loadFont("OCRAExtended-48.vlw");
  fontTitulo = loadFont("Monospaced.bold-130.vlw");
}

void draw(){
  println("valor de i "+opc);
  if (opc==0) inicio();
  if (opc==1) jogar();
  if (opc==2) opcoes();
  if (opc==3) instrucoes();
  if (opc==4) exit();
}

void fundo(){
  rectMode(CORNERS);
  fill(183, 232, 129);
  rect(0,0,width,height);
}
