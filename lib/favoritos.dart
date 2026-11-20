// aqui ficam as receitas favoritas
// como a lista esta fora de qualquer tela, todas as telas que importam esse arquivo enxergam a mesma
// fica so na memoria: ao fechar o app a lista volta a ficar vazia
List favoritas = [];

// diz se a receita ja esta nos favoritos
// compara pelo id porque a API pode mandar a mesma receita de novo (outro objeto, mesmo id)
// any = "alguma da lista": da true se encontrar pelo menos uma com o mesmo id
bool ehFavorita(Map receita) {
  return favoritas.any((favorita) => favorita['id'] == receita['id']);
}

// clicou no coracao: se ja era favorita tira da lista, se nao era coloca
void alternarFavorita(Map receita) {
  if (ehFavorita(receita)) {
    favoritas.removeWhere((favorita) => favorita['id'] == receita['id']);
  } else {
    favoritas.add(receita);
  }
}
