package com.ecommerce.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "roles")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true, length = 50)
    private String name; // ROLE_ADMIN, ROLE_CUSTOMER, etc.

    @Column(length = 200)
    private String description;
}
