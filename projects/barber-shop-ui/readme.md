# Barber Shop UI 🚀

[![Angular](https://img.shields.io/badge/Angular-15-red.svg)](https://angular.io/)
[![TypeScript](https://img.shields.io/badge/TypeScript-4.8-blue.svg)](https://www.typescriptlang.org/)

Interface de usuário para o sistema de agendamento de barbearias, desenvolvida em **Angular**. Integra-se com a API RESTful para cadastro de clientes e agendamentos.

## ✨ Funcionalidades Principais

- ✅ **Cadastro de Clientes**: Formulário para cadastrar novos clientes.
- 📅 **Agendamento de Horários**: Interface para agendar serviços.
- 🔍 **Listagem de Clientes**: Visualização de clientes cadastrados.
- 🎨 **UI Moderna**: Componentes Angular Material e PrimeNG.

## 🛠 Tecnologias Utilizadas

- **Angular 15**
- **Angular Material** (UI Components)
- **PrimeNG** (UI Components Avançados)
- **RxJS** (Programação Reativa)
- **TypeScript 4.8**

## 🚀 Como Executar

### Pré-requisitos
- Node.js 16+
- Angular CLI 15+

```bash
# 1. Clone o repositório
git clone https://github.com/AdamGabriel2/barber-shop-ui.git

# 2. Acesse o diretório
cd barber-shop-ui

# 3. Instale as dependências
npm install

# 4. Execute o projeto
ng serve

# 5. Acesse:
- Frontend: http://localhost:4200
```

## 🗂 Estrutura do Projeto

```
src/
├── app/
│   ├── components/            → Componentes reutilizáveis
│   ├── services/              → Serviços HTTP
│   ├── models/                → Modelos de dados
│   ├── pages/                 → Páginas (Agendamento, Login, etc.)
│   ├── guards/                → Proteção de rotas
│   └── app-routing.module.ts  → Configuração de rotas
├── assets/                    → Imagens, ícones, etc.
└── styles.css                 → Estilos globais
```

## 🤝 Como Contribuir

1. Faça um **fork** do projeto
2. Crie uma branch:  
   `git checkout -b feature/nova-feature`
3. Commit suas mudanças:  
   `git commit -m 'Adiciona nova funcionalidade'`
4. Push para a branch:  
   `git push origin feature/nova-feature`
5. Abra um **Pull Request**
