# Etapa 1: build
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app

# Copia o código fonte e o wrapper do Maven
COPY . .

# Faz o build (gera o JAR na pasta target)
COPY pom.xml ./
COPY src ./src
RUN ./mvnw clean package -DskipTests

# Etapa 2: imagem final
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copia o jar gerado da etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Porta exposta
EXPOSE 8080

# Executa a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
