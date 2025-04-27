# Barber Shop API 🚀

[![Java](https://img.shields.io/badge/Java-17-blue.svg)](https://www.java.com/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.0.6-green.svg)](https://spring.io/projects/spring-boot)

API RESTful para gerenciamento de agendamentos em barbearias, desenvolvida em **Java com Spring Boot**. Permite cadastrar clientes, agendar horários e gerenciar serviços.

## ✨ Funcionalidades Principais

- ✅ **CRUD de Clientes**: Cadastro, leitura, atualização e exclusão de clientes.
- 📅 **Agendamento de Horários**: Registro de agendamentos com data, hora e serviço.
- 🔒 **Autenticação de Usuários**: Segurança com Spring Security e JWT.
- 📊 **Documentação Automática**: Swagger/OpenAPI para fácil integração.
- 🛢 **Banco de Dados**: H2 (desenvolvimento) e PostgreSQL (produção).

## 🛠 Tecnologias Utilizadas

- **Java 17**
- **Spring Boot 3**
- **Spring Data JPA**
- **Spring Security**
- **H2 Database** (Desenvolvimento)
- **PostgreSQL** (Produção)
- **Swagger/OpenAPI 3.0**
- **MapStruct** (Mapeamento de DTOs)

## 🚀 Como Executar

### Pré-requisitos
- JDK 17+
- Maven 3.8+
- PostgreSQL (opcional para produção)

```bash
# 1. Clone o repositório
git clone https://github.com/AdamGabriel2/barber-shop-api.git

# 2. Acesse o diretório
cd barber-shop-api

# 3. Execute o projeto
./mvnw spring-boot:run

# 4. Acesse:
- API: http://localhost:8080/api/clientes
- Swagger: http://localhost:8080/swagger-ui.html
- H2 Console: http://localhost:8080/h2-console (JDBC URL: jdbc:h2:mem:barberdb)
```

## 📚 Documentação da API

### Endpoints Principais

| Método | Endpoint                  | Descrição                           |
|--------|---------------------------|-------------------------------------|
| POST   | `/api/clientes`           | Cadastra um novo cliente            |
| GET    | `/api/clientes`           | Lista todos os clientes             |
| GET    | `/api/clientes/{id}`      | Busca um cliente por ID             |
| PUT    | `/api/clientes/{id}`      | Atualiza um cliente                 |
| DELETE | `/api/clientes/{id}`      | Exclui um cliente                   |

👉 **Documentação Completa:**  
[http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

## 🗂 Estrutura do Projeto

```
src/
├── main/
│   ├── java/com/example/barbershop/
│   │   ├── config/       → Configurações globais
│   │   ├── controller/   → Endpoints REST
│   │   ├── dto/          → Objetos de Transferência de Dados
│   │   ├── exception/    → Tratamento de erros
│   │   ├── model/        → Entidades JPA
│   │   ├── repository/   → Interfaces de Repositório
│   │   ├── service/      → Lógica de Negócios
│   │   └── security/     → Configurações de Segurança
│   └── resources/        → Configurações e scripts SQL
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
