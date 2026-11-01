# ReceitaHub

Aplicativo mobile de receitas feito em **Flutter**. Permite pesquisar receitas pelo nome, ver o modo de preparo e salvar as favoritas.

> Projeto de estudo e portfólio. O layout foi baseado em um guia visual de 9 telas, reproduzido passo a passo.

## Telas

| Explorar | Pesquisar | Detalhe da receita |
| :---: | :---: | :---: |
| <img width="447" height="796" alt="image" src="https://github.com/user-attachments/assets/8738d1f3-34db-40bc-b3ea-73a3449cd891" />
| ![Pesquisar](docs/screenshots/pesquisar.png) | ![Detalhe](docs/screenshots/detalhe.png) |

| Favoritos | Carregando | Erro de conexão |
| :---: | :---: | :---: |
| ![Favoritos](docs/screenshots/favoritos.png) | ![Carregando](docs/screenshots/carregando.png) | ![Erro](docs/screenshots/erro.png) |

| Nenhum resultado | Nenhum favorito | Validação do campo |
| :---: | :---: | :---: |
| ![Sem resultado](docs/screenshots/sem-resultado.png) | ![Sem favorito](docs/screenshots/sem-favorito.png) | ![Validação](docs/screenshots/validacao.png) |

## Funcionalidades

- [ ] Tela Explorar com busca e lista de receitas
- [ ] Pesquisa por nome, com validação de campo vazio
- [ ] Estado de "nenhum resultado"
- [ ] Detalhe da receita (ingredientes e modo de preparo)
- [ ] Favoritar e desfavoritar receitas
- [ ] Tela de Favoritos, com estado vazio
- [ ] Estados de carregamento e de erro de conexão
- [ ] Navegação entre Explorar e Favoritos

## Tecnologias

- [Flutter](https://flutter.dev/) e Dart
- Material 3

## Como rodar

Pré-requisito: [Flutter instalado](https://docs.flutter.dev/get-started/install).

```bash
git clone https://github.com/PedroAnt06/Flutter-ReceitaHub
cd Receita_Hub
flutter pub get
flutter run
```

Para rodar no navegador:

```bash
flutter run -d chrome
```

## Estrutura

```
lib/
└── main.dart     # ponto de entrada e telas
test/
└── widget_test.dart
```

## Aprendizados

Neste projeto aprendi a como organizar as telas utilizando widgets, entendendo também suas funcionalidades.

## Autor

**Pedro** — [GitHub](https://github.com/PedroAnt06)
