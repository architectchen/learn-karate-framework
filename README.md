# learn-karate-framework

Karate DSL: API Automation and Performance from Zero to Hero

## Section3: Setup

### 5. Environment Setup

| Dependency         | Extension                       |
| ------------------ | ------------------------------- |
| JDK 17             |                                 |
| Maven              |                                 |
| Git                |                                 |
| Yarn               |                                 |
| Postman            |                                 |
| Visual Studio Code | Cucumber (Gherkin) Full Support |
|                    | Karate Runner                   |
|                    | Extension Pack for Java         |
|                    | Material Icon Theme             |
|                    | Open In Default Browser         |
|                    | Scala Syntax (official)         |

### 6. Test Project Overview

https://conduit.bondaracademy.com/

### 7. Karate Framework Setup

https://docs.karatelabs.io/getting-started/quick-start

```bash
mvn archetype:generate \
-DarchetypeGroupId=io.karatelabs \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=1.5.1 \
-DgroupId=com.mycompany \
-DartifactId=myproject
```

## Section 4: API Automation

### 13. Runner Configuration and Tags

```bash
mvn test -Dtest=ConduitApiTest#testTags

mvn test -Dkarate.options="--tags @debug"

@ignore

mvn test -Dkarate.options="--tags ~@skipme"

mvn test -Dkarate.options="classpath:conduitApi/feature/HomePage.feature"

mvn test -Dkarate.options="classpath:conduitApi/feature/HomePage.feature:7"
```

### 16. Environment Variables

```bash
mvn test -Dkarate.env="dev"
```

### 20. Schema Validation

https://github.com/karatelabs/karate/blob/v1.5.0/karate-core/src/test/java/com/intuit/karate/core/schema-like.feature

https://github.com/karatelabs/karate/blob/v1.5.0/karate-core/src/test/java/com/intuit/karate/core/schema-like-time-validator.js

## Section 5: Advanced Features

### 28. Cucumber Reporter

https://github.com/damianszczepanik/cucumber-reporting

https://github.com/karatelabs/karate/blob/v1.5.0/karate-demo/src/test/java/demo/DemoTestParallel.java

### 31. JSON Transforms

https://github.com/karatelabs/karate/tree/v1.5.0?tab=readme-ov-file#json-transforms

### 34. Karate in Docker Container

```bash
docker build -t conduitapi-karate .
docker run -it --rm conduitapi-karate

docker-compose up --build
docker-compose down
```

## Section 6: Performance Testing with Gatling

### 35. Gatling Setup

https://github.com/karatelabs/karate/tree/v1.5.0/karate-gatling

https://github.com/karatelabs/karate/blob/v1.5.0/examples/gatling/pom.xml

```xml
        <dependency>
            <groupId>io.karatelabs</groupId>
            <artifactId>karate-gatling</artifactId>
            <version>${karate.version}</version>
            <scope>test</scope>
        </dependency>
```
