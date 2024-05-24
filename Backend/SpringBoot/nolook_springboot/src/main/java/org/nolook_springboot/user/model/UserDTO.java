package org.nolook_springboot.user.model;


import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.*;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.model.DirectoryDTO;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class UserDTO {

    private String userName;
    private String email;

    private List<DirectoryDTO> dirList = List.of();

}
