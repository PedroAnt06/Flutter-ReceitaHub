import 'package:flutter/material.dart';
import 'package:receita_hub/favoritos.dart';
import 'package:receita_hub/screens/tela_detalhe.dart';
import 'package:receita_hub/request.dart';
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

  final _controller = TextEditingController(); // le o que foi digitado no campo
  String? _erroBusca; // mensagem de erro do campo (null = sem erro)
  String? _termo; // termo valido pesquisado (null = nada pesquisado ainda)

  // initState roda uma vez, quando a tela abre: ja vai buscar as receitas
  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    _controller.dispose(); // libera o controller quando a tela fecha
    super.dispose();
  }

  // roda quando clica em "Buscar Receitas" ou aperta Enter
  void _pesquisar() {
    // tira espacos do comeco/fim e junta espacos repetidos do meio
    final texto = _controller.text.trim().split(RegExp(r'\s+')).join(' ');

    // consulta vazia ou so com espacos: mostra erro e NAO pesquisa
    if (texto.isEmpty) {
      setState(() {
        _erroBusca = 'Digite o nome de uma receita. Exemplo: Sopa de Lobo.';
        _termo = null;
      });
      return;
    }

    // consulta valida: limpa o erro e guarda o termo
    setState(() {
      _erroBusca = null;
      _termo = texto;
    });
  }

  // botao "Ver todas as receitas": limpa a pesquisa e volta para a lista
  void _verTodas() {
    _controller.clear();
    setState(() {
      _erroBusca = null;
      _termo = null;
    });
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
    // lista que aparece na tela: todas as receitas, ou so as que tem o termo pesquisado no nome
    // toLowerCase deixa tudo em minusculo pra 'SOPA' achar 'Sopa de Lobo'
    final lista = _termo == null
        ? _receitas
        : _receitas.where((r) => r['name'].toString().toLowerCase().contains(_termo!.toLowerCase())).toList();

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
              controller: _controller, // liga o campo ao controller
              onSubmitted: (_) => _pesquisar(), // Enter no teclado tambem pesquisa
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: 'Nome da receita', // rotulo do campo
                errorText: _erroBusca, // mostra o erro embaixo do campo (null = some)
                floatingLabelStyle: const TextStyle(color: primary), // cor do titulo do campo quando ativo
                hintText: 'Ex.: Sopa de Lobo', //placeholder
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

                onPressed: _pesquisar, // chama o metodo (sem parenteses)
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

            // se ja pesquisou mostra o termo, senao mostra o titulo da lista normal
            if (_termo != null)
              Text(
                  'Resultados para "$_termo"',
                  style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
              )
            else
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

            // 3) pesquisou e nao achou nada: mostra a tela de "Nenhum resultado"
            // so aparece se ja terminou de carregar e nao deu erro (senao a lista vazia seria culpa da API)
            if (_termo != null && lista.isEmpty && !_carregando && _erro == null)
              Center(
                child: Column(
                  spacing: 12,
                  children: [

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
                        'Não encontramos receitas para "$_termo".',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: grey)
                    ),

                    // clicou: limpa a pesquisa e volta pra lista com todas as receitas
                    TextButton(
                      onPressed: _verTodas,
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

            // 4) deu certo: um card pra cada receita da lista
            // quando esta carregando ou deu erro a lista esta vazia, entao nao aparece nada
            for (final receita in lista)
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

                                    // coracao clicavel: favorita ou desfavorita a receita
                                    // o setState redesenha a tela pra trocar o icone
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          alternarFavorita(receita);
                                        });
                                      },
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(), // tira o tamanho minimo padrao do botao
                                      icon: Icon(
                                        // coracao cheio = favorita, so o contorno = nao favorita
                                        ehFavorita(receita) ? Icons.favorite : Icons.favorite_border_outlined,
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
              ),
          ],
        ),

    );
  }
}
