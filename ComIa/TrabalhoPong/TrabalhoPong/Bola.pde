class Bola {
  PVector posicao, velocidade;
  float tamanho;
  int contador, ultimoImpacto;

  Bola(float x, float y, float tamanho, float velocidade) {
    posicao = new PVector(x, y);
    this.velocidade = new PVector(-1, random(-1, 1));
    this.velocidade.mult(velocidade);
    this.tamanho = tamanho;
  }

  void atualizar() {
    contador++;
    posicao.add(velocidade);
    if (posicao.x - (tamanho / 2) <= 0) {
      fimDeJogo = true;
      posicao.x = tamanho / 2;
      velocidade.x *= -1;
    } else if (posicao.x + (tamanho / 2) >= width) {
      posicao.x = width - (tamanho / 2);
      velocidade.x *= -1;
    }
    if (posicao.y - (tamanho / 2) <= 0) {
      posicao.y = tamanho / 2;
      velocidade.y *= -1;
    } else if (posicao.y + (tamanho / 2) >= height) {
      posicao.y = height - (tamanho / 2);
      velocidade.y *= -1;
    }
    if (posicao.y + (tamanho / 2) >= jogadorRaquete.posicao.y - (jogadorRaquete.altura / 2) && posicao.y - (tamanho / 2) <= jogadorRaquete.posicao.y + (jogadorRaquete.altura / 2)) {
      if (posicao.x - (tamanho / 2) <= jogadorRaquete.posicao.x + (jogadorRaquete.largura / 2) && posicao.x + (tamanho / 2) >= jogadorRaquete.posicao.x - (jogadorRaquete.largura / 2)) {
        if (contador - ultimoImpacto >= 50) {
          velocidade.x *= -1;
          float posImpacto = (bola.posicao.y - jogadorRaquete.posicao.y) / jogadorRaquete.altura - 0.5;
          velocidade.y += posImpacto * 1;
          acertou = true;
          pong.pontuacao++;
          ultimoImpacto = contador;
        }
      }
    }
    if (posicao.y + (tamanho / 2) >= oponenteRaquete.posicao.y - (oponenteRaquete.altura / 2) && posicao.y - (tamanho / 2) <= oponenteRaquete.posicao.y + (oponenteRaquete.altura / 2)) {
      if (posicao.x + (tamanho / 2) >= oponenteRaquete.posicao.x + (oponenteRaquete.largura / 2)) {
        velocidade.x *= -1;
      }
    }
  }

  void mostrar() {
    fill(255);
    ellipse(posicao.x, posicao.y, tamanho, tamanho);
  }
}
