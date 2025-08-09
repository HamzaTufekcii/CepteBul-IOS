package com.example.ceptebuldemo.controller;

import com.example.ceptebuldemo.dto.request.UpdateUserRequest;
import com.example.ceptebuldemo.dto.response.ApiResponse;
import com.example.ceptebuldemo.dto.response.UserResponse;
import com.example.ceptebuldemo.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PutMapping("/{id}/update")
    public ResponseEntity<?> updateUser(@RequestBody UpdateUserRequest request, @PathVariable String id) {
        try {
            UserResponse response = userService.updateUser(request, id);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(new ApiResponse(false, e.getMessage()));
        }
    }

}
