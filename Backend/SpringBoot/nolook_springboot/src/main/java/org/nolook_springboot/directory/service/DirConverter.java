package org.nolook_springboot.directory.service;

import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.model.DirectoryDTO;
import org.springframework.stereotype.Service;

@Service
public class DirConverter {

    public DirectoryDTO directoryDTO(DirectoryEntity directoryEntity){

        return DirectoryDTO.builder().build();

    }

}
