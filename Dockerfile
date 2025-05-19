# Étape 1 : Image de base avec Maven et JDK 21
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build

# Étape 2 : Copie des fichiers sources
WORKDIR /app
COPY . .

# Étape 3 : Build du projet
RUN cd core && \
    mvn clean package -DskipTests

# Étape 4 : Image finale avec JRE uniquement
FROM eclipse-temurin:21-jre-alpine

# Étape 5 : Copie du JAR construit
COPY --from=build /app/core/target/demo-0.0.1-SNAPSHOT.jar /app/app.jar

# Étape 6 : Commande de démarrage
CMD ["sh", "-c", "java -Dserver.port=$PORT -jar /app/app.jar"]

