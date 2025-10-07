package com.example.TimelyTrave.repository;

import com.example.TimelyTrave.model.ProfileModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProfileRepo extends JpaRepository<ProfileModel,Integer> {
    Optional<ProfileModel> findByEmail(String email);

    Optional<ProfileModel> findByUsername(String attr0);
}
