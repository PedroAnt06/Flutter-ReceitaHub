import 'package:flutter/material.dart';

import '../theme/cores.dart';

// tela de quando a pesquisa nao encontra nada
// por enquanto é so o layout, o termo "zzzz987" é fixo
class TelaNenhumResultado extends StatelessWidget{
  const TelaNenhumResultado({super.key});

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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child:

          Column(
            spacing: 16, // espacamento entre os itens dessa coluna
            children: [

              TextField(
                controller: TextEditingController(text: 'zzzz987'), // ja vem escrito pra mostrar o layout
                decoration: InputDecoration(
                  labelText: 'Nome da receita',
                  prefixIcon: const Icon(Icons.search, color: primary,),
                  fillColor: white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: const BorderSide(color: grey),
                  ),
                ),
              ),

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

              Text(
                  'Nenhum resultado',
                  style: TextStyle(fontSize: 22, color: primary, fontWeight: FontWeight.bold)
              ),
              Text(
                  'Não encontramos receitas para "zzzz987".',
                  style: TextStyle(fontSize: 14, color: grey)
              ),

              // clicou: volta pra tela anterior (pop fecha a tela atual)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  overlayColor: secondary,
                ),
                child: const Text(
                  'Ver todas as receitas',
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

      ),
    );
  }
}
