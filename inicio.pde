void inicio() {
  println(mouseX, mouseY);
  
  rectMode(RADIUS);
  strokeWeight(7);
  strokeJoin(ROUND);
  
  textFont(fontMenu);
  textSize(50);
  textAlign(CENTER, CENTER);

  // for loop para desenhar os butoes do menu e as correspodentes funcoes
  for (int i = 0; i < 4; i++) {

    // variaveis de posicao e raio dos rectangulos dos butoes que se vao alterando
    // dependente do valor de "i" correspondente a cada butao
    int rectX = (width/2);
    int rectY = 480 + (80*(i+1));
    int rectRaioX = 75 + 50*i;
    int rectRaioY = 30;

    // se o rato estiver am cima do butao correspodente ao valor de "i"
    if ((mouseX>rectX - rectRaioX && mouseX<rectX + rectRaioX &&
      mouseY>rectY - rectRaioY && mouseY<rectY + rectRaioY) ||
      (mouseX >= -0.672*mouseY + 929 &&
      mouseX<=rectX - rectRaioX && mouseX>=rectX - rectRaioX-40 &&
      mouseY>=rectY - rectRaioY && mouseY<=rectY + rectRaioY) ||
      (mouseX <= 0.661*mouseY + 378 &&
      mouseX<=rectX + rectRaioX + 40 && mouseX>=rectX + rectRaioX &&
      mouseY>=rectY - rectRaioY && mouseY<=rectY + rectRaioY)) {

      fill(124, 158, 250);
      stroke(124, 158, 250);

      if (i==0) {
        select0 = true;
        select1=false;
        select2=false;
        select3=false;
      } else if (i==1) {
        select0=false;
        select1 = true;
        select2=false;
        select3=false;
      } else if (i==2) {
        select0=false;
        select1=false;
        select2 = true;
        select3=false;
      } else if (i==3) {
        select0=false;
        select1=false;
        select2=false;
        select3 = true;
      }

      // se o butao correspodente ao valor de "i" for pressionado
      if (mousePressed==true && i==0) {
        opc = 1;
      }
      if (mousePressed==true && i==1) {
        opc = 2;
      }
      if (mousePressed==true && i==2) {
        opc = 3;
      }
      if (mousePressed==true && i==3) {
        opc = 4;
      }

      // se o rato NAO estiver am cima do butao correspodente ao valor de "i"
    } else {

      if (select0 && i==0) {
        select0=false;
      }
      if (select1 && i==1) {
        select1=false;
      }
      if (select2 && i==2) {
        select2=false;
      }
      if (select3 && i==3) {
        select3=false;
      }

      fill(255, 255, 255);
      stroke(255, 255, 255);
    }

    // desenhar os butoes e triangulos
    triangle(rectX - rectRaioX, rectY + rectRaioY, rectX - rectRaioX, rectY - rectRaioY, rectX - rectRaioX - 40, rectY + rectRaioY);
    triangle(rectX + rectRaioX, rectY + rectRaioY, rectX + rectRaioX, rectY - rectRaioY, rectX + rectRaioX + 40, rectY + rectRaioY);
    rect(rectX, rectY, rectRaioX, rectRaioY);

    // texto do butao jogar
    if (select0) {
      fill(255, 255, 255);
    } else {
      fill(10, 44, 137);
    }
    text("Jogar", width/2, 560);

    // texto do butao opcaoes
    if (select1) {
      fill(255, 255, 255);
    } else {
      fill(10, 44, 137);
    }
    text("0pções", width/2, 560 + 80);

    // texto do butao intrucoes
    if (select2) {
      fill(255, 255, 255);
    } else {
      fill(10, 44, 137);
    }
    text("Instruções", width/2, 560 + (80*2));

    // texto do butao sair
    if (select3) {
      fill(255, 255, 255);
    } else {
      fill(10, 44, 137);
    }
    text("Sair", width/2, 560 + (80*3));
    
  }
  
  // desenhar titulo
  textFont(fontTitulo);
  titulo();

  
}
