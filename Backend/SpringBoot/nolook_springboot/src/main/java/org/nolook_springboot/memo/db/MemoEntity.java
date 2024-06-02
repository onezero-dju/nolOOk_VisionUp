package org.nolook_springboot.memo.db;

import jakarta.persistence.*;
import lombok.*;
import org.nolook_springboot.directory.db.DirectoryEntity;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity(name = "Memo")
@ToString
public class MemoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "directory_id")
    private DirectoryEntity directory;

    private String memoName;

    private String content;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;





}
