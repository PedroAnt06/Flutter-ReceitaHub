import 'package:flutter/material.dart';
import 'package:receita_hub/request.dart';
import 'package:receita_hub/screens/tela_pesquisa.dart';
import '../theme/cores.dart';


// aba Explorar: so o corpo da tela, a appbar e a navbar ficam na tela principal
// agora é StatefulWidget porque a tela muda: carregando, erro ou lista de receitas
class TelaInicial extends StatefulWidget{
  const TelaInicial({super.key}); //construtor para chamar na classe acima

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool _carregando = true; // true = ainda esperando a API responder
  String? _erro; // mensagem de erro (null = deu tudo certo)
  List _receitas = []; // as receitas que vieram da API

  // initState roda uma vez, quando a tela abre: ja vai buscar as receitas
  @override
  void initState() {
    super.initState();
    _carregar();
  }

  // chama a funcao do arquivo request.dart e guarda o resultado
  // o await espera a resposta chegar, ai o setState redesenha a tela
  Future<void> _carregar() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });

    final resposta = await buscarReceitas();

    setState(() {
      _carregando = false;
      _erro = resposta.erro;
      _receitas = resposta.receitas;
    });
  }

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

            // 1) esperando a API: bolinha girando e um texto
            // o Center coloca no meio da tela
            if (_carregando)
              Center(
                child: Column(
                  spacing: 16,
                  children: [
                    CircularProgressIndicator(color: primary), // bolinha girando
                    Text(
                        'Carregando receitas...',
                        style: TextStyle(fontSize: 14, color: grey)
                    ),
                  ],
                ),
              ),

            // 2) deu erro ou veio vazio: mostra a mensagem que veio do request.dart e o botao
            if (_erro != null)
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
                      child: const Icon(Icons.error_outline, size: 48, color: primary),
                    ),

                    Text(
                        _erro!, // o ! diz pro dart que aqui o _erro nao é null (o if de cima ja garantiu)
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: primary, fontWeight: FontWeight.bold)
                    ),

                    // clicou: chama a API de novo
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        onPressed: _carregar,
                        style: FilledButton.styleFrom(
                            backgroundColor: primary,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        child: const Text(
                          'Tentar novamente',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 3) deu certo: um card pra cada receita da lista
            // quando esta carregando ou deu erro a lista esta vazia, entao nao aparece nada
            for (final receita in _receitas)
              Card(
                color: white,
                clipBehavior: Clip.antiAlias, // a foto fica dentro da borda arredondada
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: grey),
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
                  child: Row(
                    spacing: 16, // Espaço entre a foto e os textos
                    children: [

                      //Foto da receita (vem da API pelo endereco que esta em receita['image'])
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          receita['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover, // a foto preenche o quadrado sem esticar
                          // se a foto nao carregar mostra o iconzinho de antes
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

                      //Parte dos textos, que o expanded como mostrado em aula pega todo o espaço que está restante
                      Expanded(
                          child: Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start, // alinha os filhos no eixo oposto ao fluxo principal do layout
                            children: [
                              Text(
                                receita['name'], // nome da receita
                                style: TextStyle(fontSize: 16, color: secondary, fontWeight: FontWeight.bold ),
                              ),
                              Text(
                                '${receita['cuisine']} • ${receita['difficulty']}', // ex.: Italian • Easy
                                style: TextStyle(fontSize: 13, color: grey ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, //Acima de 2 linhas coloca o '...'
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  Icon(Icons.access_time, size: 14, color: primary,),
                                  Text(
                                      // tempo total = preparo + cozimento
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
                                      '${receita['rating']}', // nota da receita
                                      style: TextStyle(fontSize: 12, color: primary),
                                  ),
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
          ],
        ),

    );
  }
}
