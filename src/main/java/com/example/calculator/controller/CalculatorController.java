package com.example.calculator.controller;

import com.example.calculator.model.CalculationRequest;
import com.example.calculator.service.CalculatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/calculator")
public class CalculatorController {

    private final CalculatorService calculatorService;

    @Autowired
    public CalculatorController(CalculatorService calculatorService) {
        this.calculatorService = calculatorService;
    }

    @PostMapping("/add")
    public ResponseEntity<Double> add(@RequestBody CalculationRequest request) {
        double result = calculatorService.add(request.getA(), request.getB());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/subtract")
    public ResponseEntity<Double> subtract(@RequestBody CalculationRequest request) {
        double result = calculatorService.subtract(request.getA(), request.getB());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/multiply")
    public ResponseEntity<Double> multiply(@RequestBody CalculationRequest request) {
        double result = calculatorService.multiply(request.getA(), request.getB());
        return ResponseEntity.ok(result);
    }

    @PostMapping("/divide")
    public ResponseEntity<?> divide(@RequestBody CalculationRequest request) {
        try {
            double result = calculatorService.divide(request.getA(), request.getB());
            return ResponseEntity.ok(result);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}