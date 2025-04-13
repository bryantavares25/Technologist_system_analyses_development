// START

// B I B L I O T E C A  P E S S O A L

// PRINCIPAL
void main() {
  // DECLARAÇÃO
  Biblioteca minhaBiblioteca = Biblioteca();
  //AÇÃO - CADASTRAR
  minhaBiblioteca.adicionarLivro(
    Livro(
      id: '0001',
      titulo: 'Memórias Póstumas de Brás Cubas',
      autor: 'Machado de Assis',
      ano: 1899,
      genero: 'Romance',
    ),
  );
  minhaBiblioteca.adicionarLivro(
    Livro(
      id: '0010',
      titulo: 'O Diário de Anne Frank',
      autor: 'Anne Frank',
      ano: 1947,
      genero: 'Biografia',
    ),
  );

  // AÇÃO - Listar livros
  minhaBiblioteca.listarLivros();
  // AÇÃO - Remover livro
  minhaBiblioteca.removerLivroPorId('1');
  // AÇÃO - Listar livros
  minhaBiblioteca.listarLivros();
}

// CLASSE BIBLIOTECA
class Biblioteca {
  final List<Livro> _livros = [];
  // METODO - CADASTRAR
  void adicionarLivro(Livro livro) {
    _livros.add(livro);
    print('Livro "${livro.titulo}" adicionado com sucesso!');
  }

  // METODO - DESCADASTRAR
  void removerLivroPorId(String id) {
    _livros.removeWhere((livro) => livro.id == id);
    print('Livro com ID $id removido (se existia).');
  }

  // METODO - LISTAR
  void listarLivros() {
    if (_livros.isEmpty) {
      print('Nenhum livro na biblioteca.');
    } else {
      print('Livros disponíveis na biblioteca:');
      for (var livro in _livros) {
        print(livro);
      }
    }
  }
}

// CLASSE LIVRO
class Livro {
  String titulo;
  String autor;
  int ano;
  String genero;
  String id;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.ano,
    required this.genero,
  });

  @override
  String toString() {
    return 'ID: $id | "$titulo" por $autor ($ano) - Gênero: $genero';
  }
}

// END - BART
