import 'package:flutter/material.dart';

import '../theme/cores.dart';
import 'tela_favoritos.dart';
import 'tela_inicial.dart';
import 'tela_menu.dart';

// tela principal: tem a appbar e a navbar, e troca o corpo da tela quando clica na aba
// as outras telas so tem o layout (o corpo), quem controla a navegacao é essa
// StatefulWidget porque a aba selecionada muda
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key}); //construtor para chamar na classe acima

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indice = 0; // diz qual aba está selecionada no momento, 0 é a primeira (Explorar)

  // as telas de cada aba, na mesma ordem da navbar
  // posicao 0 = Explorar, posicao 1 = Favoritos
  final List<Widget> _telas = [
    const TelaInicial(),
    const TelaFavoritos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ReceitaHub',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,

        // botao do canto que abre a lista com todas as telas
        actions: [
          IconButton(
            icon: Icon(Icons.apps, color: primary),
            onPressed: () {
              // Navigator.push coloca a tela nova por cima da atual
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaMenu()),
              );
            },
          ),
        ],
      ),

      // mostra a tela da aba atual (a posicao da lista é o _indice)
      body: _telas[_indice],

      //Pertence ao scaffold tambem, sendo do scafold (appbar, body e bottomnavigationbar)
      bottomNavigationBar: NavigationBar(
        backgroundColor: white,
        indicatorColor: secondary, //cor da aba da navbar selecionada
        selectedIndex: _indice, //diz qual aba está selecionada no momento 0 é a primeira

        //clicou numa aba: guarda o numero dela no _indice e o setState redesenha a tela
        onDestinationSelected: (index){
          setState(() {
            _indice = index;
          });
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
      ),
    );
  }
}
