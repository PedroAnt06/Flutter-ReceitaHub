import 'package:flutter/material.dart';

import '../theme/cores.dart';

// tela mostrada quando a pesquisa nao encontra nada
// recebe o termo pesquisado (pra mostrar na mensagem) e o que fazer ao clicar em "Ver todas"
class NaoEncontrado extends StatelessWidget {
  final String termo; // o que a pessoa pesquisou
  final VoidCallback onVerTodas; // quem decide o que acontece é a tela inicial

  const NaoEncontrado({
    super.key,
    required this.termo,
    required this.onVerTodas,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ocupa a largura toda para centralizar o conteudo
      child: Column(
        spacing: 12,
        children: [
          // circulo com o icone
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: rosaClaro,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_off, size: 48, color: primary),
          ),
          const Text(
            'Nenhum resultado',
            style: TextStyle(fontSize: 22, color: primary, fontWeight: FontWeight.bold),
          ),
          Text(
            'Não encontramos receitas para "$termo".',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: grey),
            overflow: TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: onVerTodas,
            style: TextButton.styleFrom(
              overlayColor: secondary,
            ),
            child: const Text(
              'Ver todas as receitas',
              style:
              TextStyle(color: primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
