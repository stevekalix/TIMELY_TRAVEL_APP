package com.example.TimelyTrave.repository;

import com.example.TimelyTrave.model.TravelModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TravelRepo extends JpaRepository<TravelModel, Integer> {
    List<TravelModel> findByName(String name);

    List<TravelModel> findByUsername(String username);

}
