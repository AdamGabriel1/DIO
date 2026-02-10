package com.example.santanderdevweek2023.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class FeatureToggle {
    @Id
    private String featureName;
    
    private boolean enabled;
    
    @UpdateTimestamp
    @Column(updatable = false)
    private LocalDateTime lastUpdated;
}
