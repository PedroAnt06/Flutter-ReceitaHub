import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'tela_carregando.dart';

// tela de erro de conexao
// por enquanto é so o layout
class TelaErro extends StatelessWidget{
  const TelaErro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ReceitaHub',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
        iconTheme: IconThemeData(color: primary), // cor da setinha de voltar (ela aparece sozinha)
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child:

          Column(
            spacing: 16, // espacamento entre os itens dessa coluna
            mainAxisAlignment: MainAxisAlignment.center, // centraliza os itens na altura da tela
            children: [

              // circulo com o icone
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: rosaClaro,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.error_outline, size: 48, color: primary),
              ),

              Text(
                  'Não foi possível carregar as receitas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: primary, fontWeight: FontWeight.bold)
              ),
              Text(
                  'Verifique sua conexão e tente novamente.',
                  style: TextStyle(fontSize: 14, color: grey)
              ),

              // clicou: vai pra tela de carregando (como se tentasse de novo)
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaCarregando()),
                    );
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  child: const Text(
                    'Tentar novamente',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }
}
