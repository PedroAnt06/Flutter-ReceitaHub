import 'package:flutter/material.dart';

const primary = Color(0xFF8B0000);
const secondary = Color(0xFF8B0000);
const background = Color(0xFFF8F6EF);
const grey = Color(0xFF666B66);
const white = Color(0xFFFFFFFF);

// app começa
void main() {
  runApp(const MeuApp());
}

// O app inteiro: define o tema e qual tela aparece primeiro.
class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReceitaHub',
      theme: ThemeData(
        scaffoldBackgroundColor: background
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget{
  const TelaInicial({super.key}); //construtor para chamar na classe acima

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

                onPressed: () => print('teste'),
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

            Card(
              color: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: grey),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), //coloca esse padding nas 4 direcoes
                child: Row(
                  spacing: 16, // Espaço entre a foto e os textos
                  children: [

                    //Foto nesse container dentro dessa linha
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.restaurant)
                    ),

                    //Parte dos textos, que o expanded como mostrado em aula pega todo o espaço que está restante
                    Expanded(
                        child: Column(
                          spacing: 6,
                          crossAxisAlignment: CrossAxisAlignment.start, // alinha os filhos no eixo oposto ao fluxo principal do layout
                          children: [
                            const Text(
                              'Sopa de Lobo',
                              style: TextStyle(fontSize: 16, color: secondary, fontWeight: FontWeight.bold ),
                            ),
                            const Text(
                              'Uma sopa muito saborosa, famosa no desenho animado pica-pau delobo kk, e isso é maravilhosamente extraordinariamente gostoso',
                              style: TextStyle(fontSize: 13, color: grey ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, //Acima de 2 linhas coloca o '...'
                            ),
                            const Row(
                              spacing: 4,
                              children: [
                                Icon(Icons.access_time, size: 14, color: primary,),
                                Text(
                                    '59 min',
                                    style: TextStyle(fontSize: 12, color: primary),
                                ),
                              ],
                            ),
                            const Row(
                              spacing: 4,
                              children: [
                                Spacer(), // TEntei envolver o icone no expanded mas não foi muito eficaz o spacer criou o espaço vazio melhor
                                Icon(Icons.favorite_border_outlined, size: 20, color: primary,),
                              ],
                            )
                          ],
                        ))

                  ],
                ),
              ),
            )
          ],
        ),

      ),

      //Pertence ao scaffold tambem, sendo do scafold (appbar, body e bottomnavigationbar)
      bottomNavigationBar: NavigationBar(
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
      ),
    );
  }
}