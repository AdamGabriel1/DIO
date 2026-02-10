package com.example.santanderdevweek2023.controller;

import com.example.santanderdevweek2023.model.FeatureToggle;
import com.example.santanderdevweek2023.service.FeatureToggleService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin/features")
@RequiredArgsConstructor
public class FeatureToggleController {
    private final FeatureToggleService service;

    @Operation(summary = "Atualiza status de uma feature")
    @PostMapping("/{featureName}")
    public ResponseEntity<FeatureToggle> setFeatureStatus(
        @PathVariable String featureName, 
        @RequestParam boolean enabled
    ) {
        return ResponseEntity.ok(service.updateToggle(featureName, enabled));
    }
}
