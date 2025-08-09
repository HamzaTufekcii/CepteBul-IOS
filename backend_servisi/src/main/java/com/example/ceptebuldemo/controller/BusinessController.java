package com.example.ceptebuldemo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import com.example.ceptebuldemo.model.Business;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class BusinessController {

    @GetMapping("/api/businesses")
    public List<Business> getAllBusinesses() {
        return List.of(
                new Business("1L", "Büllük Bakkal", "İstanbul"),
                new Business("2L", "Civic Hurdacı", "Ankara"),
                new Business("3L", "Çağ Kuyumculuk", "İstanbul"),
                new Business("4L", "Sergen Market", "Ankara")
        );
    }
}
