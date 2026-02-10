package com.example.santanderdevweek2023.service;

import com.example.santanderdevweek2023.model.FeatureToggle;
import com.example.santanderdevweek2023.repository.FeatureToggleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FeatureToggleService {
    private final FeatureToggleRepository repository;

    @CacheEvict(value = "featureToggles", allEntries = true)
    public FeatureToggle updateToggle(String featureName, boolean status) {
        FeatureToggle toggle = repository.findById(featureName)
            .orElse(new FeatureToggle(featureName, status, LocalDateTime.now()));
        toggle.setEnabled(status);
        return repository.save(toggle);
    }

    @Cacheable(value = "featureToggles")
    public boolean isFeatureEnabled(String featureName) {
        return repository.findByFeatureName(featureName)
            .map(FeatureToggle::isEnabled)
            .orElse(false);
    }
}
