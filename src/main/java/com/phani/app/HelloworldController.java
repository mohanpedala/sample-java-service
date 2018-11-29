package com.phani.app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloworldController {

    @GetMapping(value = "/hello", produces = "application/json")
    @ResponseBody
    public String sayHello() {
        return "{\"status\":\"hello\"}";
    }
}
