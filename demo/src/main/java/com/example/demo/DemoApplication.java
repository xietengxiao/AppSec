package com.example.demo;
import java.io.File;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) throws java.io.IOException{

        new File(SquareController.uploadingDir).mkdirs();
        SpringApplication.run(DemoApplication.class, args);
    }

}
