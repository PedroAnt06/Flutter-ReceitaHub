import 'dart:convert';

import 'package:http/http.dart' as http;

// o que a funcao buscarReceitas devolve pra tela:
// - receitas: a lista que veio da API (vazia se deu problema)
// - erro: a mensagem do problema (null = deu tudo certo)
class RespostaReceitas {
  final List receitas;
  final String? erro;

  RespostaReceitas(this.receitas, this.erro);
}

// chama a API e trata os problemas, assim a tela so recebe o resultado pronto
// Future + async/await = espera a resposta da internet chegar sem travar o app
Future<RespostaReceitas> buscarReceitas() async {
  try {
    // faz o pedido (GET) pra API de receitas
    final resposta = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    // 200 = deu certo, qualquer outro numero é erro (404, 500...)
    if (resposta.statusCode != 200) {
      return RespostaReceitas([], 'Erro ao buscar as receitas (código ${resposta.statusCode}).');
    }

    // transforma o texto que veio (JSON) em Map e Lista do Dart
    // a lista de receitas vem dentro da chave 'recipes'
    final dados = jsonDecode(resposta.body);
    final lista = dados['recipes'];

    // deu 200 mas a lista veio vazia ou nao veio
    if (lista == null || lista.isEmpty) {
      return RespostaReceitas([], 'Nenhuma receita encontrada.');
    }

    // deu tudo certo: devolve a lista e nenhum erro
    return RespostaReceitas(lista, null);
  } catch (e) {
    // caiu aqui se nao tem internet ou se a resposta veio estranha
    return RespostaReceitas([], 'Não foi possível conectar. Verifique sua conexão.');
  }
}
