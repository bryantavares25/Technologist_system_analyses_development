# # # PROJETO TECNOLÓGICO DE ANÁLISE E DESENVOLVIMENTO DE SISTEMAS - ULBRA 
# # B.A.R.T.
# Ferramenta de bioinformática para prospecção do potencial genômico de bactérias

# REQUISITOS
> Requisitos funcionais
    > # RF01 – Interface de processamento de análise via terminal 
        > A ferramenta deve ser executada via terminal.
    > # RF02 – Importar dados de entrada
        > A ferramenta deve importar arquivos de leitura de nucleotídeos provenientes de sequenciamento de DNA em formato fastq.
    > # RF03 – Montar genoma bacteriano
        > A ferramenta deve gerar a montagem de estruturas genômicas bacterianas a partir das leituras de nucleotídeos importadas.
    > # RF04 – Avaliar montagem de genoma bacteriano
        > A ferramenta deve avaliar a qualidade da montagem genômica a partir de parâmetros como integridade e pureza do genoma.
    > # RF05 – Anotar genoma bacteriano
        > A ferramenta deve identificar os genes presentes nas estruturas genômicas e anotar as potenciais funções associadas a eles.
    > # RF06 – Armazenar dados genômicos em banco de dados
        > A ferramente deve armazenar os dados relevantes provenientes da montagem e anotação genômica em um banco de dados local.
    > # RF07 – Interface de consulta via browser
        > A ferramenta deve abrir interface de consulta em browser.
    > # RF08 – Consultar dados anotados
        > A ferramenta deve permitir que ao usuário consultar dados provenientes da montagem de estruturas genômicas, assim como, os genes e as anotações funcionais a ele associadas.
    > # RF09 – Gerar relatórios dos resultados
        > A ferramenta deve dar a possibilidade de exportar os dados de interesse do usuário em formato .txt ou .csv com os dados da montagem e da anotação funcional.
> Requisitos não funcionais
    > # RNF01 – Portabilidade
        > A ferramenta deve ser compatível com distribuições Linux Ubuntu, especialmente distribuições baseadas em Debian.
    > # RNF02 – Ambiente para bioinformática
        > A ferramenta deve construir ambientes necessários para sua execução. Para tanto, deve usar ambientes Conda e se necessários Containers Docker.
    > # RNF03 – Banco de dados
        > A ferramenta deve estruturar banco de dados SQLite local.
    > # RNF02 – Usabilidade
        > A ferramenta deve ter documentação e um manual de uso simples e instruções de instalação para usuários com conhecimentos básicos em bioinformática.
    > # RNF03 – Confiabilidade
        > A ferramenta deve lidar com erros de entrada e fornecer mensagens claras em casos de falha, sem comprometer os dados já processados.
    > # RNF04 – Desempenho
        > A ferramenta deve ser capaz de processar um genoma bacteriano completo em tempo de máquina razoável.
    > # RNF05 – Manutenibilidade
        > A ferramenta deve ter o código modular, documentado e com instruções para facilitar futuras atualizações ou trocas de ferramentas bioinformáticas.
    > # RNF06 – Segurança
        > Os dados processados devem ser mantidos localmente, sem envio para servidores externos, garantindo privacidade dos dados biológicos.
