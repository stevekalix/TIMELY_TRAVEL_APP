package com.example.TimelyTrave.controller;

import com.example.TimelyTrave.model.SugessionModel;
import com.example.TimelyTrave.repository.SugessionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
public class SugessionController {

    @Autowired
    private SugessionRepo sugessionRepo;



    @GetMapping("/{place}/{date}")
    public ResponseEntity<?> getByPlaceAndDate(
            @PathVariable String place,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        try {
            List<SugessionModel> result = sugessionRepo.findByPlaceAndStartdate(place, date);

            if (result.isEmpty()) {
                return ResponseEntity.ok("No records found for place=" + place + " and date=" + date);
            }
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace(); // logs to console
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }
}
