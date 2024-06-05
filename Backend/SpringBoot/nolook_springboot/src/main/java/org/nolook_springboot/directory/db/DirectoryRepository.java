package org.nolook_springboot.directory.db;

import org.nolook_springboot.user.db.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface DirectoryRepository extends JpaRepository<DirectoryEntity,Long> {
    List<DirectoryEntity> findAllByUser(UserEntity user);


}
