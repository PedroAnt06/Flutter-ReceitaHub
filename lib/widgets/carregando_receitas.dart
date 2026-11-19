import 'package:flutter/material.dart';

import '../theme/cores.dart';

// tela de carregando: dois blocos cinzas no lugar dos cards, uma bolinha girando e um texto
// aparece enquanto as receitas ainda nao chegaram
class CarregandoReceitas extends StatelessWidget {
  const CarregandoReceitas({super.key});

  // um bloco cinza do tamanho de um card (so pra dar a ideia de que la vem uma receita)
  Widget _blocoCinza() {
    return Container(
      width: double.infinity,
      height: 112,
      decoration: BoxDecoration(
        color: cinzaClaro,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _blocoCinza(),
        _blocoCinza(),
        const CircularProgressIndicator(color: primary), // bolinha girando
        const Text(
          'Carregando receitas...',
          style: TextStyle(fontSize: 14, color: grey),
        ),
      ],
    );
  }
}
