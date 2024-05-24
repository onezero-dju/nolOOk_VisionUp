package org.nolook_springboot.user.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.user.db.UserEntity;
import org.nolook_springboot.user.db.UserRepository;
import org.nolook_springboot.user.model.LoginRequest;
import org.nolook_springboot.user.model.UserDTO;
import org.nolook_springboot.user.model.UserRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {
    private final UserRepository userRepository;
    private final UserConverter userConverter;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserDTO register(UserRequest userRequest) {
        var entity = UserEntity.builder()
                .userName(userRequest.getUserName())
                .email(userRequest.getEmail())
                .password(passwordEncoder.encode(userRequest.getPassword()))
                .createdAt(LocalDateTime.now())
                .build();

        userRepository.save(entity);
        return userConverter.userToDTO(entity);
    }

    public UserDTO login(LoginRequest loginRequest) {
        log.info(loginRequest.toString());

        Optional<UserEntity> userOpt = userRepository.findByEmail(loginRequest.getEmail());
        if (userOpt.isPresent()) {
            UserEntity user = userOpt.get();
            log.info("입력받은 비밀번호: " + loginRequest.getPassword());
            log.info("데이터베이스에 있는 비밀번호: " + user.getPassword());

            if (passwordEncoder.matches(loginRequest.getPassword(), user.getPassword())) {
                return userConverter.userToDTO(user);
            } else {
                throw new IllegalArgumentException("Invalid password");
            }
        } else {
            throw new IllegalArgumentException("Invalid email");
        }
    }
}
