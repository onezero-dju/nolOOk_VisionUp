package org.nolook_springboot.user.service;

import lombok.RequiredArgsConstructor;
import org.nolook_springboot.user.db.UserEntity;
import org.nolook_springboot.user.model.UserDTO;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserConverter {

    public UserDTO userToDTO(UserEntity userEntity){

        return UserDTO.builder()
                .userName(userEntity.getUserName())
                .email(userEntity.getEmail())
                .build();
    }
}
