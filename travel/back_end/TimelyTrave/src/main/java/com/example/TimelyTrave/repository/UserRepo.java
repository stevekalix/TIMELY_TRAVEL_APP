package com.example.TimelyTrave.repository;

import com.example.TimelyTrave.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepo extends JpaRepository<UserModel,Integer> {
    <T> Optional<T> findByUsernameAndPassword(String username, String password);

    Optional<?> findByEmailAndPassword(String attr0, String email);


    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    Optional<UserModel> findByEmail(String email);

}
