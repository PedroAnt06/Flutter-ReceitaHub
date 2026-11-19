import 'package:flutter/material.dart';

import '../theme/cores.dart';

// barra de navegacao la de baixo (Explorar e Favoritos)
// Pertence ao scaffold da tela, la ela é usada no bottomNavigationBar
// quem sabe qual aba esta ativa é a TelaPrincipal, ela so recebe e avisa quando clica
class BarraNavegacao extends StatelessWidget {
  final int indiceAtual; // qual aba esta selecionada (0 = Explorar, 1 = Favoritos)
  final ValueChanged<int> onSelecionar; // avisa a tela qual aba foi clicada

  const BarraNavegacao({
    super.key,
    required this.indiceAtual,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: white,
      indicatorColor: secondary, //cor da aba da navbar selecionada
      selectedIndex: indiceAtual, //diz qual aba está selecionada no momento 0 é a primeira

      //quando clica numa aba, avisa a tela principal pra trocar de tela
      onDestinationSelected: onSelecionar,

      //aqui se define os itens que vão estar no barra de navegação por isso a lista '[]'
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.search, size: 20, color: primary),
          selectedIcon: Icon(Icons.search_outlined, size: 20, color: white),
          label: 'Explorar'),

        NavigationDestination(
            icon: Icon(Icons.favorite_outline, size: 20, color: primary),
            selectedIcon: Icon(Icons.favorite, size: 20, color: white), //muda-se o icone quando selecionado
            label: 'Favoritos'),
      ],
    );
  }
}
