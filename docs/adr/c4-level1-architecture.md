# Diagrama C4 Nível 1 - Arquitetura do SIFAP 2.0

> Diagrama de contexto do sistema mostrando o SIFAP 2.0 e suas interações com sistemas externos e tipos de usuários.

## Visão Geral

Este diagrama C4 Nível 1 (Contexto do Sistema) apresenta o sistema SIFAP 2.0 em alto nível, incluindo:

- **3 Tipos de Usuários** interagindo com o sistema
- **Sistema Central** (SIFAP 2.0)
- **4 Sistemas Externos** para troca de dados e conformidade

## Diagrama C4 Nível 1

```mermaid 
graph TB
    subgraph Users["👥 Usuários e Partes Interessadas"]
        direction TB
        BENEFICIARY["🧑 Beneficiário<br/>(Titular CPF)<br/>Consulta benefícios,<br/>atualiza informações"]
        ADMIN["👨‍💼 Administrador<br/>(Equipe MDAS)<br/>Gerencia benefícios,<br/>processa solicitações"]
        ANALYST["👨‍💻 Analista/Auditor<br/>(DATACORP)<br/>Monitora conformidade,<br/>gera relatórios"]
    end
    
    subgraph Core["🏢 Sistema SIFAP 2.0"]
        direction TB
        SIFAP["<b>SIFAP 2.0</b><br/>Plataforma de<br/>Pagamento de Benefícios Sociais<br/><br/>• Gestão de Beneficiários<br/>• Cálculo de Benefícios<br/>• Processamento de Pagamentos<br/>• Auditoria e Conformidade"]
    end
    
    subgraph External["🔗 Sistemas Externos"]
        direction TB
        SIAFI["💰 SIAFI<br/>(Sistema Integrado<br/>de Administração<br/>Financeira)<br/>Integração com Tesouro"]
        RECEITA["📊 Receita Federal<br/>(Fisco Brasileiro)<br/>Validação de<br/>Conformidade Fiscal"]
        BANCO["🏦 Banco do Brasil<br/>Gateway de Pagamentos<br/>Transferência de Fundos<br/>Reconciliação"]
        CADUNICO["📋 CadÚnico<br/>(Registro Unificado)<br/>Perfil do Beneficiário<br/>Dados de Elegibilidade"]
    end
    
    %% Conexões dos usuários
    BENEFICIARY -->|"Acessa portal<br/>de benefícios"| SIFAP
    ADMIN -->|"Opera sistema<br/>gerencia catálogo"| SIFAP
    ANALYST -->|"Gera relatórios<br/>valida regras"| SIFAP
    
    %% Conexões do sistema para externos
    SIFAP -->|"Envia pagamentos<br/>registros financeiros"| SIAFI
    SIFAP -->|"Valida beneficiário<br/>conformidade de renda"| RECEITA
    SIFAP -->|"Inicia pagamentos<br/>recebe confirmações"| BANCO
    SIFAP -->|"Consulta dados<br/>do beneficiário"| CADUNICO
    
    %% Conexões dos externos para o sistema (respostas)
    SIAFI -->|"Confirma movimentos<br/>feedback orçamentário"| SIFAP
    RECEITA -->|"Status de conformidade<br/>registros fiscais"| SIFAP
    BANCO -->|"Status do pagamento<br/>comprovante transação"| SIFAP
    CADUNICO -->|"Dados de elegibilidade<br/>atualizações familiares"| SIFAP
    
    %% Estilos
    classDef user fill:#e1f5ff,stroke:#01579b,stroke-width:2px,color:#000
    classDef system fill:#fff3e0,stroke:#e65100,stroke-width:3px,color:#000
    classDef external fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,color:#000
    
    class BENEFICIARY,ADMIN,ANALYST user
    class SIFAP system
    class SIAFI,RECEITA,BANCO,CADUNICO external
```

## Componentes do Diagrama

### Tipos de Usuários (3)

| Tipo de Usuário      | Papel                                         | Atividades Principais                                                                               | 
|----------------------|-----------------------------------------------|-----------------------------------------------------------------------------------------------------| 
| **Beneficiário**     | Titular de CPF / Receptor de benefício social | • Consultar benefícios pessoais• Atualizar informações pessoais• Visualizar histórico de pagamentos | 
| **Administrador**    | Equipe MDAS / Operador do sistema             | • Gerenciar programas de benefícios• Processar solicitações• Configurar regras do sistema           | 
| **Analista/Auditor** | Especialista DATACORP                         | • Monitorar conformidade do sistema• Gerar relatórios de auditoria• Validar regras de negócio       | 

### Sistema Central

**SIFAP 2.0** - Plataforma de Pagamento de Benefícios Sociais

- Gestão de Beneficiários (registro, perfil, status)
- Cálculo de Benefícios (valores, elegibilidade)
- Processamento de Pagamentos (agendamento, confirmação)
- Auditoria e Conformidade (validação de regras, registros)

### Sistemas Externos (4)

| Sistema             | Propósito                           | Fluxo de Dados                                                        | 
|---------------------|-------------------------------------|-----------------------------------------------------------------------| 
| **SIAFI**           | Integração com tesouro              | Envia registros financeiros → Recebe feedback orçamentário            | 
| **Receita Federal** | Conformidade fiscal                 | Valida CPF/renda → Retorna status de conformidade                     | 
| **Banco do Brasil** | Gateway de pagamentos               | Inicia pagamentos → Recebe confirmações                               | 
| **CadÚnico**        | Registro unificado de beneficiários | Consulta dados de beneficiário → Recebe atualizações de elegibilidade | 

## Pontos-chave de Integração

### Entrada (Dos Sistemas Externos)
1. **CadÚnico** → Dados de elegibilidade do beneficiário e composição familiar
2. **Receita Federal** → Status de conformidade fiscal e verificação de renda
3. **Banco do Brasil** → Confirmação de pagamento e reconciliação
4. **SIAFI** → Alocação orçamentária e feedback do tesouro

### Saída (Para Sistemas Externos)
1. **SIAFI** → Registros financeiros e movimentações de pagamentos
2. **Receita Federal** → Dados de renda do beneficiário para validação
3. **Banco do Brasil** → Requisições de iniciação de pagamentos
4. **CadÚnico** → Consultas de elegibilidade de benefícios

## Fundamentação da Arquitetura

Este diagrama C4 Nível 1 segue estes princípios:

- **Separação de Responsabilidades**: Três personas de usuário distintos com padrões de acesso diferentes
- **Limites do Sistema**: Separação clara entre SIFAP e sistemas externos
- **Pontos de Integração**: Todas as dependências externas claramente mapeadas
- **Conformidade**: Alinhamento com sistemas do governo brasileiro (SIAFI, Receita Federal, CadÚnico)
- **Escalabilidade**: Design modular pronto para implantação em nuvem moderna

## Próximos Passos

Para informações mais detalhadas, consulte:

- **C4 Nível 2**: Diagrama de containers (API, Banco de Dados, Frontend, Serviços)
- **C4 Nível 3**: Diagrama de componentes (arquitetura interna)
- **C4 Nível 4**: Diagrama de código (detalhes de implementação)
- **Diagramas de Sequência**: Fluxo de processamento de pagamentos, registro de beneficiário, etc.
