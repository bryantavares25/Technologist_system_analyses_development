#include <stdio.h>
#include <math.h>

int soma_matriz(int m1[3][3], int m2[3][3]) {
    int i, j, resultado;
    resultado = 0;
    for (i=0; i<3; i++){
        for (j=0; j<3; j++){
            resultado = resultado + (m1[i][j]+m2[i][j]); 
        }
    }
    return resultado;
}

int main() {   
    int m1[3][3] = {{1, 1, 1}, {1, 1, 1}, {1, 1, 1}};
    int m2[3][3] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
    int i, j, resultado;
    printf("\n\n* MATSOM: facilitador da soma de todos os números presentes em uma matriz *\n\n");
    for (i=0; i<3; i++){
        for (j=0; j<3; j++){
            printf(" | %i | ", m1[i][j]); 
        }
        printf("\n");
    }
    printf("\n\n\n");
    i = j = 0;
    for (i=0; i<3; i++){
        for (j=0; j<3; j++){
            printf(" | %i | ", m2[i][j]); 
        }
        printf("\n");
    }
    printf("\n\n\n");
    resultado = soma_matriz(m1, m2);
    printf("Resultado da soma de todos os valores das matrizes: %i.\n\n", resultado);
}
