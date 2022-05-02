package me.bex.paynon.controller.authentication;

import me.bex.paynon.service.authentication.AuthenticationService;
import me.bex.paynon.uitls.dto.PrivateUserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/authentication")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @Autowired
    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @PostMapping
    public ResponseEntity<PrivateUserDto> validate(@RequestParam("token") String token) {
        return new ResponseEntity<>(PrivateUserDto.toPrivateUserDto(authenticationService.validateEntity(token)),
                HttpStatus.OK);
    }
}
