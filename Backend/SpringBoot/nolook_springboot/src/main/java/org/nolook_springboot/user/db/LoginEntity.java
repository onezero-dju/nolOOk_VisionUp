package org.nolook_springboot.user.db;

import jakarta.persistence.Entity;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class LoginEntity {
    private String password;
    private String email;
}
