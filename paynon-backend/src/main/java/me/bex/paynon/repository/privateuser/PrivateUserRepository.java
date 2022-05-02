package me.bex.paynon.repository.privateuser;

import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface PrivateUserRepository<T, ID> extends JpaRepository<PrivateUserEntity, Long> {

    @Query("from PrivateUserEntity e where e.googleId =:googleId")
    PrivateUserEntity getUserEntityByGoogleId(String googleId);

    @Query("from PrivateUserEntity e where e.email =:email")
    PrivateUserEntity getUserEntityByEmail(String email);
}
