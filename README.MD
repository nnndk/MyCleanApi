# Clean Api Example

Copy project from these article: https://dev.to/0x2e73/creating-a-restful-api-with-net-and-clean-architecture-a-complete-guide-1078

This project is kind of template for my future projects. Is is really simple but there is tried and will be tried 
many features such as clear backend architecture, docker with several projects in one solution, docker-compose with database, 
migrations, etc.

Onion Architecture is used in this project.

## Onion Layers:

1. Entities (Domain) Layer - MyCleanApi.Core - entities for business logic
2. Service (Use-Case) Layer - MyCleanApi.Application - business logic
3. Infrastructure Layer - MyCleanApi.Infrastructure - some external details (db, API of external servicesetc)
4. Presentation (Controller) Layer - MyCleanApi.WebApi - API of this app

Infrastructure and Presentation layers are on the same level of the hierarchy. 

All links are directed inward: 
- Domain Layer -> None (completely independent)
- Service Layer -> Domain Layer
- Infrastructure Layer -> Service Layer & Domain Layer (via Service Layer)
- Presentation Layer -> Infrastructure Layer, Service Layer & Domain Layer (last two - via Infrastructure Layer)
