package org.nolook_springboot.user.service;

import lombok.RequiredArgsConstructor;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.model.DirectoryDTO;
import org.nolook_springboot.user.db.UserEntity;
import org.nolook_springboot.user.model.UserDTO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserConverter {

    public UserDTO userToDTO(UserEntity userEntity) {
        List<DirectoryDTO> directoryDTOs = userEntity.getDirectories().stream()
                .map(this::convertDirectoryEntityToDTO)
                .collect(Collectors.toList());

        return UserDTO.builder()
                .userName(userEntity.getUserName())
                .email(userEntity.getEmail())
                .dirList(directoryDTOs)
                .build();
    }

    private DirectoryDTO convertDirectoryEntityToDTO(DirectoryEntity directoryEntity) {
        return DirectoryDTO.builder()
                .id(directoryEntity.getId())
                .name(directoryEntity.getDirectoryName())
                .build();
    }
}
