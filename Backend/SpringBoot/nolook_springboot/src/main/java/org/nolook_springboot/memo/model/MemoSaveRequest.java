package org.nolook_springboot.memo.model;


import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class MemoSaveRequest {

    @NonNull
    public Long directoryId;
    @NonNull
    public String memoName;
    @NonNull
    public String content;


}
