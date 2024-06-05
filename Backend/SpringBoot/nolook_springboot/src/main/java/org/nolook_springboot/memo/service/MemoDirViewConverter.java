package org.nolook_springboot.memo.service;

import org.nolook_springboot.directory.model.DirMemoViewDTO;
import org.nolook_springboot.memo.db.MemoEntity;
import org.nolook_springboot.memo.model.MemoViewDTO;
import org.springframework.stereotype.Service;

@Service
public class MemoDirViewConverter {

    public DirMemoViewDTO memoDirectoryViewConverter(MemoEntity memoEntity){

        return DirMemoViewDTO
                .builder()
                .memoId(memoEntity.getId())
                .memoName(memoEntity.getMemoName())
                .updatedAt(memoEntity.getUpdatedAt())
                .build();

    }

}
