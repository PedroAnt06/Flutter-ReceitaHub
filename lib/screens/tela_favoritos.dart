import 'package:flutter/material.dart';

import '../data/receitas.dart';
import '../models/receita.dart';
import '../theme/cores.dart';
import '../widgets/card_receita.dart';
import '../widgets/estado_mensagem.dart';

// tela Favoritos (segunda aba do app)
// mostra as receitas favoritadas, ou uma mensagem se nao tiver nenhuma
// StatefulWidget porque a lista muda quando tira um favorito
class TelaFavoritos extends StatefulWidget {
  final VoidCallback onExplorar; // o botao "Explorar receitas" troca pra primeira aba

  const TelaFavoritos({super.key, required this.onExplorar});

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  @override
  Widget build(BuildContext context) {
    // pega so as receitas marcadas como favoritas (where = filtra a lista)
    final favoritas = receitas.where((r) => r.favorita).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ReceitaHub',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child: _conteudo(favoritas),
      ),
    );
  }

  // decide o que mostrar: a mensagem de vazio ou a lista
  Widget _conteudo(List<Receita> favoritas) {
    // nenhuma favorita: mostra a mensagem (widgets/estado_mensagem.dart)
    if (favoritas.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: EstadoMensagem(
          icone: Icons.favorite_border_outlined,
          titulo: 'Nenhum favorito',
          mensagem: 'Marque uma receita como favorita para encontrá-la aqui.',
          textoBotao: 'Explorar receitas',
          onBotao: widget.onExplorar,
        ),
      );
    }

    // tem favoritas: mostra a lista, um cartao pra cada
    return Column(
      spacing: 16, // espacamento entre os itens dessa coluna
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Favoritos',
          style: TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.w600),
        ),
        Text(
          'Receitas salvas nesta sessão.',
          style: TextStyle(fontSize: 14, color: grey),
        ),

        for (final receita in favoritas)
          CardReceita(
            receita: receita,
            onMudou: () => setState(() {}), // setState vazio so serve pra redesenhar (tira o card se desfavoritou)
          ),

        Text(
          'Toque no coração para remover.',
          style: TextStyle(fontSize: 14, color: grey),
        ),
      ],
    );
  }
}
