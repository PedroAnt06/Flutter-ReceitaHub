import 'package:flutter/material.dart';

import '../widgets/barra_navegacao.dart';
import 'tela_favoritos.dart';
import 'tela_inicial.dart';

// tela que segura a barra de navegacao la de baixo e troca entre as abas
// Explorar (TelaInicial) e Favoritos (TelaFavoritos)
// as telas de pesquisa e detalhe abrem por cima dela com Navigator.push
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indice = 0; // aba atual (0 = Explorar, 1 = Favoritos)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack mantem as duas telas e so mostra a que esta no indice
      // assim ao voltar pra aba Explorar ela nao "carrega" tudo de novo
      // as telas estao sem const de proposito, assim elas se redesenham quando troca de aba
      // (e os coracoes aparecem atualizados)
      body: IndexedStack(
        index: _indice,
        children: [
          TelaInicial(),
          // o botao da tela de favoritos vazia volta pra primeira aba
          TelaFavoritos(onExplorar: () => setState(() => _indice = 0)),
        ],
      ),

      //Pertence ao scaffold tambem, sendo do scafold (appbar, body e bottomnavigationbar)
      // clicou numa aba: guarda o novo indice e redesenha (setState)
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: _indice,
        onSelecionar: (i) => setState(() => _indice = i),
      ),
    );
  }
}
