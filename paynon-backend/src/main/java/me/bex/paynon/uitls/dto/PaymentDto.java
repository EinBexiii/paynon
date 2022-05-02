package me.bex.paynon.uitls.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import me.bex.paynon.core.database.entities.payment.PaymentEntity;
import org.slf4j.Logger;

import java.util.Objects;

@Builder
@Getter
@Setter
@ToString
public class PaymentDto {

    private Long id;

    private int date;

    private int amount;

    private boolean received;

    private PublicUserDto user;


    public static PaymentDto toPaymentDto(PaymentEntity paymentEntity) {

        if (Objects.isNull(paymentEntity)) {
            return null;
        }

        return PaymentDto.builder()
                .id(paymentEntity.getId())
                .date(paymentEntity.getDate())
                .amount(paymentEntity.getAmount())
                .received(paymentEntity.isReceived())
                .user(PublicUserDto.toPublicUserDto(paymentEntity.getTarget()))
                .build();
    }
}
