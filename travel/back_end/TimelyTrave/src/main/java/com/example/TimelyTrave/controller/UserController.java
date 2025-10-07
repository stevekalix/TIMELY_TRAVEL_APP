package com.example.TimelyTrave.controller;


import com.example.TimelyTrave.model.UserModel;
import com.example.TimelyTrave.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserRepo userRepo;

    // Signup
    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody UserModel user) {

        if (userRepo.existsByUsername(user.getUsername())) {
            return ResponseEntity.badRequest().body("Username already taken");
        }

        if (userRepo.existsByEmail(user.getEmail())) {
            return ResponseEntity.badRequest().body("Email already registered");
        }

        if (user.getPassword().length() < 6) {
            return ResponseEntity.badRequest().body("Password too short");
        }

        userRepo.save(user);
        return ResponseEntity.ok("Signup successful");
    }

    //login
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserModel user) {
        return userRepo.findByUsernameAndPassword(user.getUsername(), user.getPassword())
                .or(() -> userRepo.findByEmailAndPassword(user.getEmail(), user.getPassword()))
                .map(u -> ResponseEntity.ok("Login successful"))
                .orElse(ResponseEntity.badRequest().body("Invalid credentials"));
    }

    @PostMapping("/forget/{email}")
    public ResponseEntity<String> updatePassword(@RequestBody UserModel requestUser, @PathVariable String email) {
        Optional<UserModel> userOptional = userRepo.findByEmail(email);
        if(userOptional.isPresent()) {
            UserModel user = userOptional.get();
            user.setPassword(requestUser.getPassword());
            userRepo.save(user);
            return ResponseEntity.ok("Password updated successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User with email " + email + " not found");
        }
    }


    @PutMapping("/updateCredentials")
    public ResponseEntity<?> updateCredentials(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");          // current email
            String oldPassword = request.get("oldPassword");
            String newPassword = request.get("newPassword");
            String newUsername = request.get("newUsername");
            String newEmail = request.get("newEmail");

            Optional<UserModel> optionalUser = userRepo.findByEmail(email);
            if (optionalUser.isPresent()) {
                UserModel user = optionalUser.get();

                if (!user.getPassword().equals(oldPassword)) {
                    return ResponseEntity.badRequest().body("Old password is incorrect");
                }

                if (newUsername != null && !newUsername.equals(user.getUsername())) {
                    if (userRepo.existsByUsername(newUsername)) {
                        return ResponseEntity.badRequest().body("Username already taken");
                    }
                    user.setUsername(newUsername);
                }

                if (newEmail != null && !newEmail.equals(user.getEmail())) {
                    if (userRepo.existsByEmail(newEmail)) {
                        return ResponseEntity.badRequest().body("Email already registered");
                    }
                    user.setEmail(newEmail);
                }

                if (newPassword != null) {
                    if (newPassword.length() < 6) {
                        return ResponseEntity.badRequest().body("Password too short");
                    }
                    user.setPassword(newPassword);
                }

                // Save changes
                userRepo.save(user);
                return ResponseEntity.ok("Username, email, and password updated successfully");

            } else {
                return ResponseEntity.status(404).body("User not found");
            }

        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error: " + e.getMessage());
        }
    }

}



