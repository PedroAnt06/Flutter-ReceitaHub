import 'package:flutter/material.dart';

import '../theme/cores.dart';

// campo de texto onde digita o nome da receita
// ele nao guarda nada sozinho, tudo que ele precisa vem de fora da tela
// por isso é StatelessWidget (nao muda por conta propria)
class CampoBusca extends StatelessWidget {
  final TextEditingController controller; // le o que foi digitado no campo
  final String? erro; // mensagem de erro (null = sem erro)
  final VoidCallback onPesquisar; // o que fazer quando apertar Enter

  // required = é obrigatorio passar esse valor quando usar o CampoBusca
  const CampoBusca({
    super.key,
    required this.controller,
    required this.erro,
    required this.onPesquisar,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // liga o campo ao controller
      onSubmitted: (_) => onPesquisar(), // Enter no teclado tambem pesquisa
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        labelText: 'Nome da receita', // rotulo do campo
        errorText: erro, // mostra o erro embaixo do campo (null = some)
        hintText: 'Ex.: Sopa de Lobo', //placeholder
        hintStyle: const TextStyle(color:grey),
        prefixIcon: const Icon(Icons.search, color: primary,),
        fillColor: white, //cor do fundo do campo
        floatingLabelStyle: const TextStyle(
          color: primary, // é acor do titulo do campo quando ativo
        ),
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
    );
  }
}
