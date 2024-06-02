package org.nolook_springboot.memo.db;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MemoRepository extends JpaRepository<MemoEntity,Long> {
}