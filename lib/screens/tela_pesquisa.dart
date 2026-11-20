import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'tela_detalhe.dart';
import 'tela_validacao.dart';

// tela Pesquisar receitas (com resultado)
// abre quando clica em "Buscar Receitas" na tela Explorar
// por enquanto é so o layout, o resultado é fixo (Sopa de Lobo)
class TelaPesquisa extends StatelessWidget{
  const TelaPesquisa({super.key});

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

              TextField(
                controller: TextEditingController(text: 'Sopa'), // ja vem escrito pra mostrar o layout
                decoration: InputDecoration(
                  labelText: 'Nome da receita', // rotulo do campo
                  floatingLabelStyle: const TextStyle(color: primary),
                  prefixIcon: const Icon(Icons.search, color: primary,),
                  fillColor: white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: const BorderSide(color: grey),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: const BorderSide(color: primary, width: 2),
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {}, // ainda nao faz nada
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
                  'Resultados para "Sopa"',
                  style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
              ),

              Text(
                  'Toque na receita para ver o preparo.',
                  style: TextStyle(fontSize: 14, color: grey)
              ),

              // card do resultado, clicou: abre o detalhe
              Card(
                color: white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: grey),
                ),

                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaDetalhe()),
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      spacing: 16,
                      children: [

                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.restaurant)
                        ),

                        Expanded(
                            child: Column(
                              spacing: 6,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sopa de Lobo',
                                  style: TextStyle(fontSize: 16, color: secondary, fontWeight: FontWeight.bold ),
                                ),
                                const Text(
                                  'Uma sopa muito saborosa, famosa no desenho animado pica-pau delobo kk, e isso é maravilhosamente extraordinariamente gostoso',
                                  style: TextStyle(fontSize: 13, color: grey ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Row(
                                  spacing: 4,
                                  children: [
                                    Icon(Icons.access_time, size: 14, color: primary,),
                                    Text(
                                        '59 min',
                                        style: TextStyle(fontSize: 12, color: primary),
                                    ),
                                  ],
                                ),
                                const Row(
                                  spacing: 4,
                                  children: [
                                    Spacer(),
                                    Icon(Icons.favorite_border_outlined, size: 20, color: primary,),
                                  ],
                                )
                              ],
                            ))

                      ],
                    ),
                  ),
                ),
              ),

              // botao so com a borda (OutlinedButton), clicou: vai pra tela do campo vazio
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaValidacao()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primary,
                    side: const BorderSide(color: primary),
                  ),
                  child: const Text(
                    'Limpar pesquisa',
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
