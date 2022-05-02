package me.bex.paynon.controller.user;

import com.sun.security.auth.UserPrincipal;
import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import me.bex.paynon.service.user.UserService;
import me.bex.paynon.uitls.dto.PrivateUserDto;
import me.bex.paynon.uitls.dto.PublicUserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<PrivateUserEntity> getPrivate(@AuthenticationPrincipal UserPrincipal userPrincipal) {
        return new ResponseEntity<>(userService.getUserByEmail(userPrincipal.getName()), HttpStatus.OK);
    }

    @PostMapping("/payment")
    public ResponseEntity<PrivateUserDto> createPayment(@AuthenticationPrincipal UserPrincipal userPrincipal,
                                                        @RequestParam int amount,
                                                        @RequestParam long targetUserId) {

        return new ResponseEntity<>(PrivateUserDto.toPrivateUserDto(userService.payment(userPrincipal.getName(),
                targetUserId, amount)), HttpStatus.OK);
    }

    @GetMapping("/all")
    public ResponseEntity<Set<PublicUserDto>> getAllUsers(@AuthenticationPrincipal UserPrincipal userPrincipal) {
        Set<PublicUserDto> users = userService.getAllUsers()
                .stream()
                .filter(Objects::nonNull)
                .filter(publicUserEntity -> !publicUserEntity.getEmail().equals(userPrincipal.getName()))
                .map(PublicUserDto::toPublicUserDto)
                .collect(Collectors.toSet());

        return new ResponseEntity<>(users, HttpStatus.OK);
    }
}
