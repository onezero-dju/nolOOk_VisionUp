package org.nolook_springboot.directory.db;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface DirectoryRepository extends JpaRepository<DirectoryEntity,Long> {
}
