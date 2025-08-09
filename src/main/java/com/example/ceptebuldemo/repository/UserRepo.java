package com.example.ceptebuldemo.repository;

import com.example.ceptebuldemo.model.User;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public class UserRepo {
    private final Map<String, User> usersByEmail = new HashMap<>();

    public User save(User user) {
        usersByEmail.put(user.getEmail(), user);
        return user;
    }

    public Optional<User> findById(String id) {
        return Optional.ofNullable(usersByEmail.values().stream()
                .filter(user -> user.getId().equals(id))
                .findFirst()
                .orElse(null));
    }

    public Optional<User> findByEmail(String email) {
        return Optional.ofNullable(usersByEmail.get(email));
    }

}
