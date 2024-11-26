#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# Этап 1: Базовый образ с ASP.NET для запуска приложения
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

# Этап 2: Образ для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Копируем файл решения и файлы проектов для восстановления зависимостей
COPY ["MyCleanApi.sln", "."]
COPY ["MyCleanApi.Core/MyCleanApi.Core.csproj", "MyCleanApi.Core/"]
COPY ["MyCleanApi.Infrastructure/MyCleanApi.Infrastructure.csproj", "MyCleanApi.Infrastructure/"]
COPY ["MyCleanApi.Application/MyCleanApi.Application.csproj", "MyCleanApi.Application/"]
COPY ["MyCleanApi.WebApi/MyCleanApi.WebApi.csproj", "MyCleanApi.WebApi/"]

# Выполняем restore один раз для всего решения
RUN dotnet restore "./MyCleanApi.sln"

# Копируем оставшиеся файлы в контейнер
COPY . .

# Сборка проекта
WORKDIR "/src/MyCleanApi.WebApi"
RUN dotnet build -c Debug -o /app/build

# Этап 3: Публикация проекта
FROM build AS publish
WORKDIR "/src/MyCleanApi.WebApi"
RUN dotnet publish -c Debug -o /app/publish /p:UseAppHost=false

# Этап 4: Создание финального образа
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyCleanApi.WebApi.dll"]