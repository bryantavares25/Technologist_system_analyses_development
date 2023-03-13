#include <stdio.h>
#include <math.h>

int proteina_de_fusao(int p01, int p02, int *v) {
    int soma;
    soma = (v[p01]+v[p02]);
    return (soma);
}

int main() {
    
    int vetor[3] = {100, 145, 97};
    int fusao_01, fusao_02, resultado;

    printf("\n\n* PROTC: facilitador de predição de tamanho de proteínas conjugadas *\n\n");
    printf("\n (0) - Proteína SPase tem tamanho de 100 aminoácidos.\n (2) - Proteína GFP tem tamanho de 145 aminoácidos\n (3) - Proteína DNase tem tamanho de 97 aminoácidos.\n\n  - - - - Quais proteínas devem ser fuzionadas? - - -  ");
    printf("\nProteína inicial: ");
    scanf("%i", &fusao_01);
    printf("\nProteína conjugada: ");
    scanf("%i", &fusao_02);

    resultado = proteina_de_fusao(fusao_01, fusao_02, vetor);

    printf("\n\n - - - Proteína resultante tem tamanho de %i aminoácidos.\n\n", resultado);
}
