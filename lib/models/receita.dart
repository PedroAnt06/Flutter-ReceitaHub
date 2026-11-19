// molde de uma receita: tudo que uma receita tem
// as telas usam esse molde pra mostrar os dados
class Receita {
  final String nome;
  final String descricao;
  final int tempo; // tempo de preparo em minutos
  final int porcoes; // quantas porcoes rende
  final List<String> ingredientes;
  final List<String> passos; // modo de preparo, um texto por passo

  // cada receita sabe se é favorita ou nao
  // nao é final porque muda quando clica no coracao
  bool favorita = false;

  // required = é obrigatorio passar esses valores quando criar uma Receita
  Receita({
    required this.nome,
    required this.descricao,
    required this.tempo,
    required this.porcoes,
    required this.ingredientes,
    required this.passos,
  });
}
