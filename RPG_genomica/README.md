# BacMap - Pipeline para criação de banco de dados genômico a partir da montagem e anotação de genomas 

## Considerações iniciais

Eu desenvolvi um pipeline piloto de análises de bioinformática para uma empresa de Biotecnologia brasileira. Atualmente, o projeto está na sua segunda fase de desenvolvimento. A partir deste projeto desenvolvi a implementação do sistema para a disciplina de Projeto ecnológico do curso de Análise e Desenvolvimento de Sistemas. A ferramenta foi construida para execução em terminal linux.

## Funcionamento da ferramenta

INPUT:
- ENTRADA deve conter as pastas com os arquivos provenientes de sequenciamento de DNA
- Tabela_inicial deve conter o código externo (nome das pastas), o código interno (nome das amostras) e dados referentes a forma de sequenciamento de DNA.

EXECUÇÃO:
- O script BacMap_pipeline.sh deve ser executado dentro da sua pasta de origem (RPG_genomica) para configuração dos ambientes e programas necessários.
- Dados de testes já estão prontos, sendo necessária apenas a execução do script.

OUTPUT:
- Bancos de dados para identificação correta dos arquivos e organização em diretórios automaticamente

## Considerações finais

TEMPO DE EXECUÇÃO
- A etapa de montagem foi implementada totalmente. Enquanto a etapa de anotação não foi implementada devida a alta demanda computacional considerando computadores de uso doméstico. Neste caso, a perspectiva é a implementação da anotação funcional e de um painél para visualização e exportação dos dados.

## Contato
- bryan.ar.tavares@gmail.com