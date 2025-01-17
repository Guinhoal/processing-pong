class Raquete {
  PVector posicao;
  float velocidade;
  float altura, largura;

  Raquete(float x, float y, float altura, float largura, float velocidade) {
    posicao = new PVector(x, y);
    this.altura = altura;
    this.largura = largura;
    this.velocidade = velocidade;
  }

  void atualizar() {
    if (posicao.y - (altura / 2) <= 0) posicao.y = altura / 2;
    else if (posicao.y + (altura / 2) >= height) posicao.y = height - (altura / 2);
    posicao.y += velocidade;
  }

  void mostrar() {
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(posicao.x, posicao.y, largura, altura);
  }
}
