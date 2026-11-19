import '../models/receita.dart';

// dados provisorios, depois podem vir de uma API ou de um banco de dados
// todas as telas usam essa mesma lista, por isso o favorito de uma tela aparece nas outras
final receitas = [
  Receita(
    nome: 'Sopa de Lobo',
    descricao: 'Uma sopa muito saborosa, famosa no desenho animado pica-pau delobo kk, e isso é maravilhosamente extraordinariamente gostoso',
    tempo: 59,
    porcoes: 4,
    ingredientes: ['Batata', 'Cenoura', 'Cebola', 'Caldo de legumes'],
    passos: [
      'Pique os legumes em cubos.',
      'Refogue a cebola em uma panela.',
      'Adicione os legumes e o caldo e cozinhe por 40 minutos.',
    ],
  ),
  Receita(
    nome: 'Classic Margherita Pizza',
    descricao: 'Pizza italiana simples, com molho de tomate e muçarela fresca.',
    tempo: 35,
    porcoes: 4,
    ingredientes: ['Massa de pizza', 'Molho de tomate', 'Muçarela fresca'],
    passos: [
      'Preaqueça o forno a 245 °C.',
      'Abra a massa e espalhe o molho de tomate.',
      'Distribua a muçarela e asse por 10 a 12 minutos.',
    ],
  ),
  Receita(
    nome: 'Bolo de Cenoura',
    descricao: 'Bolo fofinho de cenoura com cobertura de chocolate.',
    tempo: 50,
    porcoes: 8,
    ingredientes: ['Cenoura', 'Ovos', 'Farinha de trigo', 'Açúcar', 'Chocolate'],
    passos: [
      'Bata a cenoura, os ovos e o óleo no liquidificador.',
      'Misture com a farinha e o açúcar e leve ao forno por 40 minutos.',
      'Cubra com a calda de chocolate.',
    ],
  ),
];
