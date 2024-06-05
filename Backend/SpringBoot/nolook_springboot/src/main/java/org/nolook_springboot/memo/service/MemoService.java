package org.nolook_springboot.memo.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.db.DirectoryRepository;
import org.nolook_springboot.memo.db.MemoEntity;
import org.nolook_springboot.memo.db.MemoRepository;
import org.nolook_springboot.memo.model.MemoSaveRequest;
import org.nolook_springboot.memo.model.MemoViewDTO;
import org.nolook_springboot.memo.model.MemoViewRequest;
import org.nolook_springboot.user.db.UserEntity;
import org.nolook_springboot.user.db.UserRepository;
import org.nolook_springboot.util.exception.UnauthorizedAccessException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemoService {

    private final MemoRepository memoRepository;
    private final DirectoryRepository directoryRepository;
    private final UserRepository userRepository;

    public void save(
            MemoSaveRequest memoSaveRequest,
            @AuthenticationPrincipal
            UserDetails userDetails
    ) {


        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid Token"));

        DirectoryEntity directoryEntity = directoryRepository.findById (memoSaveRequest.getDirectoryId())
                .orElseThrow(() -> new IllegalArgumentException("Invalid directory ID"));


        var entity = MemoEntity
                .builder()
                .memoName(memoSaveRequest.memoName)
                .directory(directoryEntity)
                .content(memoSaveRequest.getContent())
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();

        memoRepository.save(entity);
    }



    public MemoViewDTO viewMemo(UserDetails userDetails, MemoViewRequest memoViewRequest) {
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Invalid Token"));

        MemoEntity memoEntity = memoRepository.findById(memoViewRequest.getMemoId())
                .orElseThrow(() -> new IllegalArgumentException("Invalid memo id"));

        DirectoryEntity directoryEntity = memoEntity.getDirectory();

        UserEntity userEntity = directoryEntity.getUser();

        if (!userEntity.getId().equals(user.getId())) {
            throw new UnauthorizedAccessException("User does not have permission to view this memo.");
        }

        return MemoViewDTO.builder()
                .memoName(memoEntity.getMemoName())
                .content(memoEntity.getContent())
                .createdAt(memoEntity.getCreatedAt())
                .updatedAt(memoEntity.getUpdatedAt())
                .directoryId(memoEntity.getId())
                .build();
    }


}
