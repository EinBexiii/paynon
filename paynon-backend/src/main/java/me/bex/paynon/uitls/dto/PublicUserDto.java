package me.bex.paynon.uitls.dto;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import me.bex.paynon.core.database.entities.user.PublicUserEntity;

import java.util.Objects;

@Builder
@Getter
@Setter
public class PublicUserDto {

    private Long id;

    private String email;

    @JsonProperty("first_name")
    private String firstName;

    @JsonProperty("last_name")
    private String lastName;

    private byte[] picture;


    public static PublicUserDto toPublicUserDto(PublicUserEntity publicUserEntity) {

        if (Objects.isNull(publicUserEntity)) {
            return null;
        }

        return PublicUserDto.builder()
                .id(publicUserEntity.getId())
                .email(publicUserEntity.getEmail())
                .firstName(publicUserEntity.getFirstName())
                .lastName(publicUserEntity.getLastName())
                .picture(publicUserEntity.getPicture())
                .build();
    }
}
