package org.nolook_springboot.memo.model;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemoViewDTO {

    @NonNull
    public Long directoryId;
    @NonNull
    public String memoName;
    @NonNull
    public String content;

    @NonNull
    public LocalDateTime createdAt;
    @NonNull
    public LocalDateTime updatedAt;



}
