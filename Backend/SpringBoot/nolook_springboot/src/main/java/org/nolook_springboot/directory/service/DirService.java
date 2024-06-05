package org.nolook_springboot.directory.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.db.DirectoryRepository;
import org.nolook_springboot.directory.model.*;
import org.nolook_springboot.memo.db.MemoEntity;
import org.nolook_springboot.memo.db.MemoRepository;
import org.nolook_springboot.memo.service.MemoDirViewConverter;
import org.nolook_springboot.user.db.UserEntity;
import org.nolook_springboot.user.db.UserRepository;
import org.nolook_springboot.util.exception.UnauthorizedAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class DirService {
    private final DirectoryRepository directoryRepository;
    private final UserRepository userRepository;
    private final DirConverter dirConverter;
    private final MemoRepository memoRepository;
    private final MemoDirViewConverter memoDirViewConverter;

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

    public List<DirectoryDTO> getDirectories(UserDetails userDetails){
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user email"));





        List<DirectoryEntity> directories = directoryRepository.findAllByUser(user);
        return directories.stream()
                .map(dirConverter::directoryConverter)
                .collect(Collectors.toList());
    }

    public List<DirMemoViewDTO> getMemoList(DirIdRequest dirIdRequest, UserDetails userDetails) {

        if (dirIdRequest.getDirectoryId() == null) {
            throw new IllegalArgumentException("Directory ID must not be null");
        }

        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user email"));



        DirectoryEntity directoryEntity=directoryRepository.findById(dirIdRequest.getDirectoryId())
                .orElseThrow(() -> new IllegalArgumentException("Invalid Directory ID"));

        List<MemoEntity> memoEntities = memoRepository.findAllByDirectory(directoryEntity);

        return memoEntities.stream()
                .map(memoDirViewConverter::memoDirectoryViewConverter).collect(Collectors.toList());



    }

    public void dirNameChange(DirNameChangeRequest dirNameChangeRequest, UserDetails userDetails) {
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user email"));


        DirectoryEntity directoryEntity = directoryRepository.findById(dirNameChangeRequest.getDirectoryId())
                .orElseThrow(()->new IllegalArgumentException("Invalid directory id"));


        if (!directoryEntity.getUser().getId().equals(user.getId())) {
            throw new UnauthorizedAccessException("User does not have permission to change this directory name.");
        }

        directoryEntity.setDirectoryName(dirNameChangeRequest.getDirectoryName());
        directoryEntity.setUpdatedAt(LocalDateTime.now());
        directoryRepository.save(directoryEntity);


    }

    public void DirectoryDelete(DirIdRequest dirIdRequest, UserDetails userDetails) {
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user email"));


        DirectoryEntity directoryEntity = directoryRepository.findById(dirIdRequest.getDirectoryId())
                .orElseThrow(()->new IllegalArgumentException("Invalid directory id"));


        if (!directoryEntity.getUser().getId().equals(user.getId())) {
            throw new UnauthorizedAccessException("User does not have permission to change this directory name.");
        }

        directoryRepository.deleteById(dirIdRequest.getDirectoryId());


    }
}
