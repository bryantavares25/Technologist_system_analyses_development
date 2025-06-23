#!python3

# Bibliotecas
import os
import shutil
import pandas as pd
import sqlite3 as sq

# Definicoes
def inserir_sequenciado(isoladodb_path, dados):
    conexao = sq.connect(isoladodb_path)
    cursor = conexao.cursor()
    campos = ", ".join(dados.keys())
    placeholders = ", ".join(["?"] * len(dados))
    sql = f"INSERT INTO sequenciados ({campos}) VALUES ({placeholders})"
    cursor.execute(sql, tuple(dados.values()))
    conexao.commit()
    conexao.close()

def selecionar_sequenciado(isoladodb_path, dados):
    conexao = sq.connect(isoladodb_path)
    cursor = conexao.cursor()
    sql_select = "SELECT sequenciado_code FROM sequenciados WHERE external_code = ?"
    cursor.execute(sql_select, (dados['external_code'],))
    resultado = cursor.fetchone()
    return resultado[0]

def main():
    direc=os.getcwd()
    direc_analises=os.path.join(direc, "ANALISES/")
    direc_entrada= os.path.join(direc, "ENTRADA/")  

    seq_isodb="tabela_inicial.csv"
    seq_isodb_path=os.path.join(direc_analises, seq_isodb)

    # Lendo tabela inicial
    df = pd.read_csv(seq_isodb_path)

    # CONVERTER COLUNAS PARA STRING PARA EVITAR TypeError e FutureWarning
    # Esta é a parte CRUCIAL que você precisa adicionar/ajustar
    for col in ["isolado_code", "internal_code", "external_code", "plataforma", 
                "tipo_leitura", "tipo_de_arquivos", "dados_caminho", "sequenciado_code"]:
        if col in df.columns:
            df[col] = df[col].astype(str).replace('nan', '') # Converte para str e substitui 'nan' por string vazia

    # Verificar se a coluna sequenciado_code existe, se não, criá-la
    if "sequenciado_code" not in df.columns:
        df["sequenciado_code"] = '' # Cria a coluna como string vazia
    # --- FIM DA CORREÇÃO ---

    # # # Para cada linha do DF
    for index, row in df.iterrows():
        direc_isoladosdb=os.path.join(direc_analises, "Bancos_de_dados/genomicasdb/")
        isoladodb=f"{row["isolado_code"]}_{row["internal_code"]}.db"
        isoladodb_path = os.path.join(direc_isoladosdb, isoladodb)

        dados={
            "external_code": row["external_code"],
            "plataforma": row["plataforma"],
            "tipo_leitura": row["tipo_leitura"],
            "tipo_de_arquivos": row["tipo_de_arquivos"],
            "isolado_code": row["isolado_code"],
            "dados_caminho": row["dados_caminho"]
        }

        # Inserir no banco de dados
        try:
            inserir_sequenciado(isoladodb_path, dados)
        except Exception as e:
            print(f"Erro: {e}")
        # Atualizar o df com o sequenciado_code gerado na inserção
        try:
            resultado = selecionar_sequenciado(isoladodb_path, dados)
            df.at[index, "sequenciado_code"] = resultado
        except Exception as e:
            print(f"Erro: {e}")
    # # #
    
    # Adicionando dados no DF
    df.to_csv(seq_isodb_path, index=False)

    # # # Para cada linha di DF
    for index, row in df.iterrows():
        # Pastas com arquivos de entrada
        entrada_caminho_completo=os.path.join(direc_entrada, row['external_code'])
        # Pastas para arquivios importados
        dados_caminho_completo=os.path.join(direc_analises, "Dados", f"{row['isolado_code']}_{row['internal_code']}")

        # Verificar a existência dos diretório
        if os.path.isdir(entrada_caminho_completo):
            print(f"A pasta de entrada {row['external_code']} existe.")
            if os.path.isdir(dados_caminho_completo):
                print(f"A pasta de dados existe: {dados_caminho_completo}")
            else:
                # Criar - caso não exista o diretorio
                print(f"A pasta de dados não existe: {dados_caminho_completo}")
                try:
                    os.makedirs(dados_caminho_completo)
                    print(f"A pasta de dados foi criada: {row['isolado_code']}_{row['internal_code']}")
                except Exception as e:
                    print(f"Erro: {e}")
        else:
            print(f"A pasta de entrada {row['external_code']} não existe.")
            print("Insira a pasta correspondente para prosseguir corretamente.")
    # # #

    #HERE
    # # # Para cada linha do DF
    for index, row in df.iterrows():
        # ... (código existente para definir entrada_caminho_completo) ...
        entrada_caminho_completo = os.path.join(direc_entrada, row['external_code'])
        
        # Pastas para arquivos importados (dados de cada isolado)
        dados_caminho_completo = os.path.join(direc_analises, "Dados", f"{row['isolado_code']}_{row['internal_code']}")

        # Verificar a existência do diretório principal para os dados do isolado
        if os.path.isdir(entrada_caminho_completo):
            print(f"A pasta de entrada {row['external_code']} existe.")
            if os.path.isdir(dados_caminho_completo):
                print(f"A pasta de dados existe: {dados_caminho_completo}")
            else:
                # Criar - caso não exista o diretório principal do isolado
                print(f"A pasta de dados não existe: {dados_caminho_completo}. Criando...")
                try:
                    os.makedirs(dados_caminho_completo)
                    print(f"A pasta de dados foi criada: {row['isolado_code']}_{row['internal_code']}")
                except Exception as e:
                    print(f"Erro ao criar pasta de dados {dados_caminho_completo}: {e}")
            
            # --- Adicione esta parte para criar as subpastas ---
            try:
                seq = os.path.join(dados_caminho_completo, "SEQUENCIADO")
                mon = os.path.join(dados_caminho_completo, "MONTADO")
                ano = os.path.join(dados_caminho_completo, "ANOTADO")
                
                # Use exist_ok=True para evitar erro se a pasta já existir
                os.makedirs(seq, exist_ok=True)
                os.makedirs(mon, exist_ok=True)
                os.makedirs(ano, exist_ok=True)
                print(f"Subpastas 'SEQUENCIADO', 'MONTADO' e 'ANOTADO' criadas para {row['isolado_code']}_{row['internal_code']}.")
            except Exception as e:
                print(f"Erro ao criar subpastas para {row['isolado_code']}_{row['internal_code']}: {e}")
            # --- Fim da adição ---

        else:
            print(f"A pasta de entrada {row['external_code']} não existe.")
            print("Insira a pasta correspondente para prosseguir corretamente.")
    # # #

    # # # Para cada linha do DF
    for index, row in df.iterrows():
        #Copiar pasta do diretório de entrada para o diretório de destino
        try:
            entrada_path=os.path.join(direc_entrada, str(row['external_code']))
            dados_path=os.path.join(direc_analises, "Dados", f"{str(row['isolado_code'])}_{str(row['internal_code'])}","SEQUENCIADO" , row['sequenciado_code'])
            shutil.copytree(entrada_path, dados_path)
            # Renomear a pasta e os arquivos dentro
            try:
                print(f"Renomeando os arquivos em {dados_path}")
                try:
                    # os.walk percorre o diretório e todas as suas subpastas
                    for dirpath, dirnames, filenames in os.walk(dados_path):
                        FR=['F', 'R']
                        if len(filenames)==2:
                            print(filenames[0])
                            arquivo_novo_fastqF=os.path.join(dirpath, f"{row['sequenciado_code']}_{FR[0]}.fastq.gz")
                            arquivo_antigo_fastqF=os.path.join(dirpath, filenames[0])
                            os.rename(arquivo_antigo_fastqF, arquivo_novo_fastqF)
                            print(filenames[1])
                            arquivo_novo_fastqR=os.path.join(dirpath, f"{row['sequenciado_code']}_{FR[1]}.fastq.gz")
                            arquivo_antigo_fastqR=os.path.join(dirpath, filenames[1])
                            os.rename(arquivo_antigo_fastqR, arquivo_novo_fastqR)
                        elif len(filenames)==1:
                            print(filenames[0])
                            arquivo_novo_fastqFR=os.path.join(dirpath, f"{row['sequenciado_code']}_FR.fastq.gz")
                            arquivo_antigo_fastqFR=os.path.join(dirpath, filenames[0])
                            os.rename(arquivo_antigo_fastqFR, arquivo_novo_fastqFR)
                        else:
                            print("Há potenticalmente um erro no diretório de arquivos. Não foi possível renomear e integrar os dados.")
                except Exception as e:
                    print(f"Erro na interno na renomeação de arquivo: {e}")
            except Exception as e:
                print(f"Erro na renomeação do arquivo: {e}")
        except Exception as e:
            print(f"Erro na cópia da pasta: {e}")
        # Mover para a pasta correspondente
 
if __name__ == "__main__":
    main()
