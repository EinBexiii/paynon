package me.bex.paynon.service.user;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import me.bex.paynon.core.database.entities.user.PublicUserEntity;
import org.apache.catalina.LifecycleState;

import java.util.Set;

public interface UserService {

    PrivateUserEntity getPrivateUserEntityByGoogleId(String googleId);

    PrivateUserEntity createUser(GoogleIdToken.Payload payload);

    PrivateUserEntity getUserByEmail(String email);

    PrivateUserEntity payment(String email, long targetUserId, int amount);

    Set<PublicUserEntity> getAllUsers();
}
