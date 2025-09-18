# Etapa 1: build
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app

# Copia tudo
COPY . .

# Dá permissão de execução ao mvnw
RUN chmod +x mvnw

# Faz o build
RUN ./mvnw clean package -DskipTests

# Etapa 2: imagem final
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
