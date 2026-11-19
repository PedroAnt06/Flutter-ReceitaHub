import 'package:flutter/material.dart';

import '../data/receitas.dart';
import '../models/receita.dart';
import '../theme/cores.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_busca.dart';
import '../widgets/card_receita.dart';
import '../widgets/nao_encontrado.dart';

// tela Pesquisar receitas
// abre quando clica em "Buscar Receitas" na tela Explorar
// aqui ficam a validacao do campo e o resultado da pesquisa
class TelaPesquisa extends StatefulWidget {
  final String termoInicial; // o que foi digitado na tela Explorar

  const TelaPesquisa({super.key, required this.termoInicial});

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  final _controller = TextEditingController(); // le o que foi digitado no campo
  String? _erro; // mensagem de erro (null = sem erro)
  String _termo = ''; // termo valido pesquisado ('' = nada pesquisado ainda)
  List<Receita> _resultados = []; // receitas que combinam com o termo

  @override
  void initState() {
    super.initState();
    _controller.text = widget.termoInicial; // comeca com o texto da tela Explorar
    _buscar(); // ja pesquisa o que veio de la (se veio vazio mostra o erro)
  }

  @override
  void dispose() {
    _controller.dispose(); // libera o controller quando a tela fecha
    super.dispose();
  }

  // faz a validacao e a busca, mas nao redesenha a tela (quem redesenha é o _pesquisar)
  void _buscar() {
    // tira espacos do comeco/fim e junta espacos repetidos do meio
    final texto = _controller.text.trim().split(RegExp(r'\s+')).join(' ');

    // consulta vazia ou so com espacos: mostra erro e NAO pesquisa
    if (texto.isEmpty) {
      _erro = 'Digite o nome de uma receita. Exemplo: Sopa de Lobo.';
      _termo = '';
      _resultados = [];
      return;
    }

    // consulta valida: limpa o erro, guarda o termo e filtra as receitas pelo nome
    // toLowerCase deixa tudo em minusculo pra 'SOPA' achar 'Sopa de Lobo'
    _erro = null;
    _termo = texto;
    _resultados = receitas
        .where((r) => r.nome.toLowerCase().contains(texto.toLowerCase()))
        .toList();
  }

  // roda quando clica em "Pesquisar" ou aperta Enter
  void _pesquisar() {
    setState(() {
      _buscar(); // faz a busca e o setState redesenha a tela
    });
  }

  // botao "Limpar pesquisa": limpa o campo e volta pro comeco
  void _limpar() {
    _controller.clear();
    setState(() {
      _erro = null;
      _termo = '';
      _resultados = [];
    });
  }

  // decide o que aparece embaixo do botao: dica, nenhum resultado ou a lista
  Widget _resultado() {
    // 1) ainda nao pesquisou
    if (_termo.isEmpty) {
      return Text(
        'Você pode buscar por parte do nome da receita.',
        style: TextStyle(fontSize: 14, color: grey),
      );
    }

    // 2) pesquisou e nao achou nada (widgets/nao_encontrado.dart)
    // "Ver todas as receitas" volta pra tela Explorar (pop fecha essa tela)
    if (_resultados.isEmpty) {
      return NaoEncontrado(
        termo: _termo,
        onVerTodas: () => Navigator.pop(context),
      );
    }

    // 3) achou: mostra o termo e um cartao pra cada resultado
    return Column(
      spacing: 16, // espacamento entre os itens dessa coluna
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resultados para "$_termo"',
          style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600),
        ),
        Text(
          'Toque na receita para ver o preparo.',
          style: TextStyle(fontSize: 14, color: grey),
        ),

        // um cartao pra cada resultado
        for (final receita in _resultados)
          CardReceita(
            receita: receita,
            onMudou: () => setState(() {}), // setState vazio so serve pra redesenhar
          ),

        // botao com so a borda (OutlinedButton)
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton(
            onPressed: _limpar,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar receitas', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: primary, // cor do titulo e da seta de voltar (a seta aparece sozinha)
        backgroundColor: background,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child: Column(
          spacing: 16, // espacamento entre os itens dessa coluna
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // so aparece quando ainda nao tem pesquisa valida
            if (_termo.isEmpty)
              Text(
                'Qual receita você procura?',
                style: TextStyle(fontSize: 24, color: primary, fontWeight: FontWeight.bold),
              ),

            // campo de texto (widgets/campo_busca.dart), aqui mostra o erro
            CampoBusca(
              controller: _controller,
              erro: _erro,
              onPesquisar: _pesquisar,
            ),

            BotaoPrincipal(texto: 'Pesquisar', onPressed: _pesquisar),

            // o resto muda conforme a pesquisa
            _resultado(),
          ],
        ),
      ),
    );
  }
}
