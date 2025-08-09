package com.example.ceptebuldemo.controller;

import com.example.ceptebuldemo.dto.request.CreateUserRequest;
import com.example.ceptebuldemo.dto.request.LoginRequest;
import com.example.ceptebuldemo.dto.request.UpdateUserRequest;
import com.example.ceptebuldemo.dto.response.ApiResponse;
import com.example.ceptebuldemo.dto.response.UserResponse;
import com.example.ceptebuldemo.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register")
    public ResponseEntity<ApiResponse> register(@RequestBody CreateUserRequest request) {
        boolean success = userService.register(request);
        if (success) {
            return ResponseEntity.ok(new ApiResponse(true, "Kayıt başarılı"));
        } else {
            return ResponseEntity.badRequest().body(new ApiResponse(false, "Email zaten kayıtlı"));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        try {
            UserResponse response = userService.login(request);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            return ResponseEntity.status(401).body(new ApiResponse(false, e.getMessage()));
        }
    }


}