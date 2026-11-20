import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'tela_detalhe.dart';
import 'tela_pesquisa.dart';

// aba Explorar: so o corpo da tela, a appbar e a navbar ficam na tela principal
class TelaInicial extends StatelessWidget{
  const TelaInicial({super.key}); //construtor para chamar na classe acima

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView deixa a tela rolar se nao couber tudo
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
      child:

        Column(
          spacing: 16, // espacamento entre os itens dessa coluna
          crossAxisAlignment: CrossAxisAlignment.start, // alinha os filhos no eixo oposto ao fluxo principal do layout
          children: [
            Text(
                'Receitas',
                style: TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.w600)
            ),
            Text(
                'Pesquise uma receita pelo nome.',
                style: TextStyle(fontSize: 14, color: grey)
            ),

            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar receitas...', //placeholder
                hintStyle: const TextStyle(color:grey),
                prefixIcon: const Icon(Icons.search, color: primary,),
                filled: true, // fundo do campo
                fillColor: white, //cor do fundo do campo

                //borda
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: const BorderSide(color: grey),
                ),

                //borda quando clicada
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: const BorderSide(color: primary, width: 2),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity, //ocupa toda a tela
              height: 54, //define altura
              child: FilledButton( //havia usado esse widget puro, mas nao ocupava toda a tela ai envolvi ele no SizedBox que delimita o tamanho total a tela

                // clicou: abre a tela de pesquisa
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaPesquisa()),
                  );
                },
                style: FilledButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
                ),


                child: const Text(
                  'Buscar Receitas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
            ),

            Text(
                'Receitas disponíveis',
                style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
            ),

            Text(
                'Selecione uma receita para ver o preparo.',
                style: TextStyle(fontSize: 14, color: grey)
            ),

            Card(
              color: white,
              clipBehavior: Clip.antiAlias, // o efeito do clique fica dentro da borda arredondada
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: grey),
              ),

              // InkWell deixa o card clicavel: clicou, abre o detalhe da receita
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaDetalhe()),
                  );
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
                  child: Row(
                    spacing: 16, // Espaço entre a foto e os textos
                    children: [

                      //Foto nesse container dentro dessa linha
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.restaurant)
                      ),

                      //Parte dos textos, que o expanded como mostrado em aula pega todo o espaço que está restante
                      Expanded(
                          child: Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start, // alinha os filhos no eixo oposto ao fluxo principal do layout
                            children: [
                              const Text(
                                'Sopa de Lobo',
                                style: TextStyle(fontSize: 16, color: secondary, fontWeight: FontWeight.bold ),
                              ),
                              const Text(
                                'Uma sopa muito saborosa, famosa no desenho animado pica-pau delobo kk, e isso é maravilhosamente extraordinariamente gostoso',
                                style: TextStyle(fontSize: 13, color: grey ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, //Acima de 2 linhas coloca o '...'
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
                                  Spacer(), // TEntei envolver o icone no expanded mas não foi muito eficaz o spacer criou o espaço vazio melhor
                                  Icon(Icons.favorite_border_outlined, size: 20, color: primary,),
                                ],
                              )
                            ],
                          ))

                    ],
                  ),
                ),
              ),
            )
          ],
        ),

    );
  }
}
