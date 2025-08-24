import 'package:bibliodart_app/bibliodart_app.dart' as bibliodart_app;

class Livro {
  //Atributos
  String titulo;
  String autor;
  int anoPublicacao;

  Livro(this.titulo, this.autor, this.anoPublicacao);

  void exibirdetalhes() {
    print("=== Detalhes do Livro ===");
    print('Título: $titulo');
    print('Autor: $autor');
    print('Ano de Publicação: $anoPublicacao');
    print("==========================");
  }
}

class BibliotecaVirtual {
  List<Livro> livros = [];

  void adicionarlivro(Livro livro) {
    livros.add(livro);
    print('Livro "${livro.titulo}" adicionado à biblioteca.');
  }

  void removerLivro(String titulo) {
    livros.removeWhere((livro) => livro.titulo == titulo);
    print('Livro "$titulo" removido da biblioteca.');
  }

  void listarlivros() {
    if (livros.isEmpty) {
      print('Nenhum livro na biblioteca.');
      return;
    }
    print('=== Livros na Biblioteca ===');
    for (var livro in livros) {
      livro.exibirdetalhes();
    }
    print('============================');
  }
}

void main(List<String> arguments) {
  // Entrada
  print('Hello world: ${bibliodart_app.calculate()}!');
  print("=== Bem-vindo à Biblioteca Virtual ===");

  // Declaração da biblioteca
  final biblioteca = BibliotecaVirtual();

  // Adicionando livros
  biblioteca.adicionarlivro(Livro('1984', 'George Orwell', 1949));
  biblioteca.adicionarlivro(Livro('To Kill a Mockingbird', 'Harper Lee', 1960));
  biblioteca.adicionarlivro(
    Livro('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
  );

  // Listando livros
  biblioteca.listarlivros();
  // Removendo um livro
  biblioteca.removerLivro('1984');
  // Listando livros novamente
  biblioteca.listarlivros();

  // Saindo
  print("=== Obrigado por usar a Biblioteca Virtual! ===");
}
