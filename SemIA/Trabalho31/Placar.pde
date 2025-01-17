class PlacarWindow extends PApplet {
    public void settings() {
        size(400, 200);  // Defina o tamanho da janela de placar
    }

    public void draw() {
        background(35, 40, 43);  // Cor de fundo do placar
        fill(255);
        textSize(32);
        textAlign(CENTER, CENTER);
        text("Colisões: " + contagemColisoes, width / 2, height / 2);  // Exibe o placar
    }
}
