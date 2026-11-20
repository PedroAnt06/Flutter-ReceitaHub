import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'tela_detalhe.dart';

// aba Favoritos: so o corpo da tela, a appbar e a navbar ficam na tela principal
// por enquanto mostra uma receita fixa (depois vai mostrar so as favoritas de verdade)
class TelaFavoritos extends StatelessWidget{
  const TelaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
      child:

        Column(
          spacing: 16, // espacamento entre os itens dessa coluna
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Favoritos',
                style: TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.w600)
            ),
            Text(
                'Receitas salvas nesta sessão.',
                style: TextStyle(fontSize: 14, color: grey)
            ),

            // mesmo card da tela Explorar, so que com o coracao cheio
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
                                  Icon(Icons.favorite, size: 20, color: primary,), // coracao cheio = favorita
                                ],
                              )
                            ],
                          ))

                    ],
                  ),
                ),
              ),
            ),

            Text(
                'Toque no coração para remover.',
                style: TextStyle(fontSize: 14, color: grey)
            ),
          ],
        ),

    );
  }
}
