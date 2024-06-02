package org.nolook_springboot.directory.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.db.DirectoryRepository;
import org.nolook_springboot.directory.model.DirRequest;
import org.nolook_springboot.user.db.UserEntity;
import org.nolook_springboot.user.db.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class DirService {
    private final DirectoryRepository directoryRepository;
    private final UserRepository userRepository;

    public void DirSave(DirRequest dirRequest, UserDetails userDetails){
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user email"));

        var entity = DirectoryEntity
                .builder()
                .user(user)
                .directoryName(dirRequest.getDirectoryName())
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();

        directoryRepository.save(entity);
    }

    public List<DirectoryEntity> getDirectories(UserDetails userDetails){
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user email"));

        return directoryRepository.findAllByUser(user);
    }
}
