package com.example.ceptebuldemo.service;

import com.example.ceptebuldemo.dto.request.CreateUserRequest;
import com.example.ceptebuldemo.dto.request.LoginRequest;
import com.example.ceptebuldemo.dto.request.UpdateUserRequest;
import com.example.ceptebuldemo.dto.response.UserResponse;
import com.example.ceptebuldemo.mapper.UserMapper;
import com.example.ceptebuldemo.model.User;
import com.example.ceptebuldemo.repository.UserRepo;
import com.example.ceptebuldemo.utils.IDGenerator;
import com.example.ceptebuldemo.utils.TokenUtil;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    private final UserRepo repo;
    private final UserMapper mapper;

    public UserService(UserRepo repo, UserMapper mapper) {
        this.repo = repo;
        this.mapper = mapper;
    }

    public boolean register(CreateUserRequest request) {
        Optional<User> existingUser = repo.findByEmail(request.getEmail());
        if (existingUser.isPresent()) {
            return false; // Email zaten kullanılıyor
        }
        String id = IDGenerator.generateUserId();

        User user = mapper.toUser(request);// DTO'dan modele çeviri
        user.setId(id);
        repo.save(user);
        return true;
    }

    public UserResponse login(LoginRequest request) {
        User user = repo.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Invalid credentials"));

        if (!passwordMatches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("Invalid credentials");
        }

        String token = TokenUtil.generateToken();
        user.setToken(token);
        repo.save(user);

        return mapper.toUserResponse(user);
    }

    public UserResponse updateUser(UpdateUserRequest request, String id) {
        User user = repo.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        mapper.updateUserFromDto(request, user);
        repo.save(user);

        return mapper.toUserResponse(user);
    }

    // Düz karşılaştırma (şifreleme yok)
    private boolean passwordMatches(String rawPassword, String storedPassword) {
        return rawPassword.equals(storedPassword);
    }

}