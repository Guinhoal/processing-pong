  import java.util.List;
  
  class Ball {
    PVector pos;
    PVector velocidade;
    float raio;
    int contagemColisao;
    
    public Ball(int posx, int posy, float r){
        pos = new PVector(posx, posy);
        velocidade = new PVector(random(-7, 7), random(-6, 6)); // Velocidade inicial
        if ((velocidade.x < 2.2 && velocidade.x > -2.2) ){
          velocidade.x *= 3.8;
        } else if ( (velocidade.y < 2.2 && velocidade.y > -2.2)){
          velocidade.y *= 3.8;
        }
        raio = r;
        contagemColisao = 0;
    }


    void desenhaBola() {
        fill(255);
        noStroke();
        ellipse(pos.x, pos.y, raio * 2, raio * 2);
    }

    void atualizaPosicao(int margem) {
        pos.add(velocidade);
        velocidade.limit(20);

        if ((pos.y - margem) < raio || pos.y > (height - margem) - raio) {
            velocidade.y *= -1;
            aumentarVelocidade();
        }

        if ((pos.x - margem) < raio || pos.x > (width - margem) - raio) {
            velocidade.x *= -1;
            aumentarVelocidade();
        }
    }

     boolean verificaColisao(Paddle p) {
        if (pos.x - raio < p.pos.x + p.tamanho.x && pos.x + raio > p.pos.x &&
            pos.y + raio > p.pos.y && pos.y - raio < p.pos.y + p.tamanho.y) {
            velocidade.x *= -1;
            aumentarVelocidade();
            colisaoDetectada();
            return true;
        }
        return false;
    }
    
    void colisaoDetectada(){
        contagemColisao++;
    }

    int getcontagemColisao(){
        return contagemColisao;
    }

    
void aumentarVelocidade() {
        float incremento = random(0, 1);
        incremento /= 20;
        velocidade.setMag(velocidade.mag() + incremento); 
    }
    
    int verificaDerrota(Paddle p) {
        if (pos.x - raio  < p.pos.x ) {
            return 1;
        } else return 0;
    }
}
  
