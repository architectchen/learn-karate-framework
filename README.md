# learn-karate-framework

Karate DSL: API Automation and Performance from Zero to Hero

## Section3: Setup

### 5. Environment Setup

| Dependency         | Extension                       |
| ------------------ | ------------------------------- |
| JDK                |                                 |
| Maven              |                                 |
| Git                |                                 |
| Yarn               |                                 |
| Postman            |                                 |
| Visual Studio Code | Cucumber (Gherkin) Full Support |
|                    | Karate Runner                   |
|                    | Extension Pack for Java         |
|                    | Material Icon Theme             |
|                    | Open In Default Browser         |

### 6. Test Project Overview

https://conduit.bondaracademy.com/

### 7. Karate Framework Setup

https://docs.karatelabs.io/

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

https://github.com/karatelabs/karate/blob/v1.5.2/karate-core/src/test/java/com/intuit/karate/core/schema-like.feature

https://github.com/karatelabs/karate/blob/v1.5.2/karate-core/src/test/java/com/intuit/karate/core/schema-like-time-validator.js

## Section 5: Advanced Features

### 28. Cucumber Reporter

https://github.com/damianszczepanik/cucumber-reporting

https://github.com/karatelabs/karate/blob/v1.5.0/karate-demo/src/test/java/demo/DemoTestParallel.java

### 31. JSON Transforms

https://github.com/karatelabs/karate/tree/v1.5.0?tab=readme-ov-file#json-transforms
