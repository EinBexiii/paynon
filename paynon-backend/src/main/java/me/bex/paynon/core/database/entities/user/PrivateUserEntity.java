package me.bex.paynon.core.database.entities.user;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import me.bex.paynon.core.database.entities.payment.PaymentEntity;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.NaturalIdCache;

import javax.persistence.*;
import java.util.Set;

@Entity
@NoArgsConstructor
@Table(name = "paynon_users")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@NaturalIdCache
@DynamicInsert
@Getter
@Setter
public class PrivateUserEntity extends UserEntityBase<PrivateUserEntity> {

    @Column(name = "u_googleId")
    private String googleId;

    @Column(name = "u_balance")
    @ColumnDefault(value = "0")
    private int balance;

    @OneToMany(mappedBy = "owner", orphanRemoval = true, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<PaymentEntity> payments;
}
