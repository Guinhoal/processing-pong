import java.util.List;

class Paddle {
    PVector pos;
    PVector tamanho;
    PVector velocidade;

    public Paddle (int posx, int posy, int tamx, int tamy) {
        pos = new PVector(posx, posy);
        tamanho = new PVector(tamx, tamy);
        velocidade = new PVector(0, 10);
    }

      void desenhaPaddle() {
        for (int i = 0; i <= 10; i++) {
            fill(255 - i * 5);
            noStroke();
            rect(pos.x + i, pos.y + i, tamanho.x - i * 2, tamanho.y - i * 2, 10);
        }
        
        // Paddle
        fill(255);
        stroke(0);
        strokeWeight(2);
        rect(pos.x, pos.y, tamanho.x, tamanho.y, 10); // Bordas arredondadas com raio 10
    }


void atualizaPosicao(float mouseY) {
        pos.y = lerp(pos.y, mouseY - tamanho.y / 2, 0.1); //Segue o mouse na posição y
        pos.y = constrain(pos.y, margem, height - margem - tamanho.y); // Não deixa o paddle sair da tela
    }
}
