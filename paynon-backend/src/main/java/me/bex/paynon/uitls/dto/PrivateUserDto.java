package me.bex.paynon.uitls.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import me.bex.paynon.core.database.entities.user.PrivateUserEntity;

import java.util.*;
import java.util.stream.Collectors;

@Builder
@Getter
@Setter
public class PrivateUserDto {


    private Long id;

    private String email;

    @JsonProperty("first_name")
    private String firstName;

    @JsonProperty("last_name")
    private String lastName;

    private byte[] picture;

    @JsonProperty("google_id")
    private String googleId;

    private int balance;

    private List<PaymentDto> payments;


    public static PrivateUserDto toPrivateUserDto(PrivateUserEntity privateUserEntity) {

        if (Objects.isNull(privateUserEntity)) {
            return null;
        }

        List<PaymentDto> paymentDtos = privateUserEntity.getPayments()
                .stream()
                .filter(Objects::nonNull)
                .map(PaymentDto::toPaymentDto)
                .sorted(Comparator.comparingInt(paymentDto -> paymentDto != null ? paymentDto.getDate() : 0))
                .collect(Collectors.toList());

        return PrivateUserDto.builder()
                .id(privateUserEntity.getId())
                .email(privateUserEntity.getEmail())
                .firstName(privateUserEntity.getFirstName())
                .lastName(privateUserEntity.getLastName())
                .picture(privateUserEntity.getPicture())
                .googleId(privateUserEntity.getGoogleId())
                .balance(privateUserEntity.getBalance())
                .payments(paymentDtos)
                .build();
    }
}
