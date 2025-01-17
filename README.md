# Trabalho de Pong com IA

Este projeto foi desenvolvido no COLTEC e implementa o jogo Pong em duas versões: uma sem IA e outra com IA. A versão com IA utiliza Q-Learning para treinar um agente a jogar Pong.

## Estrutura do Projeto

O projeto está dividido em dois formatos:

### **Sem IA**
- **Paddle.pde**: Implementa a raquete do jogador.
- **Ball.pde**: Implementa a bola do jogo.
- **Placar.pde**: Implementa a janela de placar.
- **Trabalho_3_aeds.pde**: Arquivo principal que gerencia o jogo.

### **Com IA**
- **Raquete.pde**: Implementa a raquete do jogador e do oponente.
- **Bola.pde**: Implementa a bola do jogo.
- **Pong.pde**: Gerencia a lógica do jogo e a interação entre os componentes.
- **Agente.pde**: Implementa o agente de Q-Learning.
- **TrabalhoPong.pde**: Arquivo principal que gerencia o jogo com IA.

## Como Executar

### **Sem IA**
1. Abra o Processing.
2. Carregue o arquivo `Trabalho_3_aeds.pde`.
3. Execute o sketch.

### **Com IA**
1. Abra o Processing.
2. Carregue o arquivo `TrabalhoPong.pde`.
3. Execute o sketch.

## Funcionalidades

### **Sem IA**
- Controle do paddle com o mouse.
- Contagem de colisões.
- Tela de opções, pausa e derrota.

### **Com IA**
- Treinamento do agente usando Q-Learning.
- Simulação de partidas.
- Exibição da pontuação e média de pontuações.

Este trabalho apresenta tanto a implementação clássica de Pong quanto uma versão mais avançada com inteligência artificial, proporcionando uma experiência interativa e desafiadora.
