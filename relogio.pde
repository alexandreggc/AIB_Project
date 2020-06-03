class Relogio{
  String tipo;
  int tempoSeg, tempo1_jogo, t0;
  int[] tempo2_jogo = new int[2];
  int[] tempoAtual_jogo = new int[2];
  boolean acabouTemp = false;
  boolean comecaTemp = false;
  
  Relogio(String tp){
    tipo = tp;
  }
  
  void comecar(){
    tempo1_jogo = minute()*60 + second();
  }
  
  void para(){
    noStroke();
    fill(124, 158, 250);
    rectMode(RADIUS);
    rect(210, 350, 200, 40, 15);
    int tempoF = tempoAtual_jogo[1]*60 + tempoAtual_jogo[0];
    fill(10, 44, 137);
    textSize(40);
    textAlign(LEFT, CENTER);
    text("Tempo >> " + tempoAtual_jogo[1] + ":" + tempoAtual_jogo[0], 30, 350);
  }
  
  void atualizar(){
    tempoAtual_jogo[1] = ((minute()*60 + second()) - tempo1_jogo) / 60;
    tempoAtual_jogo[0] = ((minute()*60 + second()) - tempo1_jogo) - (tempoAtual_jogo[1]);
    tempoAtual_jogo[0]-=59*tempoAtual_jogo[1];
    if (tipo == "jogo"){
      textFont(fontMenu);
      textSize(40);
      textAlign(LEFT, CENTER);
      
      noStroke();
      fill(124, 158, 250);
      rectMode(RADIUS);
      rect(210, 350, 200, 40, 15);
      
      fill(10, 44, 137);
      text("Tempo >> " + tempoAtual_jogo[1] + ":" + tempoAtual_jogo[0], 30, 350);
    }
    tempoSeg = tempoAtual_jogo[1]*60 + tempoAtual_jogo[0];
    
  }
    
  void contar(int tmp){
    tempoSeg = tempoAtual_jogo[1]*60 + tempoAtual_jogo[0];
    if (!comecaTemp){
      t0 = tempoAtual_jogo[1]*60 + tempoAtual_jogo[0];
      comecaTemp = true;
    }
    if (tempoSeg - t0 >= tmp){
      acabouTemp = true;
      comecaTemp = false;
    }
  }
}
