float px = 200;
float py = 400;
float dx = 0;
float dy = 0; // balle
float rx = 90;
float ry = 100; // raquette joueur
int etat = 0; // etat du jeu
int point = 0;
int vies = 3; // Ajout du nombre de vies
int temps = 0;
int etape = 0;
float vitesseInitiale = 4.5; // vitesse initiale de la balle
float vitesseBalle = vitesseInitiale;
float difficulte = 1.0; // ajout de la difficulté
int raquetteLargeur = 10;
int raquetteHauteur = 100;
int tempsDebut;
boolean pause = false;

void jeu() // fonction jeu
{
  if (!pause) {
    ry = mouseY; // prise de la position Y de la raquette gauche

    if (px < rx + raquetteLargeur && px > rx && py > ry && py < ry + raquetteHauteur) {
      point++; // ajout de point si la balle touche la raquette
      dx = -dx;
    }

    px = px + vitesseBalle * dx; // utilisation de la vitesse de la balle
    py = py + vitesseBalle * dy;

    background(0, 0, 50);
    fill(50, 150, 50);
    rect(100, 100, 800, 600, 15, 15, 15, 15);
    stroke(255);
    line(500, 100, 500, 700);
    fill(255, 0, 0);
    rect(rx, ry, raquetteLargeur, raquetteHauteur); // joueur gauche en rouge
    fill(0, 0, 255);
    rect(900, py - 50, 10, 100); // le PC joue en bleu
    noStroke();
    fill(255);
    ellipse(px, py, 10, 10); // la balle bouge de dx

    if (px > 900) {
      dx = -dx; // droit
    }
    if (py > 700 || py < 100) {
      dy = -dy; // rebond sur les bords haut et bas
    }
    if (px < 70) {
      px = 200;
      py = 400;
      dx = -dx;
      dy = random(-1, 1);
      vies--; // décrémenter le nombre de vies
      vitesseBalle = vitesseInitiale * difficulte; // réinitialiser la vitesse de la balle avec la difficulté
    }

    fill(0, 255, 0);
    textSize(32);
    text("Points:" + point, 100, 50);
    text("Vies:" + vies, 800, 50);

    if (point < 0) {
      point = 0; // Le joueur ne peut pas avoir un nombre négatif de points
    }

    if (vies <= 0) {
      temps = millis() - tempsDebut;
      noLoop();
      background(0);
      fill(255);
      textSize(76);
      text("Perdu ", 348, 300);
      textSize(24);
      text("Temps écoulé: " + temps / 1000 + " secondes", 300, 400);
      text("Cliquez pour rejouer", 340, 500);
    }
  }
}

void setup() {
  size(1000, 800);
  etat = 0;
}

void draw() {
  if (etat == 0) {
    jeu();
    difficulte += 0.001; // Augmentation progressive de la difficulté
  }

  if (etat == 1) {
    jeu(); // mais on pourrait appeler un autre jeu
  }
}

void mouseClicked() // fonction appelée UNIQUEMENT lorsque l'on clic sur la souris
{
  switch (etat) {
    case 0:
      {
        etat = 1;
        dx = 1; // réinitialisation de la direction
        dy = 1; // réinitialisation de la direction
        vitesseBalle = vitesseInitiale; // réinitialisation de la vitesse
        point = 0; // réinitialisation des points
        vies = 3; // réinitialiser le nombre de vies
        tempsDebut = millis(); // enregistrement du temps de début
        loop();
        pause = false;
        break;
      }
    case 1:
      {
        etat = 0;
        dx = 0;
        dy = 0;
        pause = true;
        difficulte = 1.0; // Réinitialisation de la difficulté
        break;
      }
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    pause = !pause;
  }
}
