package org.nolook_springboot.memo.db;

import org.nolook_springboot.directory.db.DirectoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemoRepository extends JpaRepository<MemoEntity,Long> {
    List<MemoEntity> findAllByDirectory(DirectoryEntity directoryEntity);


}