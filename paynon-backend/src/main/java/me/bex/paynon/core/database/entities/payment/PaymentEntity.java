package me.bex.paynon.core.database.entities.payment;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import me.bex.paynon.core.database.entities.user.PrivateUserEntity;
import me.bex.paynon.core.database.entities.user.PublicUserEntity;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.NaturalIdCache;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Table(name = "paynon_payments")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@NaturalIdCache
@DynamicInsert
@Getter
@Setter
public class PaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "p_id", updatable = false, unique = true, nullable = false)
    private Long id;

    @Column(name = "p_date")
    private int date;

    @Column(name = "p_amount")
    private int amount;

    @Column(name = "p_received")
    private boolean received;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "target_id", referencedColumnName = "u_id")
    private PublicUserEntity target;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id", referencedColumnName = "u_id")
    private PrivateUserEntity owner;

}
