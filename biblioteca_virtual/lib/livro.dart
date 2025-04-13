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
