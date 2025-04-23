```Mermaid
flowchart TD
    A[Tela Inicial] --> B[Formulário de IMC]
    B --> C{Campos preenchidos?}
    C -- Sim --> D[Calcular IMC]
    C -- Não --> E[Mostrar alerta de erro]
    D --> F[Exibir resultado]
    F --> G[Botão: Recalcular]
    G --> B
```