## Desafio - Sistema de Contas bancárias

### Objetivo

Desenvolver um sistema que irá gerenciar contas bancárias de clientes, permitindo fazer transferências de um cliente para outro e expor o saldo atual da conta, sempre em reais.

### Requesitos do sistema
- Ruby ([ruby](https://www.ruby-lang.org/pt/downloads/ "ruby"))
- Docker/Docker-compose ([docker](https://docs.docker.com/engine/install "docker") / [docker-compose](https://docs.docker.com/compose/install/ "docker-compose"))
- MySQL ([mysql](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/ "mysql"))

### Instalação
##### - Utilizando Docker
No terminal dentro da pasta do projeto execute os comandos:

Construa a imagem dos containers
```
$ docker-compose build
```

Execute os containers em background liberando acesso ao terminal
```
$ docker-compose up -d
``` 
Acesse ao terminal ativo do container **"accounting_challenge"**
```
$ docker exec -it accounting_challenge bash
```
Crie o banco de dados e execute as migrações
```
$ rails db:create db:migrate
```

## Rodando os testes
Ainda dentro do terminal do container, é possível executar os testes e garantir o funcionamento da aplicação
```$ bundle exec rspec```

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
