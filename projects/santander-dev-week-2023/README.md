# Santander Dev Week 2023 - Feature Toggle API 🚀

[![Java](https://img.shields.io/badge/Java-17-blue.svg)](https://www.java.com/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.0.6-green.svg)](https://spring.io/projects/spring-boot)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Uma API REST moderna com **Feature Toggles Dinâmicos** desenvolvida durante a Santander Dev Week 2023. Controle funcionalidades em tempo real sem reiniciar a aplicação!

## ✨ Funcionalidades Principais

- ✅ **CRUD Completo de Features** com Spring Data JPA
- 🎚 **Controle Dinâmico de Funcionalidades** via Endpoint
- 📊 Documentação Automática com **Swagger/OpenAPI**
- 🚀 Deploy Simplificado no **Railway**
- 🔒 Cache em Tempo Real com **Redis**
- 🛠 Integração com **H2** (dev) e **PostgreSQL** (prod)

## 🛠 Tecnologias Utilizadas

- **Java 17** + **Spring Boot 3**
- **Spring Data JPA** + **H2**/**PostgreSQL**
- **Lombok** para Produtividade
- **SpringDoc OpenAPI 2.x**
- **Redis** para Cache Distribuído
- **Railway** para Deploy na Nuvem

## 🚀 Como Executar Localmente

### Pré-requisitos
- JDK 17+
- Maven 3.8+
- Docker (Opcional para Redis)

```bash
# 1. Clone o repositório
git clone https://github.com/AdamGabriel2/santander-dev-week-2023.git

# 2. Entre no diretório
cd santander-dev-week-2023

# 3. Execute com Maven
./mvnw spring-boot:run

# 4. Acesse os endpoints:
# - API: http://localhost:8080/api/features
# - Swagger: http://localhost:8080/swagger-ui.html
# - H2 Console: http://localhost:8080/h2-console (JDBC URL: jdbc:h2:mem:featuredb)
```

## 📚 Documentação da API

Endpoint | Método | Descrição
---|---|---
`/api/features` | GET | Lista todas as features ativas
`/api/features` | POST | Cria uma nova feature
`/admin/features/{featureName}` | POST | Ativa/desativa uma feature

👉 **Acesse a Documentação Completa:**  
[http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

## 🌐 Deploy na Nuvem (Railway)

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=node&plugins=postgresql,redis)

1. Instale o [Railway CLI](https://docs.railway.app/develop/cli)
2. Execute no terminal:
```bash
railway login
railway link
railway up
```
3. Configure as variáveis de ambiente:
```env
DATABASE_URL=postgresql://user:pass@host:port/db
REDIS_URL=redis://:pass@host:port
```

## 🗂 Estrutura do Projeto

```
src/
├── main/
│   ├── java/
│   │   └── com/example/santanderdevweek2023/
│   │       ├── config/       # Configurações Globais
│   │       ├── controller/   # Endpoints REST
│   │       ├── exception/    # Tratamento de Erros
│   │       ├── model/        # Entidades JPA
│   │       ├── repository/   # Spring Data JPA
│   │       └── service/      # Lógica de Negócios
│   └── resources/            # Propriedades e Scripts SQL
```

## 🤝 Como Contribuir

1. Faça um Fork do projeto
2. Crie uma Branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas Mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

