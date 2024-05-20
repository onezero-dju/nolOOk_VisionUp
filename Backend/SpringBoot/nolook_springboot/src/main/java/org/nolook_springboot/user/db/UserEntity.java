package org.nolook_springboot.user.db;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.SQLRestriction;
import org.nolook_springboot.directory.db.DirectoryEntity;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity(name = "user")
@ToString
public class UserEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String userName;
    private String password;
    private String email;
    private LocalDateTime createdAt;

    @OneToMany(
            mappedBy = "user"
    )
    @SQLRestriction("user_id = 'id'")   //@Where 어노테이션은 deprcated 되었다.
    private List<DirectoryEntity> directoryList= List.of();
}
