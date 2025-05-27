```mermaid

erDiagram
    BioProject ||--o{ BioSample : contains
    BioSample ||--o{ Assembly : generates
    Assembly ||--|| Genome : produces
    Genome ||--o{ Sequence : composed_of
    Genome ||--o{ Annotation : has
    Sequence ||--o{ Read : derived_from
    Annotation ||--o{ Gene : includes
    Gene ||--o{ Protein : encodes
    Gene ||--o{ RNA : transcribes
    Protein ||--o{ GO_Term : associated_with
    Protein ||--o{ EC_Number : classified_by

    BioProject {
        string project_id PK
        string title
        string organism
        string description  -- Refers to the enzyme's function or classification
    }

    BioSample {
        string sample_id PK
        string bioproject_id FK
        string organism
        string isolation_source
        string geo_location
    }

    Assembly {
        string assembly_id PK
        string sample_id FK
        string method
        string quality
        date assembly_date
    }

    Genome {
        string genome_id PK
        string assembly_id FK
        string organism
        string genome_type  -- e.g. draft (incomplete genome with gaps), complete (fully sequenced genome)
        string topology      -- DNA topology: linear or circular
    }

    Sequence {
        string sequence_id PK
        string genome_id FK
        int length
        string accession
        string type  -- e.g. chromosome, plasmid, contig, or scaffold
    }

    Read {
        string read_id PK
        string sequence_id FK
        string technology
        int length
    }

    Annotation {
        string annotation_id PK
        string genome_id FK
        string tool
        date date_annotated
    }

    Gene {
        string gene_id PK
        string annotation_id FK
        string locus_tag
        string product
        int start
        int end
        char strand_orientation  -- '+' for forward strand, '-' for reverse strand
    }

    Protein {
        string protein_id PK
        string gene_id FK
        string name
        string function  -- Refers to the biological function of the protein
    }

    RNA {
        string rna_id PK
        string gene_id FK
        string rna_type  -- e.g., mRNA, tRNA, rRNA
    }

    GO_Term {
        string go_id PK
        string description
    }

    EC_Number {
        string ec_id PK
        string description
    }
```