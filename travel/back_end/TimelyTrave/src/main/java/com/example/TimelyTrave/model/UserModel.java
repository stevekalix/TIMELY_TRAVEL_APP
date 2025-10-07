package com.example.TimelyTrave.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="User_log_sign")
public class UserModel {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int id;

    @Column(name = "username" , unique = true,  nullable = true)
    private String username;

    @Column(name = "password",length = 100 ,nullable = true)
    private String password;

    @Column(name = "email" , unique = true, nullable = true)
    private String email;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_pro_id")
    private ProfileModel profile;


    @OneToMany( cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_trave_id")
    private List<TravelModel> travels = new ArrayList<>();


}
