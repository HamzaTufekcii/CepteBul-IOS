package com.example.ceptebuldemo.dto.response;

import lombok.Data;

@Data
public class UserResponse {
    private String id;
    private String email;
    private String name;
    private String surname;
    private String token;
}
