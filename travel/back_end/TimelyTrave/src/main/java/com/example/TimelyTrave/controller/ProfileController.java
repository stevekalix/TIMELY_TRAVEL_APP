package com.example.TimelyTrave.controller;


import com.example.TimelyTrave.model.ProfileModel;
import com.example.TimelyTrave.repository.ProfileRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping
public class ProfileController {

    @Autowired
    private ProfileRepo profileRepo;



    @PostMapping("/save")
    public ResponseEntity<?> insertProfile(@RequestBody ProfileModel profileModel){
        try {
            if (profileModel != null) {
                profileRepo.save(profileModel);
                return ResponseEntity.ok("Profile has been saved successfully");
            }
            return ResponseEntity.badRequest().body("Profile has not been saved");
        } catch (Exception e) {
            e.printStackTrace(); // optional: log the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while saving the profile");
        }

    }



    @PutMapping("/save")
    public ResponseEntity<?> updateProfile(@RequestBody ProfileModel profileModel){
        try {
            if (profileModel != null) {
                profileRepo.save(profileModel);
                return ResponseEntity.ok("Profile has been updated successfully");
            }
            return ResponseEntity.badRequest().body("Profile has not been updated");
        } catch (Exception e) {
            e.printStackTrace(); // optional: log the error
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while update the profile");
        }
    }

    @PutMapping("/updateProfile/{email}")
    public ResponseEntity<?> updateProfile(
            @PathVariable String email,
            @RequestBody ProfileModel profileModel) {
        try {
            // Find the profile by email
            Optional<ProfileModel> existingProfile = profileRepo.findByEmail(email);

            if (existingProfile.isPresent()) {
                ProfileModel profileToUpdate = existingProfile.get();

                // Update fields
                profileToUpdate.setFirstName(profileModel.getFirstName());
                profileToUpdate.setLastName(profileModel.getLastName());
                profileToUpdate.setAddress(profileModel.getAddress());
                profileToUpdate.setCity(profileModel.getCity());
                profileToUpdate.setState(profileModel.getState());
                profileToUpdate.setGender(profileModel.getGender());
                profileToUpdate.setDob(profileModel.getDob());

                // Save updated profile
                profileRepo.save(profileToUpdate);
                return ResponseEntity.ok("Profile has been added successfully");
            } else {
                return ResponseEntity.status(404).body("Profile not found with email to choose the login email: " + email);
            }

        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error: " + e.getMessage());
        }
    }

}
