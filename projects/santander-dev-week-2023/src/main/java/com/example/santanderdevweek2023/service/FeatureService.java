package com.example.santanderdevweek2023.service;

import com.example.santanderdevweek2023.model.Feature;
import com.example.santanderdevweek2023.repository.FeatureRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FeatureService {
    private final FeatureRepository repository;

    public Feature create(Feature feature) {
        return repository.save(feature);
    }

    public List<Feature> getAllActive() {
        return repository.findByEnabledTrue();
    }
}
