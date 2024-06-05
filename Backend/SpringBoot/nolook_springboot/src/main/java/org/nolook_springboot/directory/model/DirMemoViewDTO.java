package org.nolook_springboot.directory.model;


//이 파일은 디렉터리 하나를 눌러서 그 안의 메모들을 리스트로 볼 수 있도록 한 것임.


import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DirMemoViewDTO {

    private Long memoId;
    private String memoName;
    private LocalDateTime updatedAt;

}
