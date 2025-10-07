package com.example.TimelyTrave.controller;



import com.example.TimelyTrave.model.TravelModel;
import com.example.TimelyTrave.repository.TravelRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;


@RestController
public class TravelController {

    @Autowired
    private TravelRepo  travelRepo;



    @PutMapping("/updateTravelByUsername/{username}")
    public ResponseEntity<?> updateTravelByUsername(
            @PathVariable String username,
            @RequestBody TravelModel travelRequest) {

        List<TravelModel> travels = travelRepo.findByUsername(username); // assuming you have findByUsername in repo
        if (travels.isEmpty()) {
            return ResponseEntity.status(404).body("No travel records found for username: " + username);
        }

        // Update the first matching travel (or loop through all if needed)
        TravelModel travel = travels.get(0);

        travel.setUsername(travelRequest.getUsername());
        travel.setSource(travelRequest.getSource());
        travel.setName(travelRequest.getName());
        travel.setDestination(travelRequest.getDestination());
        travel.setTravelDate(travelRequest.getTravelDate());
        travel.setTravelTime(travelRequest.getTravelTime());
        travel.setCreatedAt(LocalDateTime.now());

        travelRepo.save(travel);
        Object body;
        return ResponseEntity.ok("record added sucessfully");
    }



    @DeleteMapping("/deleteTravel/{id}")
    public ResponseEntity<?> deleteTravelById(@PathVariable int id) {
        Optional<TravelModel> travelOpt = travelRepo.findById(id);
        if (travelOpt.isEmpty()) {
            return ResponseEntity.status(404).body("Travel record not found");
        }

        travelRepo.delete(travelOpt.get());
        return ResponseEntity.ok("Travel record deleted successfully");
    }

    @GetMapping("/get/{user}")
    public List<TravelModel> getTravels(@PathVariable String user) {
        return travelRepo.findByName(user);
    }








}
