```mermaid
erDiagram
    ISOLADO ||--o{ SEQUENCIAMENTO : CONTEM
    SEQUENCIAMENTO ||--o{ MONTAGEM : GERA
    MONTAGEM ||--o{ ANOTACAO_FUNCIONAL : GERA

    ISOLADO {
        int id PK
        int amostra_id
        string plataforma
        string tipo_leitura
        text caminho_arquivo
        date data_submissao
    }

    SEQUENCIAMENTO {
        int id PK
        int amostra_id
        string plataforma
        string tipo_leitura
        text caminho_arquivo
        date data_submissao
    }

    MONTAGEM {
        int id PK
        int sequenciamento_id FK
        string software_usado
        string tipo_montagem
        text caminho_arquivo
        float metrica_n50
        int contigs
    }

    ANOTACAO_FUNCIONAL {
        int id PK
        int montagem_id FK
        string ferramenta
        string tipo_anotacao
        string gene_id
        text funcao_prevista
    }

graph LR
    A[Sequenciamento] --> B[Montagem Genômica]
    B --> C[Anotação Funcional]

```