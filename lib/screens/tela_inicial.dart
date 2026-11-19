import 'package:flutter/material.dart';

import '../theme/cores.dart';
import '../widgets/barra_navegacao.dart';
import '../widgets/botao_buscar.dart';
import '../widgets/campo_busca.dart';
import '../widgets/card_receita.dart';
import '../widgets/nao_encontrado.dart';

// tela principal do app (Explorar)
// aqui ficam a logica da pesquisa e a montagem da tela
// os pedacos visuais (campo, botao, card...) estao separados na pasta widgets
// StatefulWidget = tela que pode mudar (mostrar erro, mostrar resultado...)
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key}); //construtor para chamar na classe acima

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

// Aqui fica a "memória" da tela e a lógica dela
class _TelaInicialState extends State<TelaInicial> {
  final _controller = TextEditingController(); // le o que foi digitado no campo
  String? _erro; // mensagem de erro (null = sem erro)
  String? _termo; // termo valido pesquisado (null = nada pesquisado ainda)
  bool _encontrou = false; // true = a receita provisoria combina com o termo
  final _foco = FocusNode(); // permite colocar o cursor no campo pelo codigo

  @override
  void dispose() {
    _controller.dispose(); // libera o controller quando a tela fecha
    _foco.dispose();
    super.dispose();
  }

  // roda quando clica em "Buscar Receitas" ou aperta Enter
  void _pesquisar() {
    // tira espacos do comeco/fim e junta espacos repetidos do meio
    final texto = _controller.text.trim().split(RegExp(r'\s+')).join(' ');

    // consulta vazia ou so com espacos: mostra erro e NAO pesquisa
    if (texto.isEmpty) {
      setState(() {
        _erro = 'Digite o nome de uma receita. Exemplo: Sopa de Lobo.';
        _termo = null;
        _encontrou = false;
      });
      return;
    }

    // consulta valida: limpa o erro e guarda o termo
    setState(() {
      _erro = null;
      _termo = texto;
      // compara em minusculas para 'SOPA' achar 'Sopa de Lobo'
      _encontrou = 'sopa de lobo'.contains(texto.toLowerCase()); //ainda deixei o card local
    });
  }

  // botao "Alterar pesquisa": poe o cursor no campo e seleciona o texto
  void _alterarPesquisa() {
    _foco.requestFocus();
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  // botao "Ver todas as receitas": limpa a pesquisa e volta para a lista
  void _verTodas() {
    _controller.clear();
    setState(() {
      _termo = null;
      _encontrou = false;
    });
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

      body: Padding(
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

            // campo de texto (widgets/campo_busca.dart)
            // passa o que ele precisa: controller, foco, erro e o que fazer no Enter
            CampoBusca(
              controller: _controller,
              foco: _foco,
              erro: _erro,
              onPesquisar: _pesquisar,
            ),

            // botao de buscar (widgets/botao_buscar.dart)
            BotaoBuscar(onPressed: _pesquisar),

            // pesquisou e nao achou: mostra a tela de "Nenhum resultado"
            // senao: mostra a lista normal (com o termo, se tiver pesquisado)
            if (_termo != null && !_encontrou)
              // o ! diz pro dart que aqui o _termo nao é null (o if de cima ja garantiu)
              NaoEncontrado(termo: _termo!, onVerTodas: _verTodas)
            else ...[

            // so aparece quando existe um termo valido
            if (_termo != null)
              Text(
                'Resultados para "$_termo"',
                style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600),
              ),

            Text(
                'Receitas disponíveis',
                style: TextStyle(fontSize: 18, color: primary, fontWeight: FontWeight.w600)
            ),

            Text(
                'Selecione uma receita para ver o preparo.',
                style: TextStyle(fontSize: 14, color: grey)
            ),

            // cartao da receita (widgets/card_receita.dart)
            const CardReceita(),
            ], // fim do "else ...[" da lista normal
          ],
        ),

      ),

      //Pertence ao scaffold tambem, sendo do scafold (appbar, body e bottomnavigationbar)
      bottomNavigationBar: const BarraNavegacao(),
    );
  }
}
