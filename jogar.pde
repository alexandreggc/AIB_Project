int velocidade = 5;
int direcao = 4;
int[] terreno = {400, 50, 1250, 850};

boolean resetComida = true;
boolean initJogo = true;
int comidaX, comidaY;

ArrayList <PartCorp> corpo = new ArrayList <PartCorp>();


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
//
// **os println's apenas serviram para ajudar a resolver alguns erros**

void jogar() {
  println(mouseX, mouseY);
  ellipseMode(RADIUS);

  if (initJogo) { 
    corpo.add(new PartCorp(10, 10));
    initJogo=false;
  }

  fundo_jogo();
  comida();
  mostrarMinhoca();
}

// funcao para desenhar a animação da minhoca
void mostrarMinhoca() {
  int indereco = corpo.size()-1;
  println("index: " + indereco);
  
  for (int i=0; i<corpo.size(); i++) {
    PartCorp parteInicio = corpo.get(i);
    PartCorp parteFim = corpo.get(indereco);
    corpo.set(i, parteFim);
    corpo.set(indereco, parteInicio);
  }

  corpo.get(0).check_direcao();

  for (int i=0; i<corpo.size(); i++) {
    corpo.get(i).desenhar();
    println("I = " + i + " --> " +corpo.get(i));
  }

  corpo.get(0).check_colisao(comidaX, comidaY, 7);
}

// classe para as partes do corpo da minhoca
class PartCorp {
  int posX, posY, dirc;
  int velocidade = 15;
  int raio = 15;
  boolean colisao;

  PartCorp(int x, int y) {
    posX = x;
    posY = y;
  }

  //desenhar bola
  void desenhar() {
    noStroke();
    fill(0, 126, 67);
    ellipse(posX, posY, raio, raio);
  }

  // verificar se a minhoca está a colidir com a comida
  void check_colisao(int x2, int y2, int raio2) {
    float distnc = sqrt( (posX-x2)*(posX-x2) + (posY-y2)*(posY-y2) );
    
    // se a distancia entre os centros das circunferencias for menor que a soma dos raios
    if (distnc < 0.8*(raio + raio2)) {
      colisao = true;
      resetComida = true;
      int indereco = corpo.size()-1;
      int ultimoX = corpo.get(indereco).posX;
      int ultimoY = corpo.get(indereco).posY;
      
      // adicionar uma parte ao corpo da minhoca consoante a direcao onde esta vai
      if (direcao == 1) {
        corpo.add(new PartCorp(ultimoX, ultimoY+raio));
      }
      if (direcao == 2) {
        corpo.add(new PartCorp(ultimoX, ultimoY-raio));
      }
      if (direcao == 3) {
        corpo.add(new PartCorp(ultimoX+raio, ultimoY));
      }
      if (direcao == 4) {
        corpo.add(new PartCorp(ultimoX-raio, ultimoY));
      }
    }
    println("X, Y: "+ corpo.get(0).posX, corpo.get(0).posY);
    println("ultimo x, y:  "+ corpo.get(corpo.size()-1).posX, corpo.get(corpo.size()-1).posY);
  }

  // verificar a direcao do movimento da minhoca
  void check_direcao() {

    // se o corpo tiver uma só unidade j=0
    int j = 1;
    if (corpo.size() == 1) j = 0;
    
    // se o corpo tiver mais de uma unidade j=1
    int posYCabeca = corpo.get(j).posY;
    int posXCabeca = corpo.get(j).posX;
    
    // atualizar a direcao da proxima parte do corpo da minhoca
    // em relacao a cabeca que estava a conduzir a minhoca
    if (direcao==1) {
      posX = posXCabeca;
      posY = posYCabeca - velocidade;
    }
    if (direcao==2) {
      posX = posXCabeca;
      posY = posYCabeca + velocidade;
    }
    if (direcao==3) {
      posX = posXCabeca - velocidade;
      posY = posYCabeca;
    }
    if (direcao==4) {
      posX = posXCabeca + velocidade;
      posY = posYCabeca;
    }
  }
}

void comida() {

  // se nao houver comida no terreno temos recoloca-la
  if (resetComida) {
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
void fundo_jogo() {
  // fundo verde principal
  rectMode(CORNERS);
  fill(183, 232, 129);
  rect(0, 0, width, height);

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
