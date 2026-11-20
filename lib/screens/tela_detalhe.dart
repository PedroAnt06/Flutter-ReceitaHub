import 'package:flutter/material.dart';

import '../theme/cores.dart';

// tela com tudo da receita: foto, tempo, ingredientes e modo de preparo
// abre quando clica em um card de receita
// por enquanto é so o layout, os dados sao fixos (Sopa de Lobo)
class TelaDetalhe extends StatelessWidget{
  const TelaDetalhe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receita',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
        iconTheme: IconThemeData(color: primary), // cor da setinha de voltar (ela aparece sozinha)

        // coracao la em cima (por enquanto so enfeite)
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: primary),
            onPressed: () {},
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

              // foto grande (por enquanto so um icone)
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: rosaClaro,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.restaurant, size: 64, color: primary),
              ),

              Text(
                  'Sopa de Lobo',
                  style: TextStyle(fontSize: 24, color: primary, fontWeight: FontWeight.bold)
              ),
              Text(
                  'Uma sopa muito saborosa, famosa no desenho animado pica-pau delobo kk, e isso é maravilhosamente extraordinariamente gostoso',
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('59 min', style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('4', style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Não salva', style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)),
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

              // cada ingrediente é uma linha com uma bolinha e o texto
              const Row(
                spacing: 8,
                children: [
                  Icon(Icons.circle, size: 6, color: primary),
                  Text('Batata', style: TextStyle(fontSize: 14, color: grey)),
                ],
              ),
              const Row(
                spacing: 8,
                children: [
                  Icon(Icons.circle, size: 6, color: primary),
                  Text('Cenoura', style: TextStyle(fontSize: 14, color: grey)),
                ],
              ),
              const Row(
                spacing: 8,
                children: [
                  Icon(Icons.circle, size: 6, color: primary),
                  Text('Cebola', style: TextStyle(fontSize: 14, color: grey)),
                ],
              ),
              const Row(
                spacing: 8,
                children: [
                  Icon(Icons.circle, size: 6, color: primary),
                  Text('Caldo de legumes', style: TextStyle(fontSize: 14, color: grey)),
                ],
              ),

              Text(
                  'Modo de preparo',
                  style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
              ),

              // cada passo é uma linha com a bolinha do numero e o texto
              const Row(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: primary,
                    child: Text('1', style: TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text('Pique os legumes em cubos.', style: TextStyle(fontSize: 14, color: grey)),
                  ),
                ],
              ),
              const Row(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: primary,
                    child: Text('2', style: TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text('Refogue a cebola em uma panela.', style: TextStyle(fontSize: 14, color: grey)),
                  ),
                ],
              ),
              const Row(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: primary,
                    child: Text('3', style: TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text('Adicione os legumes e o caldo e cozinhe por 40 minutos.', style: TextStyle(fontSize: 14, color: grey)),
                  ),
                ],
              ),
            ],
          ),

      ),
    );
  }
}
