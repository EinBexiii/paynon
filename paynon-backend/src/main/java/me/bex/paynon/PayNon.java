package me.bex.paynon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan("me.bex.paynon")
@EnableJpaRepositories("me.bex.paynon")
public class PayNon {

    public static void main(String[] args) {
        SpringApplication.run(PayNon.class, args);
    }
}
