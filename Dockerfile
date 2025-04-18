# -------- 1단계: 빌드 단계 --------
FROM gradle:7.6.2-jdk17-alpine as builder

WORKDIR /app
COPY . .
RUN gradle build -x test

# -------- 2단계: 실행 단계 --------
FROM bellsoft/liberica-openjdk-alpine:17

WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
