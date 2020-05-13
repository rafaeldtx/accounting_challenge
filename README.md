# Desafio - Sistema de Contas bancárias

O sistema de contas bancárias consiste em uma API que permite o cadastramento de novas contas e a realização de transferências entre elas.

## Como executar

### Requesitos do sistema
- Ruby ([ruby](https://www.ruby-lang.org/pt/downloads/ "ruby"))
- Docker/Docker-compose ([docker](https://docs.docker.com/engine/install "docker") / [docker-compose](https://docs.docker.com/compose/install/ "docker-compose"))
- MySQL ([mysql](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/ "mysql"))

### Utilizando Docker e atribuindo banco de dados

Dentro da pasta do projeto, acesse o terminal e execute os seguintes comandos a seguir:

construa a imagem dos containers
```
$ docker-compose build
```

Execute os containers em background liberando acesso ao terminal
```
$ docker-compose up -d
```
Acesse o terminal ativo do container **"accounting_challenge"**
```
$ docker exec -it accounting_challenge bash
```
Crie o banco de dados e execute as migrações
```
$ rails db:create db:migrate
```

## Rodando testes
Ainda dentro do terminal do container, é possível executar os testes e garantir o funcionamento da aplicação
```
$ bundle exec rspec
```

## Funcionalidades
Durante o desenvolvimento foi utilizado o postman como ferramenta de teste de serviços RESTful. Porém, utilize a ferramenta que deseja para envio de requisições a API e utilize as funcionalidades: Criar conta, Transferir dinheiro e consultar saldo.

### - Criar Conta
**Rota**: 'api/v1/accounts'

**Método**: POST

**Parametros**: `<number (opcional)>, <name>, <amount>`

#### Execução:

Exemplos de estrutura de **entrada**:
```
{ number: 1234, name: 'Account1', amount: 100000 }
```
```
{ name: 'Account1', amount: 100000 }
```

Exemplo de retorno de **sucesso**:
```
{
    data: {
		account: 1234 ,
		token: 'example-token-123'
	}
}
```

Exemplo de retorno **falha**:
```
{
    errors: [ 'exemplo de erro ocorrido na requisição' ],
    message: 'Não foi possível criar conta'
}
```

### Transferir dinheiro
**Rota**: 'api/v1/transactions'

**Método**: POST

**Parametros**: `<account_source>, <account_destination>, <amount>`

#### Execução

Exemplo de estrutura de **entrada**:
```
{ account_source: 1234, account_destination: 4321, amount: 10000 }
```

Exemplo de retorno **sucesso**:
```
{
    data: {
		account_source: 1234,
		account_destination: 4321,
		amount: 10000
	},
    message: 'Transação realizada com sucesso!'
}
```

Exemplo de retorno de **falha**:
```
{
    errors: [ 'exemplo de erro ocorrido na requisição' ]
}
```

### Consultar saldo
**Rota**: 'api/v1/accounts/**número da conta**'

**Método**: GET

#### Execução:

Exemplo de retorno de **sucesso**:
```
{
    data: {
        account: 1234
        amount: 100000
    }
}
```

Exemplo de retorno de **falha**:
```
{
    error: 'Conta não encontrada'
}
```

## Gems usadas
- **rspec-rails ([lib](https://github.com/rspec/rspec-rails "lib")):** Usado para implementação de testes unitários.
- **factory_bot_rails ([lib](https://github.com/thoughtbot/factory_bot_rails "lib")):** Atribuido para facilitar criação e atribuição de instâncias de modelos durante testes do rspec. Usado em criação de 'factories' e na implementação de testes.
- **shoulda-matchers ([lib](https://github.com/thoughtbot/shoulda-matchers "lib")):** Usado para simplificar resultados esperados em testes com sintaxe menos complexa.

## Progresso do projeto

- [x] Setup do Docker
- [x] Setup do banco
- [x] Criação de Model e Migrations
- [x] Criação de endpoints
- [x] Implementação de regras de negócio
- [x] Testes de requisição
- [x] Testes unitários
- [ ] Autenticação de cliente
