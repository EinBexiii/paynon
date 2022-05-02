package me.bex.paynon.service.authentication;

import me.bex.paynon.core.database.entities.user.PrivateUserEntity;

public interface AuthenticationService {

    PrivateUserEntity validateEntity(String token);
}
