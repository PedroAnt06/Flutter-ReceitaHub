import 'package:flutter/material.dart';

import '../models/receita.dart';
import '../screens/tela_detalhe.dart';
import '../theme/cores.dart';

// cartao que mostra uma receita (foto, nome, descricao, tempo e coracao)
// clicar no cartao abre o detalhe, clicar no coracao favorita
class CardReceita extends StatelessWidget {
  final Receita receita;
  // avisa a tela que algo mudou (favoritou ou voltou do detalhe)
  // a tela entao se redesenha com setState pra atualizar os coracoes
  final VoidCallback onMudou;

  const CardReceita({super.key, required this.receita, required this.onMudou});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      clipBehavior: Clip.antiAlias, // faz o efeito do clique respeitar a borda arredondada
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: grey),
      ),

      // InkWell deixa o card clicavel
      child: InkWell(
        onTap: () {
          // abre o detalhe por cima da tela atual
          // o then roda quando o detalhe fecha (voltar), ai avisa a tela pra se redesenhar
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaDetalhe(receita: receita)),
          ).then((_) => onMudou());
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
                      Text(
                        receita.nome,
                        style: const TextStyle(fontSize: 16, color: secondary, fontWeight: FontWeight.bold ),
                      ),
                      Text(
                        receita.descricao,
                        style: const TextStyle(fontSize: 13, color: grey ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, //Acima de 2 linhas coloca o '...'
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          const Icon(Icons.access_time, size: 14, color: primary,),
                          Text(
                              '${receita.tempo} min',
                              style: const TextStyle(fontSize: 12, color: primary),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          const Spacer(), // TEntei envolver o icone no expanded mas não foi muito eficaz o spacer criou o espaço vazio melhor

                          // coracao: clicou, inverte o favorita (true vira false e false vira true)
                          IconButton(
                            onPressed: () {
                              receita.favorita = !receita.favorita;
                              onMudou(); // avisa a tela pra redesenhar
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(), // tira o tamanho minimo padrao do botao
                            icon: Icon(
                              // coracao cheio = favorita, so o contorno = nao favorita
                              receita.favorita ? Icons.favorite : Icons.favorite_border_outlined,
                              size: 20,
                              color: primary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ))

            ],
          ),
        ),
      ),
    );
  }
}
