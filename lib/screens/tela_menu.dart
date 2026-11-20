import 'package:flutter/material.dart';
import 'package:receita_hub/screens/tela_pesquisa.dart';

import '../theme/cores.dart';
import 'tela_carregando.dart';
import 'tela_detalhe.dart';
import 'tela_erro.dart';
import 'tela_nenhum_favorito.dart';
import 'tela_nenhum_resultado.dart';
import 'tela_validacao.dart';

// lista com todas as telas, clicou em uma ela abre
// serve pra ver o layout de cada tela (principalmente as de estado: carregando, erro...)
// cada item repete o mesmo jeito: ListTile + Navigator.push
class TelaMenu extends StatelessWidget {
  const TelaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todas as telas',
          style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        backgroundColor: background,
        iconTheme: IconThemeData(color: primary), // cor da setinha de voltar
      ),

      body: ListView(
        children: [
          ListTile(
            title: Text('Pesquisar receitas'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaPesquisa()));
            },
          ),
          ListTile(
            title: Text('Detalhe da receita'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaDetalhe()));
            },
          ),
          ListTile(
            title: Text('Carregando'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaCarregando()));
            },
          ),
          ListTile(
            title: Text('Erro de conexão'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaErro()));
            },
          ),
          ListTile(
            title: Text('Nenhum resultado'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaNenhumResultado()));
            },
          ),
          ListTile(
            title: Text('Nenhum favorito'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaNenhumFavorito()));
            },
          ),
          ListTile(
            title: Text('Validação do campo'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaValidacao()));
            },
          ),
        ],
      ),
    );
  }
}
