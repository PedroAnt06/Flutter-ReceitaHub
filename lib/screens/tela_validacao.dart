import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'tela_nenhum_resultado.dart';

// tela Pesquisar receitas com o campo vazio e a mensagem de erro
// por enquanto é so o layout, a mensagem de erro ja vem fixa
class TelaValidacao extends StatelessWidget{
  const TelaValidacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesquisar receitas',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
        iconTheme: IconThemeData(color: primary), // cor da setinha de voltar (ela aparece sozinha)
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child:

          Column(
            spacing: 16, // espacamento entre os itens dessa coluna
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Qual receita você procura?',
                  style: TextStyle(fontSize: 24, color: primary, fontWeight: FontWeight.bold)
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome da receita', // rotulo do campo
                  errorText: 'Digite o nome de uma receita. Exemplo: Sopa de Lobo.', // mensagem de erro (fica vermelha)
                  hintText: 'Ex.: Sopa de Lobo', //placeholder
                  hintStyle: const TextStyle(color:grey),
                  prefixIcon: const Icon(Icons.search, color: primary,),
                  fillColor: white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: const BorderSide(color: grey),
                  ),
                ),
              ),

              // clicou: vai pra tela de nenhum resultado (so pra mostrar o proximo layout)
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaNenhumResultado()),
                    );
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  child: const Text(
                    'Pesquisar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Text(
                  'Você pode buscar por parte do nome da receita.',
                  style: TextStyle(fontSize: 14, color: grey)
              ),
            ],
          ),

      ),
    );
  }
}
