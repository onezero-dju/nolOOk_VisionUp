package org.nolook_springboot.memo.model;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemoViewDTO {

    private String content;

    private String memoName;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;


}
