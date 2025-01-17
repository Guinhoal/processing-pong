class Pong {
  Agente agente;
  int pontuacao;
  int quadroAtual;
  int quadroUltimaAcao;
  String estadoUltimaAcao;
  int ultimaAcao;

  Pong() {
    jogadorRaquete = new Raquete(20, height / 2, ALTURA_RAQUETE, LARGURA_RAQUETE, VELOCIDADE_RAQUETE);
    bola = new Bola(width / 2, height / 2, RAIO_BOLA, VELOCIDADE_BOLA);
    agente = new Agente(0.1, 0.99, 1.0, 0.01, 0.001);
    reiniciar();
  }

  void reiniciar() {
    jogadorRaquete = new Raquete(35, height / 2, ALTURA_RAQUETE, LARGURA_RAQUETE, VELOCIDADE_RAQUETE);
    oponenteRaquete = new Raquete(width - 35, height / 2, ALTURA_RAQUETE, LARGURA_RAQUETE, VELOCIDADE_RAQUETE);
    bola = new Bola(width / 2, height / 2, 10, VELOCIDADE_BOLA);
    pontuacao = 0;
    fimDeJogo = false;
    quadroAtual = 0;
    quadroUltimaAcao = 0;
    estadoUltimaAcao = obterEstado();
    ultimaAcao = round(random(2));
  }

  String obterEstado() {
    int bolaX = round(map(bola.posicao.x, 0, width, 0, 10));
    int desvio = round(map(bola.posicao.y - jogadorRaquete.posicao.y, 0, height, 0, 20));
    return bolaX + "," + desvio;
  }

  void atualizar() {
    quadroAtual++;
    if (quadroAtual - quadroUltimaAcao >= 0) {
      float recompensa = fimDeJogo ? -100 : acertou ? 50 : min(bola.posicao.x, jogadorRaquete.posicao.x) / max(bola.posicao.x, jogadorRaquete.posicao.x);
      String estadoAtual = obterEstado();
      agente.atualizarQ(estadoUltimaAcao, ultimaAcao, recompensa, estadoAtual);
      ultimaAcao = agente.escolherAcao(estadoAtual);
      jogadorRaquete.velocidade = ultimaAcao == 1 ? -VELOCIDADE_RAQUETE : (ultimaAcao == 2 ? VELOCIDADE_RAQUETE : 0);
      estadoUltimaAcao = estadoAtual;
      quadroUltimaAcao = quadroAtual;
    }
    fimDeJogo = false;
    acertou = false;
    jogadorRaquete.atualizar();
    bola.atualizar();
  }

  void desenhar() {
    bola.atualizar();
    oponenteRaquete.posicao.y = mouseY;
    jogadorRaquete.atualizar();
    bola.mostrar();
    oponenteRaquete.mostrar();
    jogadorRaquete.mostrar();
    fill(255);
    textSize(32);
    text("Pontuação: " + pontuacao, width / 2 - 100, height / 2 + 40);
    text("Média: " + nf(float(total) / pontuacoes.size(), 1, 2), width / 2 - 100, height / 2);
    if (fimDeJogo) text("Fim de Jogo", width / 2, height / 2);
  }
}
