# Calculator Application

This is a simple calculator application built with Spring Boot. It provides basic arithmetic operations such as addition, subtraction, multiplication, and division through a RESTful API.

## Features

- Perform basic arithmetic operations:
  - Addition
  - Subtraction
  - Multiplication
  - Division (with error handling for division by zero)

## Project Structure

```
calculator-app
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── example
│   │   │           └── calculator
│   │   │               ├── CalculatorApplication.java
│   │   │               ├── controller
│   │   │               │   └── CalculatorController.java
│   │   │               ├── service
│   │   │               │   └── CalculatorService.java
│   │   │               └── model
│   │   │                   └── CalculationRequest.java
│   │   └── resources
│   │       └── application.properties
│   └── test
│       └── java
│           └── com
│               └── example
│                   └── calculator
│                       ├── CalculatorApplicationTests.java
│                       ├── controller
│                       │   └── CalculatorControllerTest.java
│                       └── service
│                           └── CalculatorServiceTest.java
├── pom.xml
└── README.md
```

## Setup Instructions

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/calculator-app.git
   ```

2. Navigate to the project directory:
   ```
   cd calculator-app
   ```

3. Build the project using Maven:
   ```
   mvn clean install
   ```

4. Run the application:
   ```
   mvn spring-boot:run
   ```

## API Endpoints

### Addition

- **Endpoint:** `POST /api/calculate/add`
- **Request Body:**
  ```json
  {
    "a": 5,
    "b": 3
  }
  ```
- **Response:**
  ```json
  {
    "result": 8
  }
  ```

### Subtraction

- **Endpoint:** `POST /api/calculate/subtract`
- **Request Body:**
  ```json
  {
    "a": 5,
    "b": 3
  }
  ```
- **Response:**
  ```json
  {
    "result": 2
  }
  ```

### Multiplication

- **Endpoint:** `POST /api/calculate/multiply`
- **Request Body:**
  ```json
  {
    "a": 5,
    "b": 3
  }
  ```
- **Response:**
  ```json
  {
    "result": 15
  }
  ```

### Division

- **Endpoint:** `POST /api/calculate/divide`
- **Request Body:**
  ```json
  {
    "a": 6,
    "b": 3
  }
  ```
- **Response:**
  ```json
  {
    "result": 2
  }
  ```

- **Error Handling for Division by Zero:**
  If `b` is `0`, the response will be:
  ```json
  {
    "error": "Division by zero is not allowed."
  }
  ```

## Testing

Unit tests are included for the application to ensure the correctness of the functionality. You can run the tests using:
```
mvn test
```

## License

This project is licensed under the MIT License.# Calulator-springboot
