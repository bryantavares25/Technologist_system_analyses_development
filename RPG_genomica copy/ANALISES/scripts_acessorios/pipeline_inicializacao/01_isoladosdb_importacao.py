import os
import pandas as pd
import sqlite3 as sq

def importacao_isolados_db(tabela_csv, isolados_db):

    df = pd.read_csv(tabela_csv)

    df['internal_code'] = df['internal_code'].astype(str)

    reg_codes = df['internal_code'].dropna().unique()
    iso_codes_list = []

    # Conexão ao banco de dados ISOLADOS
    dbconexao = sq.connect(isolados_db)
    cursor = dbconexao.cursor()
    for reg_code in reg_codes:
        cursor.execute("SELECT 1 FROM table_isolados WHERE isolado_reg = ?;", (reg_code,))
        if cursor.fetchone():
            print(f" > O isolado '{reg_code}' já está cadastrado no banco de dados")
        else:
            print(f" > O isolado '{reg_code}' não está cadastrado no banco de dados. Então o cadastro será realizado automaticamente.")
            try: 
                cadastro_reg_code(reg_code, cursor)
                iso_codes_list.append(reg_code)
            except Exception as e:
                print(f" > Erro: {e}")
    dbconexao.commit()
    dbconexao.close()
    # Desconexão do banco de dados ISOLADOS

    print(f" > Todos os isolados da tabela de importação de dados foram verificados. Os isolados {iso_codes_list} foram adicionados.")
    return iso_codes_list

def cadastro_reg_code(reg_code, cursor):
    try:
        cursor.execute("INSERT INTO table_isolados (isolado_reg) VALUES (?);", (reg_code,))
        print(f"   > Isolado '{reg_code}' importado com sucesso.")
        return True
    except sq.IntegrityError as e:
        print(f"   ! Erro ao inserir '{reg_code}': {e}")
        return False

def exportacao_internalcode_isoladocode(ic_list, isolado_db, entrada_csv):
    data = []
    dicio = {}
    # ARRUMAR
    dir=os.getcwd()
    dir_dados="ANALISES/Dados/"
    dir_path=os.path.join(dir, dir_dados)
    conn = sq.connect(isolado_db)
    cursor = conn.cursor()
    for ic in ic_list:
        cursor.execute("SELECT isolado_reg, isolado_code FROM table_isolados WHERE isolado_reg = ?;", (ic,))
        row = cursor.fetchone()
        if row:
            data.append({'internal_code': row[0], 'isolado_code': row[1], 'dados_caminho': f"{dir_path}{row[1]}_{row[0]}"})
            dicio[row[0]] = row[1]
        else:
            data.append({'internal_code': ic, 'isolado_code': None, 'dados_caminho': None})
    conn.close()
    # # # # #
    # Carrega o CSV existente
    df = pd.read_csv(entrada_csv)
    for item in data:
        ic = item['internal_code']
        iso_code = item.get('isolado_code')
        dados_caminho = item.get('dados_caminho')
        mask = df['internal_code'] == ic
        if mask.any():
            df.loc[mask, 'isolado_code'] = iso_code
            df.loc[mask, 'dados_caminho'] = dados_caminho
        else:
            # Se não existe, adiciona nova linha
            df = pd.concat([df, pd.DataFrame([item])], ignore_index=True)
    # Salva as alterações no mesmo arquivo
    df.to_csv(entrada_csv, index=False)
    print(f"Exportação concluída: {entrada_csv}")
    # # # # #
    return dicio

def criar_banco_isolado(local):
    schema = """
    CREATE TABLE IF NOT EXISTS isolados_genomica(
        ig_id INTEGER PRIMARY KEY AUTOINCREMENT,
        isolado_code TEXT NOT NULL UNIQUE,
        reg_code TEXT NOT NULL UNIQUE,
        dados_caminho TEXT,
        data_importacao TEXT DEFAULT CURRENT_DATE
    );
    CREATE TABLE IF NOT EXISTS sequenciados(
        sequenciado_id INTEGER PRIMARY KEY AUTOINCREMENT,
        sequenciado_code TEXT UNIQUE,
        external_code TEXT UNIQUE,
        plataforma TEXT,
        tipo_leitura TEXT,
        tipo_de_arquivos TEXT,
        isolado_code TEXT NOT NULL REFERENCES isolados(isolado_code),
        dados_caminho TEXT,
        data_importacao TEXT DEFAULT CURRENT_DATE
    );
    CREATE TABLE IF NOT EXISTS montados(
        montado_id INTEGER PRIMARY KEY AUTOINCREMENT,
        montado_code TEXT UNIQUE,
        leituras_entrada TEXT,
        pipeline_montagem TEXT,
        parametros_montagem TEXT,
        metrica_integrity INTEGER,
        metrica_completeness INTEGER,
        data_montagem TEXT,
        dados_caminho TEXT,
        isolado_code TEXT NOT NULL REFERENCES isolados(isolado_code)
    );
    CREATE TABLE IF NOT EXISTS anotados(
        anotado_id INTEGER PRIMARY KEY AUTOINCREMENT,
        anotado_code TEXT UNIQUE,
        pipeline_anotacao TEXT,
        pipeline_parametros TEXT,
        dados_caminho TEXT,
        data_importacao TEXT,
        montado_code TEXT NOT NULL UNIQUE REFERENCES montados(montado_code)
    );
    CREATE TABLE IF NOT EXISTS genes(
        gene_id INTEGER PRIMARY KEY AUTOINCREMENT,
        gene_code TEXT UNIQUE,
        gene_nome TEXT,
        gene_localizacao TEXT,
        dados_caminho TEXT,
        anotado_code TEXT NOT NULL UNIQUE REFERENCES anotados(anotado_code)
    );
    CREATE TABLE IF NOT EXISTS produtos(
        produto_id INTEGER PRIMARY KEY AUTOINCREMENT,
        produto_code TEXT UNIQUE,
        produto TEXT,
        dados_caminho TEXT,
        gene_code TEXT NOT NULL UNIQUE REFERENCES genes(gene_code)
    );
    CREATE TRIGGER IF NOT EXISTS trg_sequenciados_set_code
        AFTER INSERT ON sequenciados
        FOR EACH ROW
        BEGIN
            UPDATE sequenciados
            SET sequenciado_code = 'SEQ_' || printf('%08d', NEW.sequenciado_id)
            WHERE sequenciado_id = NEW.sequenciado_id;
        END;
    CREATE TRIGGER IF NOT EXISTS trg_montados_set_code
        AFTER INSERT ON montados
        FOR EACH ROW
        BEGIN
            UPDATE montados
            SET montado_code = 'MON_' || printf('%08d', NEW.montado_id)
            WHERE montado_id = NEW.montado_id;
        END;
    CREATE TRIGGER IF NOT EXISTS trg_anotados_set_code
        AFTER INSERT ON anotados
        FOR EACH ROW
        BEGIN
            UPDATE anotados
            SET anotado_code = 'ANO_' || printf('%08d', NEW.anotado_id)
            WHERE anotado_id = NEW.anotado_id;
        END;
    CREATE TRIGGER IF NOT EXISTS trg_genes_set_code
        AFTER INSERT ON genes
        FOR EACH ROW
        BEGIN
            UPDATE genes
            SET gene_code = 'GEN_' || printf('%08d', NEW.gene_id)
            WHERE gene_id = NEW.gene_id;
        END;
    CREATE TRIGGER IF NOT EXISTS trg_produtos_set_code
        AFTER INSERT ON produtos
        FOR EACH ROW
        BEGIN
            UPDATE produtos
            SET produto_code = 'PRO_' || printf('%08d', NEW.produto_id)
            WHERE produto_id = NEW.produto_id;
        END;
    """
    conn=sq.connect(local)
    conn.executescript(schema)
    conn.commit()
    conn.close()

def inicializar_banco_isolado(local, ic, iso_code):
    try:
        conexao = sq.connect(local)
        # Adiciona internal_code e isolado_code na tabela isolados_genomica sem ler do df
        dados_caminho = f"REG_projects/RP_GENOMIC/RPG_genomica/ANALISES/Dados/{iso_code}_{ic}/"
        conexao.execute(
            "INSERT OR IGNORE INTO isolados_genomica (isolado_code, reg_code, dados_caminho) VALUES (?, ?, ?);",
            (iso_code, ic, dados_caminho)
        )
        conexao.commit()
        conexao.close()
    except Exception as e:
        print(f"     Não foi possível inicializar banco de dados para {ic}. Erro: {e}")

def main():
    # Diretorios
    direc=os.getcwd() 
    direc_analises=os.path.join(direc, "ANALISES")
    isodb = "isolados.db"
    iso_path = os.path.join(direc_analises, "Bancos_de_dados/isoladosdb", isodb)
    entrada = "tabela_inicial.csv"
    entrada_path = os.path.join(direc_analises, entrada)

    #
    internal_code_list = importacao_isolados_db(entrada_path, iso_path)
    dicio = exportacao_internalcode_isoladocode(internal_code_list, iso_path, entrada_path)
    print(internal_code_list)
    print(dicio)

    # Criar bancos de dados dos isolados
    for internal_code in internal_code_list:
        isolado_code = dicio.get(internal_code)
        if not isolado_code:
            print(f"     Código ISO não encontrado para {internal_code}. Pulando.")
            continue
        local=os.path.join(direc_analises, "Bancos_de_dados/genomicasdb", f"{isolado_code}_{internal_code}.db")
        try:
            print(f" | Criando banco de dados para {isolado_code} ISOLADO.")
            criar_banco_isolado(local)
            print(f" | Banco de dados {internal_code}.db criado.")
        except Exception as e:
            print(f" | Não foi possível criar banco de dados para {internal_code}. Erro: {e}")
        print(f"{internal_code} Concluído")
    print(" - - - F I M - - - ")
    
    # Inicializar bancos de dados dos isolados com dados
    for internal_code in internal_code_list:
        isolado_code = dicio.get(internal_code)
        print(internal_code)
        if not isolado_code:
            continue
        local = os.path.join(direc_analises, "Bancos_de_dados/genomicasdb", f"{isolado_code}_{internal_code}.db")
        inicializar_banco_isolado(local, internal_code, isolado_code)
        print(f"{internal_code} Concluído")
    print(" - - - F I M - - - ")

if __name__ == "__main__":
    main()
