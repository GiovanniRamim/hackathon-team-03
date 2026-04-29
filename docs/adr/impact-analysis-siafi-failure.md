# Análise de Impacto - Falha na Integração com SIAFI

## Cenário: SIAFI Indisponível

**Data da Análise**: 29 de abril de 2026  
**Sistema Afetado**: SIFAP 2.0  
**Componente Crítico**: Integração com SIAFI (Sistema Integrado de Administração Financeira)

> Este documento analisa os impactos em cascata quando o SIAFI fica indisponível por razões técnicas (sistema fora do ar, falha de rede, banco de dados caído, etc).

---

## 1. Causas Potenciais de Falha

### 1.1 Causas Técnicas
- ⚠️ **Sistema SIAFI fora do ar** - Manutenção programada ou falha catastrófica
- ⚠️ **Falha de conectividade** - Problema de rede entre SIFAP e SIAFI
- ⚠️ **Banco de dados SIAFI indisponível** - Crash do servidor, corrupção de dados
- ⚠️ **Timeout de API** - Demora excessiva nas respostas
- ⚠️ **Autenticação falha** - Certificados expirados, credenciais inválidas

### 1.2 Duração Estimada de Impacto
- **Curta** (< 1 hora): Incidente isolado, fácil recuperação
- **Média** (1-4 horas): Requer intervenção técnica, afeta múltiplos batches
- **Longa** (> 4 horas): Requer escalação, impacto significativo em beneficiários

---

## 2. Impactos Imediatos na Aplicação

### 2.1 Processamento de Pagamentos (CRÍTICO ⛔)

**Problema**: SIFAP envia registros financeiros para SIAFI para cada pagamento de benefício iniciado.

**O que ocorre quando SIAFI falha:**

```
Fluxo Normal:
┌─────────────────────────────────────────────────────────┐
│ 1. Beneficiário solicita pagamento (R$ 500,00)         │
│ 2. SIFAP calcula valor (cálculo de benefício)         │
│ 3. SIFAP envia para Banco do Brasil (iniciação)        │
│ 4. SIFAP envia para SIAFI (registro financeiro)        │
│ 5. SIAFI confirma orçamento disponível ✓               │
│ 6. Pagamento processado e concluído                    │
└─────────────────────────────────────────────────────────┘

Fluxo com SIAFI Indisponível:
┌─────────────────────────────────────────────────────────┐
│ 1. Beneficiário solicita pagamento (R$ 500,00)         │
│ 2. SIFAP calcula valor (cálculo de benefício)         │
│ 3. SIFAP envia para Banco do Brasil (iniciação)        │
│ 4. SIFAP tenta enviar para SIAFI...                    │
│    ❌ TIMEOUT/ERRO/FALHA                               │
│ 5. Pagamento já foi iniciado no banco!                 │
│    Mas não foi registrado no SIAFI                     │
│ 6. Inconsistência: Tesouro não tem registro            │
└─────────────────────────────────────────────────────────┘
```

**Impactos Específicos:**

| Aspecto | Impacto | Severidade |
|---------|---------|-----------|
| **Pagamentos em processamento** | Ficam "pendurados" sem confirmação orçamentária | 🔴 CRÍTICO |
| **Orçamento** | Tesouro não tem visibilidade dos gastos | 🔴 CRÍTICO |
| **Reconciliação** | Valores fora do livro-razão do Tesouro | 🔴 CRÍTICO |
| **Auditoria** | Registros inconsistentes entre sistemas | 🟠 ALTO |
| **Beneficiários** | Podem ter pagamentos duplicados ou falhos | 🟠 ALTO |

### 2.2 Consistência de Dados (CRÍTICO ⛔)

**Problema**: Sem confirmação do SIAFI, o SIFAP não sabe se o pagamento foi:
- ✅ Registrado com sucesso no tesouro
- ⏳ Ainda em processamento
- ❌ Rejeitado por falta de orçamento

**Cenários problemáticos:**

1. **Pagamento já saiu do Banco do Brasil, mas SIAFI não sabe**
   - Dinheiro real foi transferido
   - Tesouro não tem registro da despesa
   - Discrepância no fluxo de caixa

2. **Tentativa de retry automático**
   - Se SIFAP reenvia a requisição quando SIAFI volta
   - Risco de pagamento duplicado
   - Dupla debitação no Tesouro

3. **Fila de requisições acumuladas**
   - Múltiplos pagamentos aguardando confirmação
   - Quando SIAFI volta, não sabe a ordem correta
   - Possível processamento fora de ordem

### 2.3 Impacto no Banco do Brasil (ALTO 🟠)

**Problema**: O Banco do Brasil recebeu requisição de pagamento, mas SIFAP não conseguiu confirmar no SIAFI.

| Cenário | Impacto |
|---------|---------|
| **SIFAP envia para Banco, depois SIAFI cai** | Banco processa pagamento normalmente. SIFAP não tem confirmação se SIAFI autorizou orçamento |
| **SIFAP reenvia quando SIAFI volta** | Risco de transação duplicada se SIAFI não tiver rastreamento |
| **Fila de compensação** | Banco do Brasil pode bloquear pagamentos pendentes de confirmação |

---

## 3. Impactos Operacionais

### 3.1 Processamento em Lote (Batch)

O SIFAP processa pagamentos mensais em batch (BATCHPGT.NSN):

```
Fluxo Mensal Normal:
├─ Noite de domingo: Inicia processamento de 5M beneficiários
├─ 2h da manhã: Calcula benefícios
├─ 3h da manhã: Envia para Banco do Brasil
├─ 4h da manhã: Envia registros para SIAFI
├─ 5h da manhã: SIAFI confirma todos os pagamentos
└─ 6h da manhã: Batch finalizado com sucesso

Com SIAFI Fora:
├─ Noite de domingo: Inicia processamento de 5M beneficiários
├─ 2h da manhã: Calcula benefícios
├─ 3h da manhã: Envia para Banco do Brasil (5M transações)
├─ 4h da manhã: Tenta enviar para SIAFI... ❌ FALHA
├─ 4h15min: Retry automático... ❌ AINDA FALHA
├─ 5h da manhã: Batch ainda em processamento
├─ 6h: Gerenciar decisão crítica:
│   ├─ Rollback? Problema: Banco já recebeu transações
│   ├─ Prosseguir? Problema: SIAFI sem registros
│   └─ Aguardar SIAFI voltar? Problema: Pagamentos atrasam
└─ Consequência: Atraso de dias no processamento
```

**Impacto Direto:**

- ⏳ **Atraso de 24-48 horas** na disponibilidade de benefício para beneficiários
- 💰 **Impacto social**: Famílias sem acesso ao dinheiro no prazo esperado
- 📞 **Sobrecarga de call center**: Reclamações de beneficiários
- 🔴 **Violação de SLA**: Governo tem compromisso de pagar até data X

### 3.2 Relatórios e Auditoria

**Problema**: Analistas/Auditores não conseguem validar se pagamentos foram de fato processados no tesouro.

```
Relatório Normal:
┌──────────────────────────────────────────┐
│ SIFAP relata: 5M pagamentos processados │
│ SIAFI confirma: 5M pagamentos recebidos │
│ Status: ✅ Reconciliado                  │
└──────────────────────────────────────────┘

Com SIAFI Indisponível:
┌──────────────────────────────────────────┐
│ SIFAP relata: 5M pagamentos processados │
│ SIAFI confirma: 0 pagamentos recebidos   │
│ Status: ❌ NÃO Reconciliado              │
│                                          │
│ Pergunta: Onde está o dinheiro?         │
│ Resposta: ??? No Banco? No Tesouro?     │
└──────────────────────────────────────────┘
```

**Impactos:**
- 📊 Relatórios inconsistentes ou indisponíveis
- 🔍 Impossibilidade de auditoria até SIAFI estar online
- 📋 Documentação fiscal incompleta
- ⚖️ Conformidade com órgãos de controle (TCU, CGU) comprometida

---

## 4. Impactos nos Usuários do Sistema

### 4.1 Beneficiários 👤

| Impacto | Descrição | Severidade |
|--------|-----------|-----------|
| **Pagamento não recebido** | Benefício não chega na data esperada | 🔴 CRÍTICO |
| **Insegurança financeira** | Dúvida se o dinheiro vai chegar | 🔴 CRÍTICO |
| **Impossibilidade de saque** | Pode aparecer no SIAFI depois, gerar duplicação | 🟠 ALTO |
| **Stress social** | Famílias em vulnerabilidade sem renda | 🔴 CRÍTICO |

### 4.2 Administradores (MDAS) 👨‍💼

| Impacto | Descrição | Severidade |
|---------|-----------|-----------|
| **Incerteza operacional** | Não sabem como proceder: continuar ou parar? | 🔴 CRÍTICO |
| **Decisões difíceis** | Rollback? Ignorar SIAFI? Esperar? | 🟠 ALTO |
| **Risco reputacional** | Falha na entrega de serviço social | 🔴 CRÍTICO |
| **Sobrecarga manual** | Trabalho noturno para investigar e resolver | 🟠 ALTO |

### 4.3 Analistas/Auditores 👨‍💻

| Impacto | Descrição | Severidade |
|---------|-----------|-----------|
| **Impossibilidade de reconciliação** | Não conseguem validar dados | 🟠 ALTO |
| **Auditoria paralisada** | Relatórios solicitados não podem ser emitidos | 🟠 ALTO |
| **Prestação de contas** | Não podem comprovar gastos para TCU/CGU | 🔴 CRÍTICO |
| **Investigação necessária** | Tempo gasto investigando inconsistências | 🟠 ALTO |

---

## 5. Impactos Financeiros

### 5.1 Custo Direto

| Item | Estimativa | Observação |
|------|-----------|-----------|
| **Horas de operação** | 8-24 horas de staff dedicado | ~R$ 5.000-15.000 |
| **Suporte escalado** | Engenheiros de infraestrutura | ~R$ 10.000-30.000 |
| **Sistemas fora do ar** | Perda de produtividade de processos | ~R$ 20.000-50.000 |
| **Penalidades legais** | Atraso em pagamento de benefício | ⚖️ Potencial |
| **TOTAL** | **R$ 35.000-95.000+** | Por hora de indisponibilidade |

### 5.2 Custo Indireto

- **Dano à imagem**: Governo falha em entregar benefício social
- **Pressão política**: Congressistas, mídia investigando
- **Conformidade**: Investigações de órgãos de controle (TCU, CGU)
- **Confiança**: Sistemas governamentais percebidos como frágeis

---

## 6. Impactos Técnicos Específicos

### 6.1 Problema: Sem Transação Distribuída

**Situação atual (SIFAP Legacy):**
```
1. SIFAP inicia pagamento no Banco do Brasil
2. SIFAP registra em seu banco de dados local
3. SIFAP envia para SIAFI
   - Se SIAFI responde OK → Tudo bem ✅
   - Se SIAFI não responde → Inconsistência ❌
```

**Problema**: Não há transação atômica entre os 3 sistemas. Se falha no meio:
- Banco recebeu a ordem
- SIFAP acha que processou
- SIAFI nunca souber

### 6.2 Problema: Sem Mecanismo de Retry Inteligente

**Pergunta crítica**: Quando SIAFI voltar, SIFAP sabe o que fazer?

```
Cenários de Retry Perigosos:
┌─────────────────────────────────────────────────┐
│ A. Retry simples                                │
│    ❌ Risco: Pagamento duplicado no tesouro    │
│                                                 │
│ B. Sem retry                                    │
│    ❌ Risco: Pagamentos perdidos/não auditados │
│                                                 │
│ C. Retry com idempotência                       │
│    ✅ Seguro: Garante apenas 1 registro       │
│    Mas SIFAP atual não tem isso                │
└─────────────────────────────────────────────────┘
```

### 6.3 Problema: Sem Circuit Breaker

**Situação**: Se SIAFI não responde em 30 segundos:
- Cada tentativa de pagamento trava por 30s
- Com 5M beneficiários, são 150M segundos = 42.000 horas
- Timeout acumula, trava todo o batch

---

## 7. Cenários de Falha Detalhados

### Cenário A: SIAFI cai DURANTE o batch mensal

```
Domingo 20h: Inicia batch de 5M beneficiários
Domingo 22h: SIAFI fica fora do ar (banco de dados crash)
Domingo 23h: Batch atinge 3M processados, falha ao tentar enviar para SIAFI

CONSEQUÊNCIAS:
├─ 3M beneficiários: Banco recebeu transações, SIAFI não tem registro
├─ 2M beneficiários: Ainda não processados
├─ Decisão urgente: 
│  ├─ Rollback 3M transações? Problema: Banco já debitou
│  ├─ Continuar com 2M? Problema: Alguns recebem, outros não
│  └─ Parar e aguardar? Problema: Pagamento atrasa para TODOS
└─ Resultado: Caos operacional + beneficiários sem dinheiro

TEMPO PARA RECUPERAÇÃO: 6-24 horas
BENEFICIÁRIOS AFETADOS: 5M (nenhum recebe na data esperada)
```

### Cenário B: SIAFI lento (timeouts repetidos)

```
Segunda-feira 08h: Batch de processamento on-demand para beneficiários novos
SIAFI está respondendo lentamente (sobrecarregado)

CONSEQUÊNCIAS:
├─ Cada pagamento tarda 2-3 minutos (vs. normal: 5 segundos)
├─ Taxa de sucesso: ~70% (alguns timeoutam)
├─ Fila acumula: Em 1 hora, já há 10k requisições aguardando
├─ Portal do SIFAP fica lento para beneficiários
├─ Alguns beneficiários veem "Erro ao processar"
│  (enquanto outros conseguem depois de muito tempo)
└─ Resultado: Experiência de usuário horrível

TEMPO PARA RECUPERAÇÃO: Até SIAFI voltar ao normal
BENEFICIÁRIOS AFETADOS: ~Todos, com lentidão/falhas intermitentes
```

### Cenário C: Falha intermitente (SIAFI de/ligando)

```
Terça 14h: SIAFI começa a falhar e recuperar aleatoriamente
- 08:14 - Falha
- 08:15 - Recupera
- 08:17 - Falha
- 08:18 - Recupera
- ...repeat

CONSEQUÊNCIAS:
├─ Impossível prever o estado do sistema
├─ Algumas transações passam, outras não
├─ Audit trail fica confuso (qual requisição chegou?)
├─ Operadores não sabem o que fazer
├─ Beneficiários recebem pagamentos de forma aleatória
└─ Resultado: Total falta de confiabilidade

TEMPO PARA RECUPERAÇÃO: Até falha ser completamente solucionada
BENEFICIÁRIOS AFETADOS: Todos com risco de inconsistência
```

---

## 8. Análise de Probabilidade × Impacto

### Matriz de Risco

```
PROBABILIDADE vs IMPACTO (com SIAFI integrado sem resiliência)

                        Impacto Alto       Impacto Muito Alto
                        (Severidade 🔴)    (Severidade 🔴🔴)
                        
Probabilidade Alta       ████████████      ████████████████
(≥ 1x/ano)               [ZONA VERMELHA]    [ZONA CRÍTICA]
                         Muito Preocupante  DEVE MITIGAR AGORA

Probabilidade Média      ████████           ████████████
(1x a 5 anos)            [ZONA LARANJA]     [ZONA VERMELHA]
                         Preocupante        Mitigação necessária

Probabilidade Baixa      ████               ████████
(> 5 anos)               [ZONA AMARELA]     [ZONA LARANJA]
                         Possível           Plano de contingência

SIAFI (fora do ar): Probabilidade MÉDIA, Impacto MUITO ALTO
→ Situação: ZONA VERMELHA / CRÍTICA - Requer ação imediata
```

---

## 9. Recomendações de Mitigação

### 9.1 Curto Prazo (Imediato)

#### 1️⃣ **Implementar Retry com Backoff Exponencial**
```java
// Pseudo-código
for (int attempt = 0; attempt < MAX_RETRIES; attempt++) {
    try {
        return sendToSIAFI(payment);
    } catch (TimeoutException e) {
        long backoff = Math.pow(2, attempt) * 1000; // 1s, 2s, 4s, 8s...
        Thread.sleep(backoff);
    }
}
```

#### 2️⃣ **Implementar Idempotência**
```java
// SIAFI precisa reconhecer:
// "Já processei este payment_id com este amount"
payment.setIdempotencyKey(UUID.randomUUID());
```

#### 3️⃣ **Circuit Breaker**
```java
// Se SIAFI falha 5x seguidas, pare de tentar por 5 minutos
circuitBreaker.recordFailure();
if (circuitBreaker.isOpen()) {
    // Falha rápido, não gaste tempo esperando
    throw new SIAFIUnavailableException("Circuit aberto");
}
```

#### 4️⃣ **Dead Letter Queue (DLQ)**
```java
// Se não conseguir enviar para SIAFI, coloque em fila para retry posterior
if (SIAFI is unavailable) {
    messageQueue.sendToDeadLetterQueue(payment);
    // Processar quando SIAFI voltar online
}
```

### 9.2 Médio Prazo (1-2 meses)

#### 5️⃣ **Implementar Saga Pattern para Transações Distribuídas**
```
Pagamento distribuído (sem SIAFI como pré-requisito):
1. SIFAP → Banco: "Inicia pagamento"
   └─ Resposta: ✅ ID da transação
2. SIFAP atualiza BD local: "Pagamento iniciado"
3. SIFAP → SIAFI: "Registra movimento financeiro" (async)
   ├─ Se falha: Envia para DLQ, retenta depois
   └─ Se OK: Marca como "reconciliado"
```

#### 6️⃣ **Criar Dashboard de Monitoramento**
- Status em tempo real: SIAFI online/offline?
- Alertas automáticos se SIAFI ficar > 2 minutos indisponível
- Fila de requisições aguardando SIAFI

#### 7️⃣ **Plano de Contingência Operacional**
- Documento: "O que fazer se SIAFI cai?"
- Decisão pré-aprovada: Continuar processando ou parar?
- Comunicação pre-coordenada com SIAFI/Tesouro

### 9.3 Longo Prazo (3-6 meses)

#### 8️⃣ **Modo Degradado / Fallback**
```
Se SIAFI está fora:
├─ Continuar processando pagamentos (Banco + CadÚnico)
├─ Armazenar requisições de SIAFI localmente
├─ Enviar em batch quando SIAFI voltar
└─ Auditoria manual posterior para reconciliação
```

#### 9️⃣ **Redundância / Réplica de SIAFI**
- Tesouro oferece SIAFI-DR (Disaster Recovery)?
- Se não, considerar cache local de dados críticos

#### 🔟 **Assincronia Total**
```
Nova arquitetura (Projeto SIFAP 2.0):
├─ SIFAP processa pagamentos IMEDIATAMENTE (sem aguardar SIAFI)
├─ Banco do Brasil recebe ordem de pagamento
├─ Beneficiário recebe no prazo normal
├─ SIFAP envia para SIAFI via evento assíncrono (event bus)
├─ Se SIAFI falha → Retry automático, sem impacto no pagamento
└─ Auditoria: Reconciliação posterior (não bloqueante)
```

---

## 10. Impacto na Arquitetura SIFAP 2.0 (Modernizado)

### Pergunta: Como isso mudaria na arquitetura moderna?

**SIFAP 2.0 (Proposto) vs SIFAP Legacy (Atual):**

| Aspecto | Legacy | SIFAP 2.0 | Benefício |
|---------|--------|-----------|----------|
| **Integração SIAFI** | Síncrona (bloqueia) | Assíncrona (event-driven) | Isolamento de falhas |
| **Idempotência** | Não tem | Sim (via chaves únicas) | Segurança de retry |
| **Circuit Breaker** | Não tem | Sim (Resilience4j) | Falha rápida, sem travar |
| **Retry Policy** | Manual, inconsistente | Automático com backoff | Resiliência |
| **Dead Letter Queue** | Não tem | Sim (RabbitMQ/Kafka) | Fila de recuperação |
| **Modo Degradado** | Não existe | Sim, prossegue sem SIAFI | Continuidade de negócio |
| **Monitoramento** | Limitado | Completo (Prometheus/Grafana) | Visibilidade |
| **Banco de Dados** | Adabas (monolítico) | PostgreSQL (transactions ACID) | Integridade garantida |

**Resultado**: SIFAP 2.0 seria muito mais resiliente a falhas de SIAFI.

---

## 11. Tabela Resumo de Impactos

| Área | Impacto | Severidade | Tempo Resolução |
|------|--------|-----------|-----------------|
| **Pagamentos** | Bloqueado / Inconsistente | 🔴 CRÍTICO | 2-8h |
| **Beneficiários** | Sem renda, insegurança | 🔴 CRÍTICO | 24-48h |
| **Tesouro** | Falta visibilidade orçamentária | 🔴 CRÍTICO | 2-8h |
| **Auditoria** | Impossível reconciliar | 🟠 ALTO | 24-72h |
| **Operações** | Decisões difíceis, stress | 🟠 ALTO | 2-8h |
| **Imagem Pública** | Dano reputacional | 🟠 ALTO | 1-2 semanas |
| **Conformidade** | TCU/CGU em investigação | 🟠 ALTO | 2-4 semanas |

---

## 12. Conclusão

A falha da integração com SIAFI tem **impacto extremamente crítico** na SIFAP atual:

### 🚨 **Impactos-chave:**
1. **Processamento bloqueado** - Batch mensal paralisa
2. **Beneficiários sem renda** - Impacto social grave
3. **Inconsistências financeiras** - Pagamentos "fantasma"
4. **Impossibilidade de auditoria** - Conformidade comprometida
5. **Sobrecarga operacional** - Equipe em crise

### ✅ **Ações necessárias:**
1. **Imediato**: Implementar retry/circuit breaker/DLQ
2. **Curto prazo**: Plano de contingência operacional
3. **Médio prazo**: Dashboard de monitoramento
4. **Longo prazo**: Arquitetura assíncrona (SIFAP 2.0)

### 📊 **ROI da Mitigação:**
- **Custo**: R$ 50k-150k em desenvolvimento
- **Benefício**: Evitar R$ 500k+ em impactos por hora de parada
- **Payback**: < 1 mês

---

## Referências

- MANUAL-TECNICO-SIFAP-2008.md - Documentação Legacy
- C4 Level 1 Architecture Diagram - SIFAP 2.0
- Business Rules Catalog - Regras de Negócio
- SLA do Tesouro - Conformidade esperada
