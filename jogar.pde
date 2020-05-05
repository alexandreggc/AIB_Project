int velocidade = 5;
int direcao = 4;
int[] terreno = {400, 50, 1250, 850};

boolean resetComida = true;
int comidaX, comidaY;

Minhoca minhc = new Minhoca(10, 10);

//---------ESQUEMA DE CODIGOS DE DIRECAO-----------
// 
//                     direcao = 1
//                        cima
//      direcao = 3                  direcao = 4
//         esq                           dir
//                     direcao = 2
//                        baixo
//
//-------------------------------------------------

void jogar() {
  println(mouseX, mouseY);
  ellipseMode(RADIUS);
  
  fundo_jogo();
  comida();
  minhc.desenhar();
  minhc.check_direcao();
  minhc.check_collisao(comidaX, comidaY, 7);
}

// classe para a minhoca e as partes do corpo dela
class Minhoca{
  int posX , posY, dirc;
  int velocidade = 5;
  int tamh = 15;
  boolean colisao;
  
  Minhoca(int x, int y){
    posX = x;
    posY = y;
  }
  
  //desenhar bola
  void desenhar(){    
    noStroke();
    fill(0, 126, 67);
    ellipse(posX, posY, tamh, tamh);
  }
  
  // verificar se a minhoca está a colidir com a comida
  void check_collisao(int x2, int y2, int raio){
    float distnc = sqrt( (posX-x2)*(posX-x2) + (posY-y2)*(posY-y2) );
    if (distnc < 0.8*(tamh + raio)){
      colisao = true;
      resetComida = true;
    }
  }
  
  // verificar a direcao do movimento da minhoca
  void check_direcao(){
    dirc = direcao;
    if (direcao==1) { 
      posY-=velocidade;   
    }
    if (direcao==2) {
      posY+=velocidade;
    }
    if (direcao==3) {
      posX-=velocidade;
    }
    if (direcao==4) {
      posX+=velocidade;
    }
  }
}

void comida(){
  
  // se nao houver comida no terreno temos recoloca-la
  if (resetComida){
    comidaX = int(random(terreno[0], terreno[2]));
    comidaY = int(random(terreno[1], terreno[3]));
    resetComida=false;
  }
  
  // desenhar a comida
  fill(255, 0, 0);
  ellipse(comidaX, comidaY, 7, 7);
}

// funcao para o controlo da minhoca atraves das setas do teclado
void keyPressed() {
  if (opc ==1) {
    if (key == CODED) {
      if (keyCode == UP) {
        direcao = 1;
      } else if (keyCode == DOWN) {
        direcao = 2;
      } else if (keyCode == LEFT) {
        direcao = 3;
      } else if (keyCode == RIGHT) {
        direcao = 4;
      }
    }
  }
}

// funcao para desenhar o fundo do jogo
void fundo_jogo(){
  // fundo verde principal
  rectMode(CORNERS);
  fill(183, 232, 129);
  rect(0,0,width,height);
  
  // terreno da minhoca
  fill(224, 200, 177);
  rect(terreno[0], terreno[1], terreno[2], terreno[3]);
}

// codigo para intercalar as bolas coloridas
//
//for (int j=0; j < 20; j++){
//    if (j%2 == 0){
//      image(redBall, 75*j, 50);
//    }else{
//      image(greenBall, 75*j, 50);
//    }
//  }
