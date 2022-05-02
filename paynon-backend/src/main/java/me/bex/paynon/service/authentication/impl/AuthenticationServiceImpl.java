package me.bex.paynon.service.authentication.impl;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.sun.security.auth.UserPrincipal;
import lombok.SneakyThrows;
import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import me.bex.paynon.service.authentication.AuthenticationService;
import me.bex.paynon.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {

    private final UserService userService;

    @Autowired
    public AuthenticationServiceImpl(UserService userService) {
        this.userService = userService;
    }

    @Override
    @SneakyThrows
    public PrivateUserEntity validateEntity(String token) {
        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(GoogleNetHttpTransport.newTrustedTransport(),
                GsonFactory.getDefaultInstance()).build();

        GoogleIdToken googleIdToken = null;

        try {
            googleIdToken = verifier.verify(token);
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Token has wrong format");
        }


        if (googleIdToken != null) {
            GoogleIdToken.Payload payload = googleIdToken.getPayload();

            PrivateUserEntity privateUserEntity = userService.getPrivateUserEntityByGoogleId(payload.getSubject());

            if (privateUserEntity == null) {
                privateUserEntity = userService.createUser(payload);
            }

            UserPrincipal userPrincipal = new UserPrincipal(payload.getEmail());

            Authentication authentication = new UsernamePasswordAuthenticationToken(userPrincipal, null, Collections.emptyList());
            SecurityContextHolder.getContext().setAuthentication(authentication);

            return privateUserEntity;

        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Token is not valid");
        }
    }
}
