import 'package:flutter/material.dart';

import '../data/receitas.dart';
import '../theme/cores.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_busca.dart';
import '../widgets/card_receita.dart';
import '../widgets/carregando_receitas.dart';
import '../widgets/estado_mensagem.dart';
import 'tela_pesquisa.dart';

// mude para true se quiser ver a tela de erro de conexao
bool simularErro = false;

// tela Explorar (primeira aba do app)
// mostra a lista de receitas e leva pra tela de pesquisa e pro detalhe
// StatefulWidget = tela que pode mudar (carregando, erro, lista pronta...)
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key}); //construtor para chamar na classe acima

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

// Aqui fica a "memória" da tela e a lógica dela
class _TelaInicialState extends State<TelaInicial> {
  final _controller = TextEditingController(); // le o que foi digitado no campo
  bool _carregando = true; // true = mostra a tela de carregando
  bool _deuErro = false; // true = mostra a tela de erro

  @override
  void initState() {
    super.initState();
    _esperar(); // assim que a tela abre comeca a "carregar"
  }

  @override
  void dispose() {
    _controller.dispose(); // libera o controller quando a tela fecha
    super.dispose();
  }

  // finge uma espera de internet: depois de 1 segundo termina de carregar
  // Future.delayed roda o que esta dentro das chaves depois do tempo passar
  void _esperar() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return; // se a tela ja fechou nao faz nada
      setState(() {
        _carregando = false;
        _deuErro = simularErro; // se simularErro for true, cai na tela de erro
      });
    });
  }

  // botao "Tentar novamente": volta pra carregando e espera de novo
  void _tentarNovamente() {
    setState(() {
      _carregando = true;
      _deuErro = false;
    });
    _esperar();
  }

  // abre a tela de pesquisa levando o que foi digitado
  void _abrirPesquisa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPesquisa(termoInicial: _controller.text),
      ),
    ).then((_) => setState(() {})); // quando voltar, redesenha (os coracoes podem ter mudado)
  }

  // decide o que aparece embaixo do titulo: carregando, erro ou a lista
  Widget _conteudo() {
    // 1) ainda carregando (widgets/carregando_receitas.dart)
    if (_carregando) {
      return const CarregandoReceitas();
    }

    // 2) deu erro (widgets/estado_mensagem.dart)
    if (_deuErro) {
      return EstadoMensagem(
        icone: Icons.error_outline,
        titulo: 'Não foi possível carregar as receitas.',
        mensagem: 'Verifique sua conexão e tente novamente.',
        textoBotao: 'Tentar novamente',
        onBotao: _tentarNovamente,
      );
    }

    // 3) deu certo: mostra o campo, o botao e a lista de receitas
    return Column(
      spacing: 16, // espacamento entre os itens dessa coluna
      crossAxisAlignment: CrossAxisAlignment.start, // alinha os filhos no eixo oposto ao fluxo principal do layout
      children: [

        // campo de texto (widgets/campo_busca.dart)
        // aqui nao valida nada, quem valida é a tela de pesquisa
        CampoBusca(
          controller: _controller,
          erro: null,
          onPesquisar: _abrirPesquisa,
        ),

        // botao de buscar (widgets/botao_principal.dart)
        BotaoPrincipal(texto: 'Buscar Receitas', onPressed: _abrirPesquisa),

        Text(
            'Receitas disponíveis',
            style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
        ),

        Text(
            'Selecione uma receita para ver o preparo.',
            style: TextStyle(fontSize: 14, color: grey)
        ),

        // um cartao pra cada receita da lista (widgets/card_receita.dart)
        // setState vazio so serve pra redesenhar a tela
        for (final receita in receitas)
          CardReceita(
            receita: receita,
            onMudou: () => setState(() {}),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ReceitaHub',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
      ),

      // SingleChildScrollView deixa a tela rolar quando o conteudo nao cabe
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
        child:

        Column(
          spacing: 16, // espacamento entre os itens dessa coluna
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Receitas',
                style: TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.w600)
            ),
            Text(
                'Pesquise uma receita pelo nome.',
                style: TextStyle(fontSize: 14, color: grey)
            ),

            // o resto muda conforme o estado (carregando, erro ou lista)
            _conteudo(),
          ],
        ),

      ),
    );
  }
}
