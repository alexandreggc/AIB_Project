char titulo[] = {'D', 'o', 'r', 'M', 'i', 'n', 'h', 'o', 'c', 'a'};
int t0 = second();
int count = 1;
int red;
int green;
int blue;

void titulo() {

  int tf = second()-t0;
  
  // reiniciar o sistema de tempo após a passangem de 1 minuto
  if (tf <= 0) {
    t0 = second();
    tf = 1;
    count = 1;
  }
  
  // se passou 1 segundo, entao alteram-se as cores das letras
  if (tf == count) {
    int posLetraX = 260;
    int posLetraY = 170;
    
    // desenhar cada letra com uma cor aleatoria exceto o 'D' e o 'M'
    for (char letra : titulo) {
      if (letra == 'D' || letra == 'M'){
        fill(10, 44, 137);
      }else{
        fill(random(0, 255), random(0, 255), random(0, 255));
      }
      noStroke();
      text(letra, posLetraX, posLetraY);
      posLetraX+=90;
    }
    count += 1;
  
  // se nao passou 1 segundo, entao mantem a cor anterior
  } else {
    fill(red, green, blue);
  }
  
  // prints para ajudar a resolver erros
  println(second());
  println("t0: " + t0);
  println("tf: " + tf);
  println("count: " + count);
}
