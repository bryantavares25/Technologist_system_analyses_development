import 'package:biblioteca_virtual/biblioteca.dart';
import 'package:biblioteca_virtual/livro.dart';

void main() {
  Biblioteca minhaBiblioteca = Biblioteca();

  // Cadastrar livros
  minhaBiblioteca.adicionarLivro(
    Livro(
      id: '1',
      titulo: 'Dom Casmurro',
      autor: 'Machado de Assis',
      ano: 1899,
      genero: 'Romance',
    ),
  );

  minhaBiblioteca.adicionarLivro(
    Livro(
      id: '2',
      titulo: '1984',
      autor: 'George Orwell',
      ano: 1949,
      genero: 'Distopia',
    ),
  );

  // Listar livros
  minhaBiblioteca.listarLivros();

  // Remover livro
  minhaBiblioteca.removerLivroPorId('1');

  // Listar livros após remoção
  minhaBiblioteca.listarLivros();
}
