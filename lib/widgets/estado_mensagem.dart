import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'botao_principal.dart';

// bloco de mensagem usado quando nao tem o que mostrar: erro de conexao, nenhum favorito...
// tem um icone num circulo, titulo, texto e um botao
// o mesmo layout serve pras duas telas, so muda o que é passado
class EstadoMensagem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String mensagem;
  final String textoBotao;
  final VoidCallback onBotao; // o que o botao faz

  const EstadoMensagem({
    super.key,
    required this.icone,
    required this.titulo,
    required this.mensagem,
    required this.textoBotao,
    required this.onBotao,
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
            child: Icon(icone, size: 48, color: primary),
          ),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: primary, fontWeight: FontWeight.bold),
          ),
          Text(
            mensagem,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: grey),
          ),
          const SizedBox(height: 4), // um respiro antes do botao
          BotaoPrincipal(texto: textoBotao, onPressed: onBotao),
        ],
      ),
    );
  }
}
