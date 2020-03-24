# Desafio - Sistema de Contas bancárias

## Objetivo

Desenvolver um sistema que irá gerenciar contas bancárias de clientes, permitindo fazer transferências de um cliente para outro e expor o saldo atual da conta, sempre em reais.

## Execução

### Funcionalidade #1 - Criar Conta

Entrada: `<id da conta: opcional>, <nome da conta>, <saldo inicial>`

Fluxo principal:

1. Cliente envia informações da conta
2. O sistema valida todos os dados
3. O sistema responde com as informações da conta criada e um token de autenticação

*Fluxo excepcional*: id da conta já existe

1. Retornar que o id já foi utilizado

Saída: `<id da conta>, <token>`

### Funcionalidade #2 - Transferir dinheiro

Entrada: ​ `<source_account_id>, <destination_account_id>, <amount>`

Fluxo principal:

1. O cliente faz uma requisição com os dados descritos acima
2. O sistema valida todos os dados
3. O sistema computa um débito na conta de origem
4. O sistema computa um crédito na conta de destino

**Fluxo excepcional**: a conta de origem não possui saldo suficiente

1. O sistema cancela a transferência

### Funcionalidade #3 - Consultar saldo
Entrada: ​ `<account_id>`

Fluxo principal:
1. O cliente faz uma requisição com os dados descritos acima
2. O sistema calcula o saldo atual da conta baseado no histórico de transferências
da conta

**Fluxo excepcional**: Conta inexistente
1. O sistema responde que a conta informada não existe

## Entrega do projeto

- O sistema deve expor uma API via HTTP
- A API deve possuir algum mecanismo de autenticação para identificar o cliente que está fazendo as requisições
- Os dados devem ser armazenados em um banco MySql
- Você deverá utilizar Ruby como linguagem de programação, e o uso de frameworks e gems ficará por sua conta!
- Seu projeto deverá ser entregue através do github, em um repositório público ou privado, na sua própria conta do github. Depois envie o link dele para nós. Se você fez eu um repositório privado, dê acesso de leitura para os usuários: *@noelrocha*, *@agramms*, *@silviolrjunior* e *@Marcovecchio*. Se não conseguir compartilhar para todos, compartilhe para pelo menos dois destes usuários.
- Sua solução deverá conter um arquivo README.md com as instruções de como executar o código

## Opcionais ( mas dá pontos extras! )
- Utilizar **Docker** / **Docker Compose** para que sua aplicação possa ser executada dentro de containeres, e o setup do ambiente seja facilitado.
- Se você utilizou gemas ou libs, explicar por que você decidiu utilizá-las.
- Sinta-se à vontade para nos mostrar seu conhecimento no assunto, juntamente com ActiveRecord, migrations e o que mais desejar.
- Mostre a construção do seu projeto! Quanto mais commit melhor!!
