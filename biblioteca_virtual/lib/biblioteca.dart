import 'livro.dart';

class Biblioteca {
  final List<Livro> _livros = [];

  // Cadastrar livro
  void adicionarLivro(Livro livro) {
    _livros.add(livro);
    print('Livro "${livro.titulo}" adicionado com sucesso!');
  }

  // Remover livro por ID
  void removerLivroPorId(String id) {
    _livros.removeWhere((livro) => livro.id == id);
    print('Livro com ID $id removido (se existia).');
  }

  // Listar todos os livros
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
