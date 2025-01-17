class Agente {
  HashMap<String, Float> qTable;
  float taxaAprendizagem;
  float desconto;
  float exploracaoInicial;
  float exploracaoMinima;
  float exploracaoDecaimento;
  int episodios;

  Agente(float taxaAprendizagem, float desconto, float exploracaoInicial, float exploracaoMinima, float exploracaoDecaimento) {
    qTable = new HashMap<String, Float>();
    this.taxaAprendizagem = taxaAprendizagem;
    this.desconto = desconto;
    this.exploracaoInicial = exploracaoInicial;
    this.exploracaoMinima = exploracaoMinima;
    this.exploracaoDecaimento = exploracaoDecaimento;
    this.episodios = 0;
  }

  float obterQ(String estado, int acao) {
    String chave = estado + "," + acao;
    if (!qTable.containsKey(chave)) qTable.put(chave, 0.0);
    return qTable.get(chave);
  }

  void atualizarQ(String estado, int acao, float recompensa, String proximoEstado) {
    float valorQ = obterQ(estado, acao);
    float maxQProximo = max(obterQ(proximoEstado, 0), obterQ(proximoEstado, 1), obterQ(proximoEstado, 2));
    float novoQ = valorQ + taxaAprendizagem * (recompensa + desconto * maxQProximo - valorQ);
    qTable.put(estado + "," + acao, novoQ);
    episodios = (episodios + 1) % 100000;
  }

  int escolherAcao(String estado) {
    float taxaExploracao = max(exploracaoMinima, exploracaoInicial * exp(-exploracaoDecaimento * episodios));
    if (random(1) < taxaExploracao) return round(random(2));
    else {
      float q0 = obterQ(estado, 0);
      float q1 = obterQ(estado, 1);
      float q2 = obterQ(estado, 2);
      if (q0 >= q1 && q0 >= q2) return 0;
      else if (q1 >= q2) return 1;
      return 2;
    }
  }
}
