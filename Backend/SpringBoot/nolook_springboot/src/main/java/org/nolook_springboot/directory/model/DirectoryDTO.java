package org.nolook_springboot.directory.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DirectoryDTO {
    private Long id;
    private String directoryName;
}
