package com.example.santanderdevweek2023.repository;

import com.example.santanderdevweek2023.model.FeatureToggle;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

@CacheConfig(cacheNames = "featureToggles")
public interface FeatureToggleRepository extends JpaRepository<FeatureToggle, String> {
    @Cacheable
    Optional<FeatureToggle> findByFeatureName(String featureName);
}
