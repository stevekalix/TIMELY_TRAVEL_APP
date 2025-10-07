package com.example.TimelyTrave.repository;

import com.example.TimelyTrave.model.SugessionModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface SugessionRepo extends JpaRepository<SugessionModel,Integer> {
    List<SugessionModel> findByPlaceAndStartdate(String place, LocalDate date);
}
