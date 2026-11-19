import 'package:flutter/material.dart';

import '../theme/cores.dart';

// botao grande "Buscar Receitas"
// o que ele faz quando clica vem de fora (onPressed), assim a tela inicial decide
class BotaoBuscar extends StatelessWidget {
  final VoidCallback onPressed;

  const BotaoBuscar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, //ocupa toda a tela
      height: 54, //define altura
      child: FilledButton( //havia usado esse widget puro, mas nao ocupava toda a tela ai envolvi ele no SizedBox que delimita o tamanho total a tela

        onPressed: onPressed, // chama o metodo (sem parenteses)
        style: FilledButton.styleFrom(
            backgroundColor: primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        ),

        child: const Text(
          'Buscar Receitas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
    );
  }
}
