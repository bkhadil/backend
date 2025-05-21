FROM maven:3.9.8-eclipse-temurin-21-alpine

WORKDIR /app
COPY . .

# Build avec gestion de mémoire
ENV MAVEN_OPTS="-Xmx512m -XX:+TieredCompilation -XX:TieredStopAtLevel=1"

RUN cd core && \
    mvn clean package -DskipTests -Dmaven.javadoc.skip=true -Dmaven.test.skip=true

EXPOSE 8080
CMD ["sh", "-c", "cd core && java -Dserver.port=${PORT:-8080} -jar target/demo-0.0.1-SNAPSHOT.jar"]
