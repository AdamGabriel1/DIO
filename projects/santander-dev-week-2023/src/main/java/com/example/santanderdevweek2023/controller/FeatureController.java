package com.example.santanderdevweek2023.controller;

import com.example.santanderdevweek2023.exception.FeatureDisabledException;
import com.example.santanderdevweek2023.model.Feature;
import com.example.santanderdevweek2023.service.FeatureService;
import com.example.santanderdevweek2023.service.FeatureToggleService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/features")
@RequiredArgsConstructor
public class FeatureController {
    private final FeatureService service;
    private final FeatureToggleService toggleService;

    @PostMapping
    public ResponseEntity<Feature> create(@RequestBody Feature feature) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.create(feature));
    }

    @GetMapping
    public ResponseEntity<List<Feature>> getAllActive() {
        if (!toggleService.isFeatureEnabled("FEATURE_LISTING")) {
            throw new FeatureDisabledException("Listing de features está desativado");
        }
        return ResponseEntity.ok(service.getAllActive());
    }
}
