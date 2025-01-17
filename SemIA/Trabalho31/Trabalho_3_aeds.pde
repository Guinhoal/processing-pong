int width = 1300;
int height = 720;
int margem = 20;
Paddle p1;
PVector direcao;
PVector mouse;
Ball b1;
int opt;
int contagemColisoes = 0;
boolean pausado = false;
QLearning q;


//customização para menu de opções
int corBotaoNormal = color(200);
int corBotaoHover = color(100, 200, 100);
int corTexto = color(0);
int corFundo = color(35, 40, 43);


void setup(){
    frameRate(80);
    surface.setTitle("Pong");
    size (1300, 720);
    background(#23282B);

    desenhaBorda();

    //Paddle
    p1 = new Paddle(70 + margem, 70 + margem, 20, 100);
    b1 = new Ball((width/2 + margem), (height/2 + margem), 15);
    
    //direcao = new PVector(0, 0); 

     q = new QLearning(0.1f, 0.9f, 0.1f);

    // Treina a IA com um número de iterações
    q.treinar(b1, p1, 100000);  // Ajuste o número de iterações conforme necessário

    opt = 0;
      new Thread(new Runnable() {
        public void run() {
            String[] args = {"Placar"};
            PApplet.runSketch(args, new PlacarWindow());
        }
    }).start();
    //Thead para atualizar o placar, este placar vai ficar em outra tela
}
void desenhaBorda(){
    //Borda 
    stroke(#FCFAFA);
    strokeWeight(10);
    noFill();
    rect(margem / 2, margem / 2, width - margem, height - margem);
}

//Não foi bem utilizado, não será necessário o mouse segue o paddle de outra forma
/*
void descobreDirecao(){
    mouse = new PVector(mouseX, mouseY);
    direcao = PVector.sub(mouse, p1.pos);
    direcao.normalize();
    direcao.mult(5); 
}
*/

void telaOpcao() {
    background(corFundo);
    
    textAlign(CENTER);
    textSize(36);
    fill(255);
    text("Escolha uma opção", width / 2, height / 3);
    
    // Botão Jogar
    if (mouseSobreBotao(width / 2 - 150, height / 2 - 50, 300, 50)) {
      // Caso o mouse esteja em cima
        fill(corBotaoHover); 
    } else {
        fill(corBotaoNormal); 
    }
    desenhaBotao(width / 2 - 150, height / 2 - 50, 300, 50, "Jogar");
    
    // Botão IA Jogando
    if (mouseSobreBotao(width / 2 - 150, height / 2 + 50, 300, 50)) {
      // Caso o mouse esteja em cima
      
        fill(corBotaoHover);
    } else {
        fill(corBotaoNormal);
    }
    desenhaBotao(width / 2 - 150, height / 2 + 50, 300, 50, "IA Jogando");
}

void telaPause() {
    background(corFundo);
    
    textAlign(CENTER);
    textSize(36);
    fill(255);
    text("Jogo Pausado", width / 2, height / 3);
    
    textSize(24);
    text("Placar: " + contagemColisoes, width / 2, height / 2 - 200);
    
    if (mouseSobreBotao(width / 2 - 150, height / 2 - 50, 300, 50)) {
        fill(corBotaoHover);
    } else {
        fill(corBotaoNormal);
    }
    desenhaBotao(width / 2 - 150, height / 2 - 50, 300, 50, "Continuar");
    
    if (mouseSobreBotao(width / 2 - 150, height / 2 + 50, 300, 50)) {
        fill(corBotaoHover);
    } else {
        fill(corBotaoNormal);
    }
    desenhaBotao(width / 2 - 150, height / 2 + 50, 300, 50, "Sair");
}

void telaDerrota(){
    background(corFundo);

    textAlign(CENTER);
    textSize(36);
    fill(255);
    text("Você perdeu!", width / 2, height / 3);

    // Botão Reiniciar
    if (mouseSobreBotao(width / 2 - 150, height / 2 - 50, 300, 50)) {
        fill(corBotaoHover);
    } else {
        fill(corBotaoNormal);
    }
    desenhaBotao(width / 2 - 150, height / 2 - 50, 300, 50, "Reiniciar");

    // Botão Sair
    if (mouseSobreBotao(width / 2 - 150, height / 2 + 50, 300, 50)) {
        fill(corBotaoHover);
    } else {
        fill(corBotaoNormal);
    }
    desenhaBotao(width / 2 - 150, height / 2 + 50, 300, 50, "Sair");
}

void desenhaBotao(int x, int y, int largura, int altura, String texto) {
    stroke(0, 50);
    strokeWeight(2);
    rect(x, y, largura, altura, 15); 
    
    fill(corTexto);
    textSize(24);
    text(texto, x + largura / 2, y + altura / 2 + 8);
}

//Vê se o mouse ta sobre algun dos botões para alterar a corzinha da escolha
boolean mouseSobreBotao(int x, int y, int largura, int altura) {
    return mouseX > x && mouseX < x + largura && mouseY > y && mouseY < y + altura;
}

void jogarPessoa(){
    background(#23282B);
    desenhaBorda();
    p1.desenhaPaddle();
    p1.atualizaPosicao(mouseY);
    b1.atualizaPosicao(margem);
    b1.desenhaBola();
    b1.verificaColisao(p1);
    verificaVelocidade();
    testandoCoordeanadas();
    if (b1.verificaDerrota(p1) == 1){
        opt = 3;
    }
}

int bolaColideComPaddle() {
    int contagem = b1.getcontagemColisao();
     return contagem;
}

// Verifica qual botão esta sendo clicado para iniciar o jogo
void mouseReleased() {
// Controle de botões na tela de opções
    if (opt == 0) {
        if (mouseSobreBotao(width / 2 - 150, height / 2 - 50, 300, 50)) {
            opt = 1; // Inicia o jogo
        } else if (mouseSobreBotao(width / 2 - 150, height / 2 + 50, 300, 50)) {
            opt = 2; // Inicia o modo "IA Jogando" (ainda não implementado)
        }
    }
    // Controle de botões na tela de derrota
    else if (opt == 3) {
        if (mouseSobreBotao(width / 2 - 150, height / 2 - 50, 300, 50)) {
            reiniciarJogo(); // Reinicia o jogo
        } else if (mouseSobreBotao(width / 2 - 150, height / 2 + 50, 300, 50)) {
            exit(); // Sai do jogo
        }
    }

    else if (pausado) {
        if (mouseSobreBotao(width / 2 - 150, height / 2 - 50, 300, 50)) {
            pausado = false; // Continua o jogo
        } else if (mouseSobreBotao(width / 2 - 150, height / 2 + 50, 300, 50)) {
            exit(); // Sai do jogo
        }
    }
}

void keyPressed() {
    if (key == ESC) {
        pausado = !pausado;
        key = 0; // Previne o comportamento padrão do ESC
    }
}

void reiniciarJogo() {
    p1 = new Paddle(70 + margem, 70 + margem, 20, 100);
    b1 = new Ball((width / 2 + margem), (height / 2 + margem), 15);
    opt = 0; // Volta para a tela de opções
}

void verificaVelocidade() {
    println("Velocidade: " + b1.velocidade);
}

void exibePause(){
            textSize(24);
            fill(255);
            textAlign(CENTER, CENTER);
            text("|| ESC", width - 50, 50);
}

void testandoCoordeanadas(){
   String m;
   m = q.getState(b1, p1);
    println (m);
}

void jogarCOmIA() {
    background(#23282B);
    desenhaBorda();
    p1.desenhaPaddle();
    
    // IA escolhe uma ação baseada no estado atual
    String estadoAtual = q.getState(b1, p1);
    int acao = q.escolherAcao(estadoAtual);
    
    // Atualiza a posição do paddle com base na ação
    if (acao == 0) {
        p1.pos.y = max(p1.pos.y - 10, margem);  // Mover para cima, mas não ultrapassar o topo
    } else if (acao == 2) {
        p1.pos.y = min(p1.pos.y + 10, height - p1.tamanho.y - margem);  // Mover para baixo, mas não ultrapassar a borda inferior
    }

    b1.atualizaPosicao(margem);
    b1.desenhaBola();
    b1.verificaColisao(p1);
    
    if (b1.verificaDerrota(p1) == 1) {
        opt = 3;  // Tela de derrota
    }

    // Calcula a recompensa com base no estado
    String proximoEstado = q.getState(b1, p1);
    float reward = 0;
    if (b1.getcontagemColisao() > 0) {
        reward = 1;  // Recompensa positiva quando a bola colide com o paddle
    } else if (b1.verificaDerrota(p1) == 1) {
        reward = -1;  // Recompensa negativa quando a bola passa do paddle
    }

    // Atualiza os Q-values com a recompensa
    q.updateQ(estadoAtual, acao, reward, proximoEstado);

    verificaVelocidade();
    testandoCoordeanadas();
}


void draw() {
    if (opt == 0) {
        telaOpcao();
    } else if (opt == 1) {
        if (pausado) {
            telaPause(); 
        } else {
            jogarPessoa(); 
        }
        exibePause();
    } else if (opt == 2) {
      jogarCOmIA();
    } else if (opt == 3) {
        telaDerrota();
    }
    
    contagemColisoes = bolaColideComPaddle();
}
