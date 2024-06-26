FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
RUN apk add --no-cache curl
COPY target/productapi-0.0.1-SNAPSHOT.jar /app/product-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "product-api.jar"]
