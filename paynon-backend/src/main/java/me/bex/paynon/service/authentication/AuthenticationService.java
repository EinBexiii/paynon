package me.bex.paynon.service.authentication;

import me.bex.paynon.core.database.entities.user.PrivateUserEntity;

public interface AuthenticationService {

    /**
     * Validate if the Google token is Valid
     * @param token Token that is sent from frontend
     * @return {@link PrivateUserEntity}
     */
    PrivateUserEntity validateEntity(String token);
}
