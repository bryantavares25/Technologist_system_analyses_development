#include <stdio.h>

int proteina_de_fusao(int p01, int p02) {


}

int main() {
    
    int vetor[3] = [100, 145, 97];
    int fusao_01, fusao_02;

    printf("\n (1) - Proteína 1 tem tamanho de 100 aminoácidos.\n (2) - Proteína 2 tem tamanho de 145 aminoácidos\n (3) - Proteína 3 tem tamanho de 97 aminoácidos.\n\n  - - - - Quais proteínas devem ser fuzionadas? - - -  ");
    printf("\nProteína inicial: ");
    scanf("%i", &fusao_01);
    printf("\nProteína conjugada: ");
    scanf("%i", &fusao_02);

    int resultado  = proteina_de_fusao(fusao_01, fusao_02, vetor);

    system("pause");
    return 0;
}
