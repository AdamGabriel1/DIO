# Deploy de uma API na Nuvem

## Descrição

Este projeto demonstra como fazer o deploy de uma API simples na nuvem usando o Azure. A API é construída com Node.js e Express, e o guia inclui todos os passos necessários desde a criação da API até a publicação na nuvem.

## Pré-requisitos

Antes de começar, verifique se você tem os seguintes itens instalados:

- **Conta no Azure**: [Crie uma conta aqui](https://azure.microsoft.com/free/)
- **Node.js**: [Download e instalação](https://nodejs.org/)
- **Azure CLI**: [Instruções de instalação](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli)
- **Git**: [Download e instalação](https://git-scm.com/)

## Passos para o Deploy

### 1. Clonar o Repositório

Clone este repositório para sua máquina local:

```bash
git clone https://github.com/AdamGabriel2/DIO/tree/main/api.git
cd api
```

### 2. Criar a API

A API é simples e se encontra no arquivo `app.js`. Você pode modificar conforme necessário.

### 3. Testar Localmente

Execute a API localmente:

```bash
node app.js
```

Acesse `http://localhost:3000` no seu navegador para verificar se a API está funcionando.

### 4. Criar um Repositório no GitHub

1. Crie um novo repositório no GitHub.
2. Faça commit do seu código e envie para o repositório remoto.

### 5. Criar um App Service no Azure

1. Acesse o [Portal do Azure](https://portal.azure.com).
2. Crie um novo recurso de **App Service** com as configurações desejadas.
3. Escolha o sistema operacional e a stack apropriada (Node.js, Python, etc.).

### 6. Configurar o Deploy Contínuo

1. No App Service criado, vá para **Deployment Center**.
2. Selecione **GitHub** como fonte de deploy.
3. Autentique-se e selecione o repositório que você criou.
4. Defina o branch para o deploy e finalize a configuração.

### 7. Testar a API na Nuvem

Após o deploy, acesse a URL fornecida pelo Azure para testar a API.

### 8. Monitoramento e Logs

Utilize a seção **Logs de Aplicativo** no portal do Azure para monitorar a aplicação e verificar qualquer erro.

## Contribuição

Se você deseja contribuir com este projeto, sinta-se à vontade para abrir uma issue ou enviar um pull request.
