import java.util.Map;
import java.util.HashMap;
import java.util.Random;


class QLearning {
    Map<String, float[]> Q;
    float a;  // Taxa de aprendizado
    float g;  // Fator de desconto
    float e;  // Taxa de exploração
    Random r;

    QLearning(float alpha, float gamma, float epsilon) {
        Q = new HashMap<>();
        this.a = alpha;
        this.g = gamma;
        this.e = epsilon;
        r = new Random();
    }

    String getState(Ball b, Paddle p) {
        // Usamos a posição da bola e a posição do paddle para definir o estado
        int bx = (int) b.pos.x / 50;  // Dividimos para criar uma discretização
        int by = (int) b.pos.y / 50;
        int py = (int) p.pos.y / 50;
        return bx + "," + by + "," + py;  // Representa um estado como uma string
    }

    int escolherAcao(String estado) {
        if (!Q.containsKey(estado)) {
            Q.put(estado, new float[3]);  // 3 ações possíveis (para cima, para baixo, e nada)
        }

        if (r.nextFloat() < e) {
            return r.nextInt(3);  // Exploração: Escolher uma ação aleatória
        } else {
            float[] QValues = Q.get(estado);
            int actionWithMaxQ = 0;
            for (int i = 1; i < QValues.length; i++) {
                if (QValues[i] > QValues[actionWithMaxQ]) {
                    actionWithMaxQ = i;  // Seleciona a ação com o maior valor de Q
                }
            }
            return actionWithMaxQ;  // Exploração: Ação mais otimizada
        }
    }

    void updateQ(String estado, int acao, float reward, String proximoEstado) {
        if (!Q.containsKey(proximoEstado)) {
            Q.put(proximoEstado, new float[3]);  // Inicializa o próximo estado se ainda não existir
        }

        // Obtém os valores Q do estado atual e do próximo estado
        float[] qValues = Q.get(estado);
        float[] nextQValues = Q.get(proximoEstado);

        // Encontra o valor máximo de Q no próximo estado (Qmax)
        float maxNextQ = nextQValues[0];
        for (int i = 1; i < nextQValues.length; i++) {
            if (nextQValues[i] > maxNextQ) {
                maxNextQ = nextQValues[i];
            }
        }

        // Atualiza o valor Q para a ação selecionada
        qValues[acao] = qValues[acao] + a * (reward + g * maxNextQ - qValues[acao]);
    }

    // Método para treinar a IA com simulações de jogo
    void treinar(Ball b, Paddle p, int numIteracoes) {
        for (int i = 0; i < numIteracoes; i++) {
            // Simula um ciclo de treinamento
            String estado = getState(b, p);
            int acao = escolherAcao(estado);
            float reward = executarAcao(b, p, acao);  // Calcula a recompensa após a ação

            // Obtém o próximo estado após a ação
            String proximoEstado = getState(b, p);

            // Atualiza a tabela Q com base na recompensa recebida
            updateQ(estado, acao, reward, proximoEstado);
        }
    }

    // Executa a ação e calcula a recompensa
    float executarAcao(Ball b, Paddle p, int acao) {
        // Ação: 0 = Para cima, 1 = Para baixo, 2 = Não fazer nada
        switch (acao) {
            case 0: // Move o paddle para cima
                p.pos.y -= 10;
                break;
            case 1: // Move o paddle para baixo
                p.pos.y += 10;
                break;
            case 2: // Não faz nada
                break;
        }

        // Constrói a recompensa com base no comportamento da IA
        if (b.verificaColisao(p)) {
            return 1;  // Recompensa positiva se colidir com o paddle
        } else if (b.verificaDerrota(p) == 1) {
            return -1;  // Recompensa negativa se a IA perder
        } else {
            return 0;  // Recompensa neutra se o jogo continuar
        }
    }
}
