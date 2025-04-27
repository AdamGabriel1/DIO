# Documentação do Projeto: Mega Man Robots API

## Introdução

A **Mega Man Robots API** é uma API desenvolvida em .NET Core projetada para fornecer dados sobre os robôs da série Mega Man. Este projeto utiliza práticas modernas de desenvolvimento, como Entity Framework Core e RESTful API design, para garantir uma comunicação clara e eficaz.

## Objetivo

O objetivo desta documentação é fornecer uma visão clara e organizada sobre como utilizar a API, suas funcionalidades e a estrutura do código. A documentação foi criada com a ajuda de ferramentas de inteligência artificial para garantir clareza e precisão.

## Estrutura do Projeto

### 1. Arquitetura

A arquitetura da API é baseada nos seguintes componentes:

- **Controllers**: Gerenciam as rotas dos endpoints.
- **Models**: Definem os modelos de dados utilizados no banco de dados.
- **Services**: Contêm as regras de negócios.
- **Middlewares**: Funções intermediárias que manipulam as requisições HTTP.
- **Database**: Estruturas relacionadas ao banco de dados, incluindo DTOs e Entity Framework.

### 2. Endpoints da API

A API possui os seguintes endpoints principais:

| Método | Endpoint               | Descrição                                   |
|--------|-----------------------|---------------------------------------------|
| GET    | /api/v1/robots        | Retorna uma lista de todos os robôs.       |
| GET    | /api/v1/robots/{id}   | Retorna detalhes de um robô específico.    |
| POST   | /api/v1/robots        | Cria uma nova entrada de robô.              |

### 3. Tecnologias Utilizadas

- **Entity Framework Core**: Utilizado como ORM para gerenciamento de dados.
- **ASP.NET Core**: Framework principal para construção da API.
- **Newtonsoft.Json**: Para manipulação de dados JSON.

## Instalação

### Pré-requisitos

- [.NET Core SDK](https://dotnet.microsoft.com/download) (versão 3.1 ou superior)
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (ou outro banco de dados suportado)

### Passos para Configuração

1. **Clone o Repositório**:
   ```bash
   git clone https://github.com/felipeAguiarCode/MegaApiDotnetCore.git
   cd MegaApiDotnetCore
   ```

2. **Instale as Dependências**:
   ```bash
   dotnet restore
   ```

3. **Configure o Banco de Dados**:
   - Ajuste a string de conexão no arquivo `appsettings.json`.

4. **Execute as Migrations**:
   ```bash
   dotnet ef database update
   ```

5. **Inicie a Aplicação**:
   ```bash
   dotnet run
   ```

## Exemplos de Uso

### 1. Listar Todos os Robôs

```bash
GET /api/v1/robots
```

### 2. Obter Detalhes de um Robô

```bash
GET /api/v1/robots/{id}
```

### 3. Criar um Novo Robô

```bash
POST /api/v1/robots
Content-Type: application/json

{
  "name": "New Robot",
  "abilities": ["Ability 1", "Ability 2"]
}
```

## Conclusão

A **Mega Man Robots API** fornece uma solução robusta para acessar informações sobre os robôs da série Mega Man. Esta documentação, elaborada com o auxílio de ferramentas de inteligência artificial, visa facilitar a compreensão e o uso da API.

