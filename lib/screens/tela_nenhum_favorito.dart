import 'package:flutter/material.dart';

import '../theme/cores.dart';

// tela de quando ainda nao tem nenhuma receita favorita
// por enquanto é so o layout
class TelaNenhumFavorito extends StatelessWidget{
  const TelaNenhumFavorito({super.key});

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
                child: const Icon(Icons.favorite_border_outlined, size: 48, color: primary),
              ),

              Text(
                  'Nenhum favorito',
                  style: TextStyle(fontSize: 22, color: primary, fontWeight: FontWeight.bold)
              ),
              Text(
                  'Marque uma receita como favorita para encontrá-la aqui.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: grey)
              ),

              // clicou: volta pra tela anterior (pop fecha a tela atual)
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  child: const Text(
                    'Explorar receitas',
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
