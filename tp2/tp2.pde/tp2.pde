PImage[] fondos = new PImage[7]; 
String[] textos = {
  "Percy Jackson y el ladrón del rayo",
  "Descubrimiento de su identidad\n\nPercy Jackson, un chico con dislexia\n y problemas de conducta,\ndescubre que es un semidiós, hijo de Poseidón,\n y que la mitología griega es real.",
  "Ataque y llegada al Campamento Mestizo\n\nTras ser atacado por criaturas mitológicas,\n Percy llega al Campamento Mestizo,\nun refugio para hijos de dioses, donde entrena\n y conoce a Annabeth y Grover.",
  "Enfrentamientos y descubrimientos\n\nEn su viaje, Percy enfrenta monstruos y trampas,\n y descubre más sobre su pasado y\n las tensiones entre los dioses.",
  "La misión\n\nAcusado de robar el rayo de Zeus,\n Percy parte en una misión\n para probar su inocencia\n y evitar una guerra entre los dioses.",
  "El verdadero ladrón\n\nDescubren que Luke, hijo de Hermes,\n robó el rayo para iniciar una guerra.\n Percy lo recupera y lo devuelve a Zeus.",
  "Datos del libro\n\nEscrito por Rick Riordan y lanzado en 2005,\n vendió más de 20 millones de copias\n e inició la saga\n Percy Jackson y los dioses del Olimpo."
};

int[] tiemposPorPantalla = {4000, 9000, 9000, 9000, 9000, 9000, 9000};

int pantalla = 0;
int tiempoUltimoCambio;
int tiempoEscritura;

PFont fuente;

float alphaTexto = 0;
boolean efectoIniciado = false;

int letraIndex = 0;
int velocidadEscritura = 100;

float posX;
float posY;
float velocidad = 2;

float scrollY;
float reboteOffset = 0;
float reboteVelocidad = 0.5;
boolean reboteSubiendo = true;
boolean reboteTerminado = false;

float sombraAlpha = 150;
boolean sombraReduciendo = true;

int botonX, botonY, botonW, botonH;
color celeste = color(100, 200, 255);

void setup() {
  size(640, 480);
  fuente = createFont("Arial Black", 23);
  textFont(fuente);

  for (int i = 0; i < 7; i++) {
    fondos[i] = loadImage("PANTALLA " + (i + 1) + ".jpg");
  }

  tiempoUltimoCambio = millis();
  tiempoEscritura = millis();
  posY = height / 2;
  posX = width + 50;

  botonW = 140;
  botonH = 40;
  botonX = width - botonW - 20;
  botonY = height - botonH - 20;
}

void draw() {
  background(255);
  image(fondos[pantalla], 0, 0, width, height);
  textAlign(CENTER, CENTER);
  textFont(fuente);

  if (pantalla == 0) {
    if (!efectoIniciado) {
      alphaTexto = 0;
      efectoIniciado = true;
    }
    if (alphaTexto < 255) alphaTexto += 4;
    fill(0, alphaTexto);
    text(textos[0], width / 2, height / 1.3);
  }

  else if (pantalla == 1) {
    fill(186, 20, 20);
    if (!efectoIniciado) {
      letraIndex = 0;
      efectoIniciado = true;
      tiempoEscritura = millis();
    }
    if (letraIndex < textos[1].length()) {
      if (millis() - tiempoEscritura > velocidadEscritura) {
        letraIndex++;
        tiempoEscritura = millis();
      }
    }
    String textoActual = textos[1].substring(0, letraIndex);
    text(textoActual, width / 2, height / 2);

    if (letraIndex == textos[1].length() && millis() - tiempoEscritura > 2000) {
      pantalla++;
      tiempoUltimoCambio = millis();
      efectoIniciado = false;
    }
  }

  else if (pantalla == 2) {
    fill(186, 20, 20);
    if (!efectoIniciado) {
      posX = width + 50;
      posY = height / 2;
      efectoIniciado = true;
    }
    if (posX > width / 2) {
      posX -= velocidad;
    }
    text(textos[2], posX, posY);
  }

  else if (pantalla == 3) {
    fill(186, 20, 20);
    if (!efectoIniciado) {
      reboteOffset = 0;
      reboteVelocidad = 0.5;
      reboteSubiendo = true;
      reboteTerminado = false;
      efectoIniciado = true;
    }
    if (!reboteTerminado) {
      if (reboteSubiendo) {
        reboteOffset -= reboteVelocidad;
        if (reboteOffset <= -15) reboteSubiendo = false;
      } else {
        reboteOffset += reboteVelocidad;
        if (reboteOffset >= 0) reboteTerminado = true;
      }
    }
    text(textos[3], width / 2, height / 2 + reboteOffset);
  }

  else if (pantalla == 4) {
    fill(186, 20, 20);
    if (!efectoIniciado) {
      scrollY = height + 50;
      efectoIniciado = true;
    }
    if (scrollY > height / 2) {
      scrollY -= 1.5;
    }
    text(textos[4], width / 2, scrollY);
  }

 else if (pantalla == 5) {
  if (!efectoIniciado) {
    efectoIniciado = true;
  }

  String[] lineas = textos[5].split("\n");
  float y = height / 2 - ((lineas.length - 1) * 30) / 2;

  for (int l = 0; l < lineas.length; l++) {
    String linea = lineas[l];
    float anchoTotal = textWidth(linea);
    float anchoLetraPromedio = anchoTotal / linea.length();
    float x = width / 2 - (anchoTotal / 2);
    float letraX = x;

    for (int i = 0; i < linea.length(); i++) {
      char c = linea.charAt(i);
      float r = map(i, 0, linea.length(), 186, 255);
      float g = map(i, 0, linea.length(), 20, 150);
      float b = map(i, 0, linea.length(), 20, 0);
      fill(r, g, b);
      text(c, letraX, y + l * 30);
      letraX += anchoLetraPromedio; 
    }
  }
}

  
  else if (pantalla == 6) {
    if (sombraReduciendo) {
      sombraAlpha -= 1;
      if (sombraAlpha <= 50) sombraReduciendo = false;
    } else {
      sombraAlpha += 1;
      if (sombraAlpha >= 150) sombraReduciendo = true;
    }

    fill(0, sombraAlpha);
    text(textos[6], width / 2 + 2, height / 2 + 2);

    fill(186, 20, 20);
    text(textos[6], width / 2, height / 2);

    fill(celeste);
    rect(botonX, botonY, botonW, botonH, 10);
    fill(0);
    textSize(18);
    text("Reiniciar", botonX + botonW / 2, botonY + botonH / 2);
    textSize(23);
  }

  if (pantalla != 1 && pantalla != 6 && millis() - tiempoUltimoCambio > tiemposPorPantalla[pantalla]) {
    pantalla++;
    tiempoUltimoCambio = millis();
    efectoIniciado = false;
    letraIndex = 0;
  }
}

void mousePressed() {
  if (pantalla == 6) {
    if (mouseX > botonX && mouseX < botonX + botonW &&
        mouseY > botonY && mouseY < botonY + botonH) {
      pantalla = 0;
      tiempoUltimoCambio = millis();
      efectoIniciado = false;
      letraIndex = 0;
    }
  }
}
