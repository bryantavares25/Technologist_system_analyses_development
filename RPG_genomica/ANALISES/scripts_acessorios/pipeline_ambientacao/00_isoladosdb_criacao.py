import sqlite3 as sq
import os

def isolados_db_criacao(local):
    print(" > Função: Criação do banco de dados de ISOLADOS ('isolados.db').")
    execute = """
    CREATE TABLE IF NOT EXISTS table_isolados(
        isolado_id INTEGER PRIMARY KEY AUTOINCREMENT,
        isolado_reg TEXT NOT NULL UNIQUE,
        isolado_code TEXT UNIQUE,
        importacao_data TEXT DEFAULT CURRENT_DATE
    );
    CREATE TRIGGER IF NOT EXISTS trg_isolados_set_code
    AFTER INSERT ON table_isolados
    FOR EACH ROW
    BEGIN
        UPDATE table_isolados
        SET isolado_code = 'ISO_' || printf('%08d', NEW.isolado_id)
        WHERE isolado_id = NEW.isolado_id;
    END;
    """
    # Verificar a existência do arquivo 'isolados.db'
    if os.path.exists(local):
        print(" > Banco de dados ISOLADOS já existe ('isolados.db').")
    else:
        try:
            dbconexao = sq.connect(local) # Conexão ao banco de dados ISOLADOS
            dbconexao.cursor().executescript(execute)
            dbconexao.commit()
            dbconexao.close() # Desconeção ao banco de dados ISOLADOS
            print(" > Banco de dados ISOLADOS criado com sucesso ('isolados.db').")
        except Exception as e:
            print(" > Não foi possível criar banco de dados ISOLADOS ('isolados.db').")
            print(f" Erro: {e}")

def main():
    direc=os.getcwd()
    direc_analises=os.path.join(direc, "ANALISES/")
    isodb = "Bancos_de_dados/isoladosdb/isolados.db"
    path = os.path.join(direc_analises, isodb)
    isolados_db_criacao(path)

if __name__ == "__main__":
    # ISOLADOS_DB # reg_code -> iso_code
    main()
