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

void main(List<String> arguments) {
  print('Hello world: ${bibliodart_app.calculate()}!');
}
