## Desafio - Sistema de Contas bancárias

### Objetivo

Desenvolver um sistema que irá gerenciar contas bancárias de clientes, permitindo fazer transferências de um cliente para outro e expor o saldo atual da conta, sempre em reais.

### Requerimentos do sistema
- Ruby ([ruby](https://www.ruby-lang.org/pt/downloads/ "ruby"))
- Docker/Docker-compose ([docker](https://docs.docker.com/engine/install "docker") / [docker-compose](https://docs.docker.com/compose/install/ "docker-compose"))
- MySQL ([mysql](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/ "mysql"))

### Execução
##### - Utilizando Docker
No terminal dentro da pasta do projeto execute os comandos:

`docker-compose build` - Irá construir a imagem dos containers

`docker-compose up -d ` - Irá executar os containers em background liberando acesso ao terminal

`docker exec -it accounting_challenge bash` - Permiti acesso ao terminal ativo do container **"accounting_challenge"**

`rails db:create db:migrate` - Criação do banco de dados e execução de migrações

`bundle exec rspec` - Ainda dentro do container, é possível executar os testes e garantir o funcionamento da aplicação

### Funcionalidades
É recomendado o uso do postman ou outra ferramenta que teste serviços RESTful. Realizando as requisições com o postman é possível testar as seguintes funcionalidades: Criar conta, Transferir dinheiro e consultar saldo.

#### - Criar Conta
Rota: 'api/v1/accounts'
Método: POST
Parametros necessários: `<number (opcional)>, <name>, <amount>`

**ENTRADA**:
Exemplo de estrutura de entrada:
`{ number: 1234, name: 'Account1', amount: 100000 }` ou
`{ name: 'Account1', amount: 100000 }`

**SAÍDA**:
(Exemplo) retorno JSON de sucesso:
```
{
    data: {
		account: 1234 ,
		token: '*exameple_token_123'*
	}
}
```

(Exemplo) retorno JSON de erro:
```
{
    errors: [ '*Example error occured on creation*' ]
    message: "Não foi possível criar conta",
}
```

#### - Transferir dinheiro
Rota: 'api/v1/transactions'
Método: POST
Parametros necessários: `<account_source>, <account_destination>, <amount>`

**ENTRADA**:
Exemplo de estrutura de entrada:
`{ account_source: 1234, account_destination: 4321, amount: 10000 }`

**SAÍDA**:
(Exemplo) retorno JSON de sucesso:
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

(Exemplo) retorno JSON de erro:
```
{
    errors: [ '*Example error occured on creation*' ]
}
```

#### - Consultar saldo
Rota: 'api/v1/accounts/**número da conta**'
Método: GET

**ENTRADA**:
Em rota atribuir número da conta

**SAÍDA**:
(Exemplo) retorno JSON de sucesso:
```
{
    data: {
        account: 1234
        amount: 100000
    }
}
```

(Exemplo) retorno JSON de erro:
```
{
    error: 'Conta não encontrada'
}
```

### Gems usadas
- **rspec-rails ([lib](https://github.com/rspec/rspec-rails "lib")):** Usado para implementação de testes unitários.
- **factory_bot_rails ([lib](https://github.com/thoughtbot/factory_bot_rails "lib")):** Atribuido para facilitar criação e atribuição de instâncias de modelos durante testes do rspec. Usado em criação de 'factories' e na implementação de testes.
- **shoulda-matchers ([lib](https://github.com/thoughtbot/shoulda-matchers "lib")):** Usado para simplificar resultados esperados em testes com sintaxe menos complexa.
