final int LARGURA_RAQUETE = 20;
final int ALTURA_RAQUETE = 80;
final float VELOCIDADE_RAQUETE = 3;
final float VELOCIDADE_BOLA = 5;
final float RAIO_BOLA = 40;
final int SIMULACOES = 10000000;

Raquete jogadorRaquete;
Raquete oponenteRaquete;
Bola bola;
Pong pong;

int total;
int pontuacaoMax;
boolean fimDeJogo, acertou;
ArrayList<Integer> pontuacoes;

int pontosTemporarios = 1;
int simulacaoAtual = 0;
boolean emEspera = true;
boolean mostrarObjetos = true;

float calculaModulo(float x) {
  return (float) Math.sqrt(x * x);
}

void simularPartidas() {
  pong = new Pong();
  pontuacoes = new ArrayList<Integer>();
  mostrarObjetos = false;
  for (int i = 0; i < SIMULACOES; i++) {
    if (!emEspera) return;
    pong.atualizar();
    if (fimDeJogo) {
      pong.atualizar();
      pontuacoes.add(pong.pontuacao);
      total += pong.pontuacao;
      pontuacaoMax = max(pontuacaoMax, pong.pontuacao);
      pong.reiniciar();
    }
    simulacaoAtual = i;
  }
  delay(4000);
  mostrarObjetos = true;
  emEspera = false;
}

void keyReleased() {
  if (key == 'w') {
      emEspera = false;
      delay(50);
      setup();
  }
  if (key == 'q') {
      pong.reiniciar();
  }
}

void setup() {
  size(800, 450);
  surface.setTitle("HojeTemMengao");
  emEspera = true;
  thread("simularPartidas");
}

void draw() {
  if (emEspera) {
    pontosTemporarios += (pontosTemporarios < 50) ? 1 : -50;
  } else {
    background(120, 48, 150);
    pong.atualizar();
    pong.desenhar();
    if (fimDeJogo) {
      pong.atualizar();
      pontuacoes.add(pong.pontuacao);
      pontuacaoMax = max(pontuacaoMax, pong.pontuacao);
      pong.reiniciar();
    }
  }
}
