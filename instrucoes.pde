void instrucoes(){
  println(mouseX, mouseY);
  fundo();
  butao("Voltar", 130, 840);
  textFont(fontMenu);
  textSize(50);
  textAlign(CENTER, CENTER);
  rectMode(RADIUS);
  
  fill(255);
  rect(650, 60, 160, 40);
  noStroke();
  fill(10, 44, 137);
  rect(168, 750, 90, 20, 15);
  
  fill(10, 44, 137);
  text("Instruções", 650, 60);
  
  textFont(fontMenu);
  textSize(30);
  textAlign(LEFT,CENTER);
  
  text("O objetivo do jogo é conseguir apanhar o maior numero de RedBull's ", 50, 150);
  text("e maçãs para aumentar a         captada pela DorMinhoca, no menor ", 50, 200);
  text("      possível.", 50, 250);
  
  text("Ao longo de uma sessão de jogo, a velocidade da DorMinhoca vai ", 50, 350);
  text("aumentando à medida que esta come mais maçãs. ", 50, 400);
  text("Quando a DorMinhoca bebe um RedBull a sua velocidade aumenta para o  ", 50, 450);
  text("dobro durante 5 segundos, porém durante este tempo, as maçãs ", 50, 500);
  text("ingeridas não afetaram a sua velocidade. ", 50, 550);
  
  
  text("Cada maçã ingerida dá 3 pontos de        .", 50, 630);
  text("Cada RedBull ingerido dá 10 pontos de        .", 50, 680);
  
  text("A           é uma relação entre os pontos de         e o       gasto.", 50, 750);
  text("Utiliza as setas do teclado para controlar a DorMinhoca.", 270, 830);
  
  stroke(255);
  line(270,850,1280,850);
  noStroke();
  
  fill(245, 111, 111);
  text("Energia", 485, 200);
  text("Energia", 667, 630); 
  text("Energia", 740, 680);
  text("Energia", 867, 750); 
  fill(124, 158, 250);
  text("Tempo", 51, 250); 
  text("Tempo", 1085, 750); 
  fill(249, 250, 3);
  text("Pontuação", 86, 750);
  
  if (opc==0) fundo();

}
