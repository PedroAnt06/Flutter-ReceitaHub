import 'package:flutter/material.dart';
import 'package:receita_hub/favoritos.dart';

import '../theme/cores.dart';

// receita de exemplo, usada quando essa tela é aberta pelo menu ou pela pesquisa
// (essas telas ainda sao fixas e nao tem uma receita da API pra mandar)
// tem os mesmos campos que a API manda, por isso a tela funciona igual
final Map receitaExemplo = {
  'id': 0,
  'name': 'Sopa de Lobo',
  'cuisine': 'Brasileira',
  'difficulty': 'Fácil',
  'prepTimeMinutes': 19,
  'cookTimeMinutes': 40,
  'servings': 4,
  'rating': 4.5,
  'image': '',
  'ingredients': ['Batata', 'Cenoura', 'Cebola', 'Caldo de legumes'],
  'instructions': [
    'Pique os legumes em cubos.',
    'Refogue a cebola em uma panela.',
    'Adicione os legumes e o caldo e cozinhe por 40 minutos.',
  ],
};

// tela com tudo da receita: foto, tempo, ingredientes e modo de preparo
// abre quando clica em um card de receita, que manda a receita (um Map da API) pra ca
// StatefulWidget porque o coracao muda quando clica
class TelaDetalhe extends StatefulWidget{
  final Map receita; // a receita que foi clicada

  // required = é obrigatorio mandar a receita quando abrir essa tela
  const TelaDetalhe({super.key, required this.receita});

  @override
  State<TelaDetalhe> createState() => _TelaDetalheState();
}

class _TelaDetalheState extends State<TelaDetalhe> {
  @override
  Widget build(BuildContext context) {
    // atalho pra nao escrever widget.receita toda hora
    final receita = widget.receita;

    // a API manda os ingredientes e os passos em listas de texto
    final List ingredientes = receita['ingredients'];
    final List passos = receita['instructions'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receita',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
        iconTheme: IconThemeData(color: primary), // cor da setinha de voltar (ela aparece sozinha)

        // coracao la em cima: favorita ou desfavorita e o setState troca o icone
        actions: [
          IconButton(
            icon: Icon(
              ehFavorita(receita) ? Icons.favorite : Icons.favorite_border_outlined,
              color: primary,
            ),
            onPressed: () {
              setState(() {
                alternarFavorita(receita);
              });
            },
          ),
        ],
      ),

      // rolagem porque ingredientes e passos podem passar da tela
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child:

          Column(
            spacing: 16, // espacamento entre os itens dessa coluna
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // foto grande da receita (vem da API), se nao carregar mostra o icone
              // ClipRRect deixa os cantos da foto arredondados
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  receita['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover, // a foto preenche o espaco sem esticar
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: rosaClaro,
                      child: const Icon(Icons.restaurant, size: 64, color: primary),
                    );
                  },
                ),
              ),

              Text(
                  receita['name'],
                  style: TextStyle(fontSize: 24, color: primary, fontWeight: FontWeight.bold)
              ),
              Text(
                  '${receita['cuisine']} • ${receita['difficulty']} • ${receita['rating']} / 5',
                  style: TextStyle(fontSize: 14, color: grey)
              ),

              // 3 caixinhas lado a lado: tempo, porcoes e favorito
              // o Expanded em cada uma divide a largura igualmente
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: rosaClaro,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // tempo total = preparo + cozimento
                          Text('${receita['prepTimeMinutes'] + receita['cookTimeMinutes']} min', style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
                          Text('tempo total', style: TextStyle(fontSize: 11, color: grey)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: rosaClaro,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${receita['servings']}', style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
                          Text('porções', style: TextStyle(fontSize: 11, color: grey)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: rosaClaro,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ehFavorita(receita) ? 'Salva' : 'Não salva', style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
                          Text('nos favoritos', style: TextStyle(fontSize: 11, color: grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                  'Ingredientes',
                  style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
              ),

              // um item com bolinha pra cada ingrediente da lista
              for (final ingrediente in ingredientes)
                Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.circle, size: 6, color: primary),
                    Expanded(
                      child: Text('$ingrediente', style: TextStyle(fontSize: 14, color: grey)),
                    ),
                  ],
                ),

              Text(
                  'Modo de preparo',
                  style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
              ),

              // um item pra cada passo, o i é a posicao do passo na lista (comeca em 0)
              // por isso mostra i + 1 na bolinha
              for (var i = 0; i < passos.length; i++)
                Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: primary,
                      child: Text('${i + 1}', style: TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Text('${passos[i]}', style: TextStyle(fontSize: 14, color: grey)),
                    ),
                  ],
                ),
            ],
          ),

      ),
    );
  }
}
