# Microsserviço de Validação de CPFs

Este projeto é um microsserviço simples para validação de CPF (Cadastro de Pessoas Físicas) desenvolvido em Node.js usando o framework Express. O serviço pode ser executado localmente ou em um ambiente Docker.

## Funcionalidades

- Valida CPFs de acordo com as regras brasileiras.
- Responde com um JSON indicando se o CPF é válido ou inválido.
- Implementação simples e fácil de usar.

## Tecnologias Utilizadas

- **Node.js**: Ambiente de execução JavaScript.
- **Express.js**: Framework para construção de aplicações web.
- **Docker** (opcional): Para containerização da aplicação.

## Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

- [Node.js](https://nodejs.org/) (inclui npm)
- [Docker](https://www.docker.com/) (opcional)

## Instalação

1. Clone o repositório:

   ```bash
   git clone <URL do repositório>
   cd cpf-validator
   ```

2. Instale as dependências:

   ```bash
   npm install
   ```

## Execução do Servidor

Para executar o servidor, utilize o seguinte comando:

```bash
node server.js
```

O servidor estará disponível em `http://localhost:3000`.

### Testando o Serviço

Você pode testar a validação de CPF acessando a seguinte URL em seu navegador ou usando uma ferramenta como o Postman:

```
http://localhost:3000/validate?cpf=<seu_cpf>
```

Substitua `<seu_cpf>` pelo CPF que você deseja validar.

## Opção: Executar com Docker

Para executar o serviço usando Docker:

1. **Construir a imagem Docker**:

   ```bash
   docker build -t cpf-validator .
   ```

2. **Executar o contêiner**:

   ```bash
   docker run -p 3000:3000 cpf-validator
   ```

O serviço estará disponível na mesma URL: `http://localhost:3000`.

## Estrutura do Projeto

```
cpf-validator/
├── server.js          # Arquivo principal do servidor
├── package.json       # Dependências e configurações do projeto
└── Dockerfile         # Arquivo para construção da imagem Docker (opcional)
```

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir um pull request ou relatar problemas.
