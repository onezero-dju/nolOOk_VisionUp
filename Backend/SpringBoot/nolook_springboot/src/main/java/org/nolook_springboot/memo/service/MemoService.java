package org.nolook_springboot.memo.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.db.DirectoryRepository;
import org.nolook_springboot.memo.db.MemoEntity;
import org.nolook_springboot.memo.db.MemoRepository;
import org.nolook_springboot.memo.model.MemoSaveRequest;
import org.nolook_springboot.memo.model.MemoViewDTO;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemoService {

    private final MemoRepository memoRepository;
    private final DirectoryRepository directoryRepository;

    public void save(MemoSaveRequest memoSaveRequest) {

        DirectoryEntity directoryEntity = directoryRepository.findById(memoSaveRequest.getDirectoryId())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user ID"));


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



    public MemoViewDTO view(){

        return MemoViewDTO.builder().build();
    }

}
