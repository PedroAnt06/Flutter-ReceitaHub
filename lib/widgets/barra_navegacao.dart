import 'package:flutter/material.dart';

import '../theme/cores.dart';

// barra de navegacao la de baixo (Explorar e Favoritos)
// Pertence ao scaffold da tela, la ela é usada no bottomNavigationBar
class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: white,
      indicatorColor: secondary, //cor da aba da navbar selecionada
      selectedIndex: 0, //diz qual aba está selecionada no momento 0 é a primeira

      //aqui serão controladas as outras telas no futuro
      onDestinationSelected: (index){
        print('Aba clicada: $index');
      },

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
