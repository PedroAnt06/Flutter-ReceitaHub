import 'package:flutter/material.dart';

import 'screens/tela_inicial.dart';
import 'theme/cores.dart';

// app começa
void main() {
  runApp(const MeuApp());
}

// O app inteiro: define o tema e qual tela aparece primeiro.
// a tela em si esta em screens/tela_inicial.dart
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
