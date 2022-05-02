package me.bex.paynon.service.user.impl;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import me.bex.paynon.core.database.entities.payment.PaymentEntity;
import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import me.bex.paynon.core.database.entities.user.PublicUserEntity;
import me.bex.paynon.repository.privateuser.PrivateUserRepository;
import me.bex.paynon.repository.publicuser.PublicUserRepository;
import me.bex.paynon.service.user.UserService;
import me.bex.paynon.uitls.reader.ImageReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.persistence.EntityNotFoundException;
import java.io.IOException;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements UserService {

    private final PrivateUserRepository<PrivateUserEntity, Long> privateUserRepository;
    private final PublicUserRepository<PublicUserEntity, Long> publicUserRepository;
    private final ImageReader imageReader;

    @Autowired
    public UserServiceImpl(PrivateUserRepository<PrivateUserEntity, Long> privateUserRepository, PublicUserRepository<PublicUserEntity, Long> publicUserRepository, ImageReader imageReader) {
        this.privateUserRepository = privateUserRepository;
        this.publicUserRepository = publicUserRepository;
        this.imageReader = imageReader;
    }

    @Override
    public PrivateUserEntity getPrivateUserEntityByGoogleId(String googleId) {
        return privateUserRepository.getUserEntityByGoogleId(googleId);
    }

    @Override
    public PrivateUserEntity createUser(GoogleIdToken.Payload payload) {
        PrivateUserEntity privateUserEntity = new PrivateUserEntity();
        privateUserEntity.setEmail(payload.getEmail());
        privateUserEntity.setBalance(1000);
        privateUserEntity.setFirstName((String) payload.get("given_name"));
        privateUserEntity.setLastName((String) payload.get("family_name"));
        privateUserEntity.setGoogleId(payload.getSubject());
        privateUserEntity.setPayments(new HashSet<>());

        try {
            privateUserEntity.setPicture(imageReader.readImage((String) payload.get("picture")));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return privateUserRepository.save(privateUserEntity);
    }

    @Override
    public PrivateUserEntity getUserByEmail(String email) {
        return privateUserRepository.getUserEntityByEmail(email);
    }

    @Override
    public PrivateUserEntity payment(String email, long targetUserId, int amount) {
        PrivateUserEntity user = getUserByEmail(email);

        if (Objects.isNull(user)) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User does not exists");
        }

        if (user.getBalance() - amount < 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Not enough balance");
        }

        try {
            PrivateUserEntity target = privateUserRepository.getById(targetUserId);
            target.setBalance(target.getBalance() + amount);

            user.setBalance(user.getBalance() - amount);


            int time = (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis());

            PaymentEntity targetPayment = new PaymentEntity();
            targetPayment.setAmount(amount);
            targetPayment.setOwner(target);
            targetPayment.setTarget(publicUserRepository.getById(user.getId()));
            targetPayment.setReceived(true);
            targetPayment.setDate(time);

            target.getPayments().add(targetPayment);
            privateUserRepository.save(target);


            PaymentEntity userPayment = new PaymentEntity();
            userPayment.setAmount(-amount);
            userPayment.setOwner(user);
            userPayment.setTarget(publicUserRepository.getById(targetUserId)); //can't be null
            userPayment.setReceived(false);
            userPayment.setDate(time);

            user.getPayments().add(userPayment);
            return privateUserRepository.save(user);

        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Target does not exists");
        }
    }

    @Override
    public Set<PublicUserEntity> getAllUsers() {
        return publicUserRepository.getAllUsers();
    }
}
