package com.example.TimelyTrave.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class TravelModel {



    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int travelId;

    private String username;
    private String name;
    private String source;
    private String destination;
    private LocalDate travelDate;
    private LocalTime travelTime;
    private LocalDateTime createdAt = LocalDateTime.now();
}
