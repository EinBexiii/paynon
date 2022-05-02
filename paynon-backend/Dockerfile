FROM openjdk:11

COPY . /usr/app/paynon
WORKDIR /usr/app/paynon

CMD ["java", "-jar", "-Djava.security.egd=file:/dev/./urandom", "paynon-1.0-SNAPSHOT.jar"]
