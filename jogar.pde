int tempDelay = 85;
int direcao = 4;
int direcaoAtual = direcao;
int energia=0;
int boca;
int contadorCores=0;
boolean dormir=true;

int melhorPontuacao = 0;
boolean recorde;
int[] terreno = {430, 30, 1270, 870};

char redbull[] = {'R', 'e', 'd', 'B', 'u', 'l', '1'};
int count2 = 1;

boolean gameover = false;
boolean initJogo = true;

boolean resetComida = true;
int comidaX, comidaY;
boolean resetBebida = true;
boolean efeito = false;
boolean Eja = false;
boolean Bja = false;
int bebidaX=0, bebidaY=0, rd;

Relogio relogioJogo = new Relogio("jogo");
Relogio crono = new Relogio("");

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
  println(contadorCores+"        c efew fw fwea");
  println(mouseX, mouseY);
  ellipseMode(RADIUS);
  rectMode(RADIUS);

  if (initJogo) { 
    corpo.clear();
    corpo.add(new PartCorp(445, 75));
    contadorCores=0;
    energia=0;
    direcaoAtual=4;
    direcao=4;
    tempDelay = 85;
    resetBebida = true;
    resetComida = true;
    Bja = false;
    Eja = false;
    efeito = false;
    if(!dormir){
      relogioJogo.comecar();
      relogioJogo.comecaTemp = false;
      bebidaX=0;
      crono.comecar();
      crono.comecaTemp = false;
      initJogo=false;
    } else {
      fundo_jogo();
      pontuacao();
      mostrarMinhoca();
      noStroke();
      fill(124, 158, 250);
      rectMode(RADIUS);
      rect(210, 350, 200, 40, 15);
      fill(10, 44, 137);
      textSize(40);
      textAlign(LEFT, CENTER);
      text("Tempo >> 0:0", 30, 350);
      initJogo = true;
    }
  }
  
  if (gameover){
    dormir=true;
    fundo_jogo();
    relogioJogo.para();
    for (PartCorp part : corpo) {
      if(contadorCores>corpo.size()-1 || contadorCores>coresCorpo.length-1) contadorCores=0;
      fill(coresCorpo[contadorCores]);
      part.desenhar();
      boca=1;
      cabeca();
      contadorCores+=1;
    }
    comida();
    bebida();
    pontuacao();
    butao("Jogar Novamente", 215, 750);
    butao("Voltar", 100, 840);
    if (opc==1){
      textSize(100);
      fill(10, 44, 137);
      text("GAME OVER", 854, 456);
    }  
    
  }else{
    if (!dormir){
      fundo_jogo();
      pontuacao();
      relogioJogo.atualizar();
      crono.atualizar();
      comida();
      bebida();
      mostrarMinhoca();
    }
  }
}

//--------funcao para interacao e desenho da animação da minhoca---------

void mostrarMinhoca() {
  rectMode(RADIUS);
  int indereco = corpo.size()-1;
  println("index: " + indereco);

  for (int i=0; i<corpo.size(); i++) {
    PartCorp parteInicio = corpo.get(i);
    PartCorp parteFim = corpo.get(indereco);
    corpo.set(i, parteFim);
    corpo.set(indereco, parteInicio);
  }
  
  if (!dormir){
    filtar_direcao();
    corpo.get(0).check_direcao();
    corpo.get(0).check_colisao(comidaX, comidaY, 7, "maca");
    corpo.get(0).check_colisao(bebidaX, bebidaY, 10, "redbull");
    corpo.get(0).check_paredes();
    corpo.get(0).check_corpo();
  
    for (PartCorp part : corpo) {
      if(contadorCores>corpo.size()-1 || contadorCores>coresCorpo.length-1) contadorCores=0;
      fill(coresCorpo[contadorCores]);
      part.desenhar();
      cabeca();
      contadorCores+=1;
    }
  }else{
    for (PartCorp part : corpo) {
      if(contadorCores>corpo.size()-1 || contadorCores>coresCorpo.length-1) contadorCores=0;
      fill(coresCorpo[contadorCores]);
      part.desenhar();
      imageMode(CENTER);
      image(dormindo, corpo.get(0).posX+10, corpo.get(0).posY);
      textFont(fontMenu);
      textSize(40);
      textAlign(CENTER, CENTER);
      fill(10, 44, 137);
      text("Prima a tecla ENTER", 854, 456);
      text("para acordar a DorMinhoca", 854, 520);
      contadorCores+=1;
    }
  }
  delay(tempDelay);
  boca=0;
}

//-----------funcao para desenhar a cabeca da minhoca-----------

void cabeca(){
  imageMode(CORNER);
  if (direcao==1){
    image(cabeca1.get(boca), corpo.get(0).posX-50, corpo.get(0).posY-60);
  }
  else if (direcao==2){
    image(cabeca2.get(boca), corpo.get(0).posX-50, corpo.get(0).posY-50);
  }
  else if (direcao==3){
    image(cabeca3.get(boca), corpo.get(0).posX-60, corpo.get(0).posY-50);
  }
  else if (direcao==4){
    image(cabeca4.get(boca), corpo.get(0).posX-40, corpo.get(0).posY-50);
  }
}

//-----------classe para as partes do corpo da minhoca-----------

class PartCorp {
  int posX, posY;
  int raio = 15;
  int passos=2*raio;
  boolean conct;

  PartCorp(int x, int y) {
    posX = x;
    posY = y;
  }

  //---------------desenhar a parte do corpo da minhoca----------------
  
  void desenhar() {
    rectMode(RADIUS);
    noStroke();
    rect(posX, posY, raio, raio);
  }
  
  //--------verificar se a minhoca está a colidir consigo propria-------
  
  void check_corpo(){
    for(int i=0; i<corpo.size(); i++){
      if (posX==corpo.get(i).posX && posY==corpo.get(i).posY && i!=0){
        gameoverSom.play();
        gameover=true;
        boca=1;
      }
    }
  }
  
  //--------verificar se a minhoca está a colidir com as paredes--------
  
  void check_paredes(){
    if (posX>terreno[2] || posX<terreno[0] || posY>terreno[3] || posY<terreno[1]){
      gameoverSom.amp(0.5);
      gameoverSom.play();
      gameover=true;
      boca=1;
    }
  }

  //---------verificar se a minhoca está a colidir com objetos---------
  
  void check_colisao(int x2, int y2, int raio2, String objeto) {
    float distnc = sqrt( (posX-x2)*(posX-x2) + (posY-y2)*(posY-y2) );
    // se a distancia entre os centros das circunferencias for menor que a soma dos raios
    if (distnc < 0.9*(raio + raio2)) {
      boca = 1;
      int ultimoX = corpo.get(0).posX;
      int ultimoY = corpo.get(0).posY;

      // adicionar uma parte ao corpo da minhoca consoante a direcao onde esta vai
      if(contadorCores>coresCorpo.length-1)contadorCores=0;
      
      if (direcao == 1) {
        corpo.add(new PartCorp(ultimoX, ultimoY+passos));
      }
      if (direcao == 2) {
        corpo.add(new PartCorp(ultimoX, ultimoY-passos));
      }
      if (direcao == 3) {
        corpo.add(new PartCorp(ultimoX+passos, ultimoY));
      }
      if (direcao == 4) {
        corpo.add(new PartCorp(ultimoX-passos, ultimoY)); 
      }
      
      if(objeto=="maca"){
        macaSom.play();
        energia+=3;
        if(!efeito) tempDelay-=1;        
        resetComida = true;
      }
      if(objeto=="redbull"){
        if(!resetBebida && !efeito){
          bebidaSom.play();
          backgroundSom.pause();
          efeitoSom.play();
          energia+=10;
          efeito=true;
          resetBebida = true;
        }else boca=0;
      }
    }
    
  }

  //----------verificar a direcao do movimento da minhoca-----------
  
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
      posY = posYCabeca - passos;
    }
    if (direcao==2) {
      posX = posXCabeca;
      posY = posYCabeca + passos;
    }
    if (direcao==3) {
      posX = posXCabeca - passos;
      posY = posYCabeca;
    }
    if (direcao==4) {
      posX = posXCabeca + passos;
      posY = posYCabeca;
    }
  }
}

//--------------funcao para mostrar a comida-------------

void comida() {

  // se nao houver comida no terreno temos recoloca-la
  if (resetComida) {
    int fatorX = int(random(0,27));
    int fatorY = int(random(0,27));
    comidaX = (terreno[0] + fatorX*30 + 15);
    comidaY = (terreno[1] + fatorY*30 + 15);
    resetComida=false;
  }

  // desenhar a comida
  imageMode(CENTER);
  image(maca, comidaX, comidaY);
  
}

//--------------funcao para mostrar a bebida-------------

void bebida() {

  // se nao houver bebida no terreno temos recoloca-la num prazo de 10-15s
  if (resetBebida) {
    if(!Bja){
      rd = int(random(10,15));
      Bja = true;
    }
    relogioJogo.contar(rd);
    if(relogioJogo.acabouTemp){
      if(bebidaX!=0)bebidaX=comidaX; bebidaY=comidaY;
      while(bebidaX == comidaX || bebidaY == comidaY){
        int fatorX = int(random(0,27));
        int fatorY = int(random(0,27));
        bebidaX = (terreno[0] + fatorX*30 + 15);
        bebidaY = (terreno[1] + fatorY*30 + 15);
      }
      relogioJogo.acabouTemp = false;
      resetBebida=false;
      Bja=false;
    }
  }
  efeitoEnerg(); 
  
  // desenhar a comida
  if (!resetBebida){
    imageMode(CENTER);
    fill(23,132,12);
    image(bebida, bebidaX, bebidaY);
  } 
}

//------------funcao para efeito da bebida na minhoca-----------

void efeitoEnerg(){
  if (efeito){
    if(!Eja){
      tempDelay = tempDelay/2;
      Eja = true;
    }
    crono.contar(5);
    redbull_anim();
    if (crono.acabouTemp){
      Eja = false;
      efeito = false;
      tempDelay = tempDelay*2;
      crono.acabouTemp = false;
      backgroundSom.loop();
    }
  }
}

//----------funcao para definir o valor da direcao--------
//---------------a cada movimento da minhoca--------------

void filtar_direcao() {
  if (direcao == 1 || direcao == 2) {
    if (direcaoAtual == 3) {
      direcao = 3;
    } else if (direcaoAtual == 4) {
      direcao = 4;
    }
  } else if (direcao == 3 || direcao == 4) {
    if (direcaoAtual == 1) {
      direcao = 1;
    } else if (direcaoAtual == 2) {
      direcao = 2;
    }
  }
}

//-----------funcao para o controlo da minhoca-----------
//-------------atraves das setas do teclado--------------
void keyPressed() {
  if (opc ==1) {
    if (keyCode == UP) {
      direcaoAtual = 1;
    } else if (keyCode == DOWN) {
      direcaoAtual = 2;
    } else if (keyCode == LEFT) {
      direcaoAtual = 3;
    } else if (keyCode == RIGHT) {
      direcaoAtual = 4;
    } else if (keyCode == ENTER) {
      dormir = false;
    }
  }
}

//------------funcao para a pontucao do jogador-----------
void pontuacao(){
  textFont(fontMenu);
  textSize(40);
  textAlign(LEFT, CENTER);
  noStroke();
  fill(245, 111, 111);
  rectMode(RADIUS);
  rect(210, 250, 200, 40, 15);
  fill(10, 44, 137);
  text("Energia >> " + energia, 30,250);
  
  int pontos = (relogioJogo.tempoSeg * energia)/10;
  noStroke();
  fill(249, 250, 3);
  rectMode(RADIUS);
  rect(210, 100, 200, 50, 15);
  fill(10, 44, 137);
  text("Pontuação: " + pontos, 30,100);
  
  if(gameover){
    if(melhorPontuacao>pontos) {
      recorde = false;
    } else if(melhorPontuacao<pontos) {
      recorde = true;
      if(melhorPontuacao == 0) melhorPontuacao = pontos;
      melhorPontuacao = pontos;
    }
    if (recorde){
      textSize(40);
      fill(10, 44, 137);
      textAlign(CENTER, CENTER);
      text("Novo Recorde: " + pontos, 854, 550);
    } else {
      textSize(40);
      fill(10, 44, 137);
      textAlign(CENTER, CENTER);
      text("Pontuação: " + pontos, 854, 550);
      text("Melhor Pontução: " + melhorPontuacao, 854, 600);
    }
  }
}


void redbull_anim(){
  textSize(40);
  textAlign(LEFT, CENTER);
  noStroke();
  int posLetraX = 50;
  int posLetraY = 510;
  
  // desenhar cada letra com a sua cor
  if(opc==1 && !gameover){
    for (char letra : redbull) {
      if (count2%2==0){
        if (letra == 'R' || letra == 'd' || letra == 'u' || letra == '1'){
          fill(0, 0, 255);
          noStroke();
          text(letra, posLetraX, posLetraY);
        }else if (letra == 'e' || letra == 'B' || letra == 'l') {
          fill(255);
          noStroke();
          text(letra, posLetraX, posLetraY);
        }
      }
      
      if (count2%2!=0){
        if (letra == 'e' || letra == 'B' || letra == 'l'){
          fill(0, 0, 255);
          noStroke();
          text(letra, posLetraX, posLetraY);
        }else if (letra == 'R' || letra == 'd' || letra == 'u' || letra == '1') {
          noStroke();
          fill(255);
          text(letra, posLetraX, posLetraY);
        }
      }
      println(count2%2);
      posLetraX+=50;
    }
    count2 += 1;
  }else{
    efeitoSom.stop();
  }
}


//----------funcao para desenhar o fundo do jogo----------

void fundo_jogo() {
  
  // fundo verde principal
  noStroke();
  rectMode(CORNERS);
  fill(183, 232, 129);
  rect(0, 0, width, height);

  // terreno da minhoca
  strokeWeight(3);
  stroke(165, 95, 52);
  fill(224, 200, 177);
  rect(terreno[0], terreno[1], terreno[2], terreno[3]);
  
}
