package me.bex.paynon.core.database.entities.user;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.NaturalId;
import org.hibernate.annotations.Type;

import javax.persistence.*;

@MappedSuperclass
@Getter
@Setter
public class UserEntityBase<T extends UserEntityBase> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "u_id", updatable = false, unique = true, nullable = false)
    private Long id;

    @NaturalId
    @Column(name = "u_email")
    private String email;

    @Column(name = "u_firstName")
    private String firstName;

    @Column(name = "u_lastName")
    private String lastName;

    @Lob
    @Type(type = "org.hibernate.type.BinaryType")
    @Column(name = "c_picture")
    private byte[] picture;
}
