package com.demo.productapi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
<<<<<<< HEAD
            .csrf().disable()
            .authorizeHttpRequests(authorize -> authorize
                .requestMatchers("/actuator/health").permitAll()  // Allow access to /actuator/health without authentication
                .requestMatchers("/products/**").permitAll()      // Allow access to /products/** without authentication
                .anyRequest().authenticated()                     // All other requests require authentication
=======
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .anyRequest().authenticated()
>>>>>>> 045813716be2ab36e733bf0af0421167f6c0227a
            )
            .httpBasic();
        return http.build();
    }
}
