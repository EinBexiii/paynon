package me.bex.paynon.repository.publicuser;

import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import me.bex.paynon.core.database.entities.user.PublicUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface PublicUserRepository<T, ID> extends JpaRepository<PublicUserEntity, Long> {

    @Query("from PublicUserEntity e ")
    Set<PublicUserEntity> getAllUsers();
}
