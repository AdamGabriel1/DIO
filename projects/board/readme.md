# Board de Tarefas em Java com Spring Boot 🚀

[![Java](https://img.shields.io/badge/Java-17-blue.svg)](https://www.java.com/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.0.6-green.svg)](https://spring.io/projects/spring-boot)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Um sistema de gerenciamento de tarefas desenvolvido em Java com Spring Boot, seguindo boas práticas de programação e arquitetura limpa. Ideal para organizar suas atividades diárias!

## ✨ Funcionalidades Principais

- ✅ **CRUD completo de tarefas** (Criar, Ler, Atualizar, Excluir)
- 🗂 **Filtragem de tarefas por status** (Pendente, Em Progresso, Concluída)
- 🔄 **Atualização dinâmica de status**
- 📊 **Documentação automática da API** com Swagger/OpenAPI
- 🛢 **Banco de dados em memória H2** (para desenvolvimento)
- 🔍 **Validação de dados** integrada

## 🛠 Tecnologias Utilizadas

- **Java 17**
- **Spring Boot 3**
- **Spring Data JPA**
- **H2 Database** (Desenvolvimento)
- **Lombok** (Produtividade)
- **SpringDoc OpenAPI 2.x** (Documentação)
- **Maven** (Gerenciamento de Dependências)

## 🚀 Como Executar o Projeto

### Pré-requisitos
- JDK 17+
- Maven 3.8+
- Postman ou similar (opcional)

```bash
# 1. Clone o repositório
git clone https://github.com/AdamGabriel2/board.git

# 2. Acesse o diretório
cd board

# 3. Execute o projeto
./mvnw spring-boot:run

# 4. Acesse os endpoints:
# - API: http://localhost:8080/api/tasks
# - Swagger UI: http://localhost:8080/swagger-ui.html
# - H2 Console: http://localhost:8080/h2-console (JDBC URL: jdbc:h2:mem:taskdb)
```

## 📚 Documentação da API

### Endpoints Principais

| Método | Endpoint                  | Descrição                           |
|--------|---------------------------|-------------------------------------|
| POST   | `/api/tasks`              | Cria uma nova tarefa                |
| GET    | `/api/tasks`              | Lista todas as tarefas              |
| GET    | `/api/tasks/status/{status}` | Filtra tarefas por status         |
| PATCH  | `/api/tasks/{id}/status`  | Atualiza o status de uma tarefa     |
| DELETE | `/api/tasks/{id}`         | Exclui uma tarefa                   |

**Exemplo de Requisição (POST):**
```json
{
    "title": "Revisar Documentação",
    "description": "Revisar arquivos técnicos do projeto",
    "status": "PENDING"
}
```

👉 **Documentação Completa:**  
[http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

## 🗂 Estrutura do Projeto

```
src/
├── main/
│   ├── java/com/example/board/
│   │   ├── config/       → Configurações globais
│   │   ├── controller/   → Endpoints da API
│   │   ├── exception/    → Tratamento de erros
│   │   ├── model/        → Entidades do banco de dados
│   │   ├── repository/   → Interfaces de acesso a dados
│   │   └── service/      → Lógica de negócios
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
