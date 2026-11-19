import 'package:flutter/material.dart';

import '../models/receita.dart';
import '../theme/cores.dart';

// tela com tudo da receita: foto, tempo, ingredientes e modo de preparo
// abre quando clica em um cartao de receita (widgets/card_receita.dart)
// StatefulWidget porque o coracao muda quando clica
class TelaDetalhe extends StatefulWidget {
  final Receita receita; // a receita que foi clicada

  const TelaDetalhe({super.key, required this.receita});

  @override
  State<TelaDetalhe> createState() => _TelaDetalheState();
}

class _TelaDetalheState extends State<TelaDetalhe> {
  @override
  Widget build(BuildContext context) {
    // atalho pra nao escrever widget.receita toda hora
    final receita = widget.receita;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receita', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: primary, // cor do titulo e da seta de voltar (a seta aparece sozinha)
        backgroundColor: background,
        actions: [
          // coracao la em cima: inverte o favorita e redesenha a tela
          IconButton(
            onPressed: () {
              setState(() {
                receita.favorita = !receita.favorita;
              });
            },
            icon: Icon(
              receita.favorita ? Icons.favorite : Icons.favorite_border_outlined,
              color: primary,
            ),
          ),
        ],
      ),

      // rolagem porque ingredientes e passos podem passar da tela
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child: Column(
          spacing: 16, // espacamento entre os itens dessa coluna
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // foto grande (por enquanto so um icone, igual ao card)
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: rosaClaro,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.restaurant, size: 64, color: primary),
            ),

            Text(
              receita.nome,
              style: TextStyle(fontSize: 24, color: primary, fontWeight: FontWeight.bold),
            ),
            Text(
              receita.descricao,
              style: TextStyle(fontSize: 14, color: grey),
            ),

            // 3 caixinhas lado a lado: tempo, porcoes e se é favorita
            // Expanded em cada uma divide a largura igualmente
            Row(
              spacing: 8,
              children: [
                Expanded(child: _CaixaInfo(valor: '${receita.tempo} min', rotulo: 'tempo total')),
                Expanded(child: _CaixaInfo(valor: '${receita.porcoes}', rotulo: 'porções')),
                Expanded(
                  child: _CaixaInfo(
                    valor: receita.favorita ? 'Salva' : 'Não salva',
                    rotulo: 'nos favoritos',
                  ),
                ),
              ],
            ),

            Text(
              'Ingredientes',
              style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600),
            ),

            // um item com bolinha pra cada ingrediente
            for (final ingrediente in receita.ingredientes)
              Row(
                spacing: 8,
                children: [
                  const Icon(Icons.circle, size: 6, color: primary),
                  Expanded(child: Text(ingrediente, style: TextStyle(fontSize: 14, color: grey))),
                ],
              ),

            Text(
              'Modo de preparo',
              style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600),
            ),

            // repete pra cada passo, o i é a posicao (comeca em 0)
            // por isso mostra i + 1 na bolinha
            for (var i = 0; i < receita.passos.length; i++)
              Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: primary,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Text(receita.passos[i], style: TextStyle(fontSize: 14, color: grey))),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// caixinha pequena com um valor grande e um rotulo embaixo (ex.: "35 min" / "tempo total")
// começa com _ entao so é usada nesse arquivo
class _CaixaInfo extends StatelessWidget {
  final String valor;
  final String rotulo;

  const _CaixaInfo({required this.valor, required this.rotulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: rosaClaro,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(valor, style: const TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
          Text(rotulo, style: const TextStyle(fontSize: 11, color: grey)),
        ],
      ),
    );
  }
}
