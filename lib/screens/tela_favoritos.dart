import 'package:flutter/material.dart';
import 'package:receita_hub/favoritos.dart';
import 'package:receita_hub/screens/tela_detalhe.dart';

import '../theme/cores.dart';

// aba Favoritos: so o corpo da tela, a appbar e a navbar ficam na tela principal
// mostra as receitas que foram favoritadas na tela Explorar (lista do arquivo favoritos.dart)
// StatefulWidget porque a tela muda quando tira uma receita dos favoritos
class TelaFavoritos extends StatefulWidget{
  const TelaFavoritos({super.key});

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
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

            // 1) nenhuma favorita ainda: mostra a mensagem
            if (favoritas.isEmpty)
              Center(
                child: Column(
                  spacing: 16,
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
                  ],
                ),
              ),

            // 2) tem favoritas: um card pra cada uma (mesmo card da tela Explorar)
            // quando a lista esta vazia o for nao mostra nada
            for (final receita in favoritas)
              Card(
                color: white,
                clipBehavior: Clip.antiAlias, // a foto fica dentro da borda arredondada
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: grey),
                ),

                child: InkWell(
                  // clicou no card: abre o detalhe daquela receita e espera voltar
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaDetalhe(receita: receita)),
                    );
                    // quando volta o coracao pode ter mudado la no detalhe, entao redesenha
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      spacing: 16,
                      children: [

                        //Foto da receita (vem da API pelo endereco que esta em receita['image'])
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            receita['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            // se a foto nao carregar mostra o iconzinho
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: background,
                                child: const Icon(Icons.restaurant),
                              );
                            },
                          ),
                        ),

                        Expanded(
                            child: Column(
                              spacing: 6,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  receita['name'],
                                  style: TextStyle(fontSize: 16, color: secondary, fontWeight: FontWeight.bold ),
                                ),
                                Text(
                                  '${receita['cuisine']} • ${receita['difficulty']}',
                                  style: TextStyle(fontSize: 13, color: grey ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  spacing: 4,
                                  children: [
                                    Icon(Icons.access_time, size: 14, color: primary,),
                                    Text(
                                        '${receita['prepTimeMinutes'] + receita['cookTimeMinutes']} min',
                                        style: TextStyle(fontSize: 12, color: primary),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 4,
                                  children: [
                                    Icon(Icons.star, size: 14, color: primary,),
                                    Text(
                                        '${receita['rating']}',
                                        style: TextStyle(fontSize: 12, color: primary),
                                    ),
                                    Spacer(),

                                    // coracao cheio: clicou, tira dos favoritos e o card some da lista
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          alternarFavorita(receita);
                                        });
                                      },
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(),
                                      icon: Icon(Icons.favorite, size: 20, color: primary),
                                    ),
                                  ],
                                )
                              ],
                            ))

                      ],
                    ),
                  ),
                ),
              ),

            // o aviso so aparece se tiver alguma favorita
            if (favoritas.isNotEmpty)
              Text(
                  'Toque no coração para remover.',
                  style: TextStyle(fontSize: 14, color: grey)
              ),
          ],
        ),

    );
  }
}
