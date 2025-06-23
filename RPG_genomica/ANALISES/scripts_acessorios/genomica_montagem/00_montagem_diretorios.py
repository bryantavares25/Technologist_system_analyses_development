#!python3

import os
import pandas as pd
import sqlite3 as sq

def insercao_montado(isoladodb_path, dados):
    print("     > Cadastro de MONTAGEM - START < ")
    conexao = sq.connect(isoladodb_path)
    cursor = conexao.cursor()
    campos = ", ".join(dados.keys())
    placeholders = ", ".join(["?"] * len(dados))
    sql = f"INSERT INTO montados ({campos}) VALUES ({placeholders})"
    cursor.execute(sql, tuple(dados.values()))
    conexao.commit()
    conexao.close()
    print("     > Cadastro de MONTAGEM - END < ")

def selecao_montado(isoladodb_path, dados):
    print("     > Recuperação de dados MONTAGEM - START < ")
    conexao = sq.connect(isoladodb_path)
    cursor = conexao.cursor()
    sql_select = "SELECT montado_code FROM montados WHERE leituras_entrada = ? AND isolado_code = ?"
    cursor.execute(sql_select, (dados['leituras_entrada'], dados['isolado_code']))
    resultado = cursor.fetchone()
    print("     > Recuperação de dados MONTAGEM - END < ")
    return resultado[0] if resultado else None

def criacao_montado(montado_path):
    print("     > Criação de diretórios MONTAGEM - START < ")
    montagem_dirs=["01_seq_val",
        "01_seq_val/fastqc",
        "02_seq_cle",
        "03_seq_val",
        "03_seq_val/fastqc",
        "04_seq_con",
        "05_val_con",
        "06_seq_sca",
        "07_val_sca"]
    for subdir in montagem_dirs:
        full_path = os.path.join(montado_path, subdir)
        os.makedirs(full_path, exist_ok=True)
    print("     > Criação de diretórios MONTAGEM - END < ")

def adicionar_no_df(df, index, montado_path, montado_code, file_anal_temp):
    print("     > Adcionar endereço no DF - START < ")
    print(f"     > Caminho registrado: {montado_path}")
    print(f"     > Código da montagem: {montado_code}")
    if "caminho_montado" not in df.columns:
        df["caminho_montado"] = ""
    if "montado_code" not in df.columns:
        df["montado_code"] = ""
    df.at[index, "caminho_montado"]=montado_path
    df.at[index, "montado_code"]=montado_code
    df.to_csv(file_anal_temp, index=False)
    print("     > Adcionar endereço no DF - END < ")

def main():
    print(" > . o 0 88 0 o . <")

    dir=os.getcwd()
    dir_analises=os.path.join(dir, "ANALISES")
    dir_anal_dados=os.path.join(dir_analises, "Dados")
    file_anal_temp=os.path.join(dir_analises, "temp_file.csv")
    dir_genomicasdb=os.path.join(dir_analises, "Bancos_de_dados/genomicasdb")
    
    # Ler arquivo temporário e entrar dados
    df=pd.read_csv(file_anal_temp)

    for index, row in df.iterrows():
        # Localizando o bancio de dados
        genomicasdb=os.path.join(dir_genomicasdb, f"{row['isolado_code']}_{row['internal_code']}.db")

        dados={
            "leituras_entrada": row['sequenciado_code'], #INICIALIZAÇÃO
            "pipeline_montagem": "Padrão", #INICIALIZAÇÃO
            "parametros_montagem": "Padrão", #INICIALIZAÇÃO
            "isolado_code": row['isolado_code'] #INICIALIZAÇÃO
        }

        insercao_montado(genomicasdb, dados)

        montado_code = selecao_montado(genomicasdb, dados) # montado_code AUTOMÁTICO RETURN TO TEMPORARIO
        print(montado_code)

        # O retornado deve ser adicionado na pasta temporária
        montado_path=os.path.join(dir_anal_dados, f"{row['isolado_code']}_{row['internal_code']}", "MONTADO", montado_code)
        print(montado_path)

        criacao_montado(montado_path)
        adicionar_no_df(df, index, montado_path, montado_code, file_anal_temp)

    print(" > . o 0 88 0 o . <")

if __name__ == "__main__":
    main()
