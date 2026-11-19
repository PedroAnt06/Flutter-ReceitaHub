import 'package:flutter/material.dart';

import '../theme/cores.dart';

// cartao que mostra uma receita (foto, nome, descricao, tempo e coracao)
// por enquanto os dados sao fixos (Sopa de Lobo), depois podem vir de uma lista
class CardReceita extends StatelessWidget {
  const CardReceita({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: grey),
      ),

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
    );
  }
}
