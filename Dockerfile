FROM maven:3.9.8-eclipse-temurin-21-alpine

WORKDIR /app
COPY . .

ENV MAVEN_OPTS="-Xms512m -Xmx2048m -XX:+TieredCompilation -XX:TieredStopAtLevel=1"

RUN cd core && mvn clean package -DskipTests -Dmaven.javadoc.skip=true -Dmaven.test.skip=true

EXPOSE 8080
CMD ["sh", "-c", "cd core && java -Xms512m -Xmx2048m -Dserver.port=${PORT:-8080} -jar target/demo-0.0.1-SNAPSHOT.jar"]
