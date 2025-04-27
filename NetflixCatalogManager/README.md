# Gerenciador de Catálogos da Netflix - Self-hosted

## Descrição

Este projeto implementa um gerenciador de catálogos similar ao da Netflix, utilizando uma aplicação .NET Core self-hosted. A aplicação permite o upload de arquivos, armazenamento de dados em um banco de dados NoSQL (CosmosDB) e a recuperação de registros.

## Funcionalidades

- **Upload de Arquivos**: Permite o upload de arquivos para um Azure Storage Account.
- **Adicionar Itens ao Catálogo**: Salva informações sobre filmes ou séries em um banco de dados CosmosDB.
- **Filtrar Registros**: Recupera itens do catálogo com base em critérios de gênero.
- **Listar Registros**: Exibe todos os itens armazenados no catálogo.

## Pré-requisitos

- [.NET SDK](https://dotnet.microsoft.com/download) (versão 6.0 ou superior)
- Conta no Azure com CosmosDB e Azure Storage configurados

## Configuração

### 1. Configuração do Ambiente

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/NetflixCatalogManager.git
   cd NetflixCatalogManager
   ```

2. **Crie um Banco de Dados CosmosDB** no Azure e anote a URL e a chave de acesso.

3. **Crie uma Conta de Armazenamento** no Azure para armazenar os arquivos.

### 2. Configuração do Projeto

1. **Edite o arquivo `appsettings.json`:**
   Altere as configurações para incluir suas credenciais do CosmosDB e do Azure Storage:
   ```json
   {
     "CosmosDb": {
       "Account": "YOUR_COSMOSDB_ACCOUNT",
       "Key": "YOUR_COSMOSDB_KEY",
       "DatabaseName": "YOUR_DATABASE_NAME",
       "ContainerName": "YOUR_CONTAINER_NAME"
     },
     "BlobStorage": {
       "ConnectionString": "YOUR_STORAGE_CONNECTION_STRING",
       "ContainerName": "YOUR_CONTAINER_NAME"
     }
   }
   ```

### 3. Executando o Projeto

1. **Compile a aplicação:**
   ```bash
   dotnet build
   ```

2. **Execute a aplicação:**
   ```bash
   dotnet run
   ```

3. **Teste os Endpoints:**
   Use uma ferramenta como [Postman](https://www.postman.com/) ou `curl` para interagir com a API.

   - **Upload de Arquivos:**
     - `POST /api/catalog/upload`
     - Body: Form-data com o arquivo

   - **Adicionar Itens ao Catálogo:**
     - `POST /api/catalog/add`
     - Body: JSON com os dados do item (exemplo):
       ```json
       {
         "Title": "Example Movie",
         "Description": "An example movie description.",
         "Genre": "Action"
       }
       ```

   - **Filtrar Registros:**
     - `GET /api/catalog/filter/{genre}`
     - Exemplo: `/api/catalog/filter/Action`

   - **Listar Registros:**
     - `GET /api/catalog/list`

## Contribuição

Sinta-se à vontade para contribuir com melhorias ou correções. Para isso, siga os seguintes passos:

1. Fork este repositório.
2. Crie uma nova branch (`git checkout -b feature/your-feature`).
3. Realize suas alterações e faça commit (`git commit -m 'Add some feature'`).
4. Envie para o seu repositório (`git push origin feature/your-feature`).
5. Abra um Pull Request.
