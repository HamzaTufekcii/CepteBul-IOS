package com.example.ceptebuldemo.utils;

import java.util.UUID;

public class IDGenerator {
    public static String generateUserId() {
        return UUID.randomUUID().toString();
    }
}