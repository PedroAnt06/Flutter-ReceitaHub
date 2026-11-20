import 'package:flutter/material.dart';

import '../theme/cores.dart';

// tela de carregando: blocos cinzas no lugar dos cards, uma bolinha girando e um texto
// por enquanto é so o layout
class TelaCarregando extends StatelessWidget{
  const TelaCarregando({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Explorar receitas',
                  style: TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.w600)
              ),

              // blocos cinzas que fingem ser os cards
              Container(
                width: double.infinity,
                height: 112,
                decoration: BoxDecoration(
                  color: cinzaClaro,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              Container(
                width: double.infinity,
                height: 112,
                decoration: BoxDecoration(
                  color: cinzaClaro,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              // Center coloca a bolinha e o texto no meio da tela
              Center(
                child: Column(
                  spacing: 16,
                  children: [
                    CircularProgressIndicator(color: primary), // bolinha girando
                    Text(
                        'Carregando receitas...',
                        style: TextStyle(fontSize: 14, color: grey)
                    ),
                  ],
                ),
              ),
            ],
          ),

      ),
    );
  }
}
