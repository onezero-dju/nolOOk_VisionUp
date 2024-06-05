package org.nolook_springboot.memo.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.memo.model.MemoSaveRequest;
import org.nolook_springboot.memo.model.MemoViewDTO;
import org.nolook_springboot.memo.model.MemoViewRequest;
import org.nolook_springboot.memo.service.MemoService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/memo")
@RequiredArgsConstructor
@Slf4j
public class MemoApiController {


    private final MemoService memoService;


    @PostMapping("/save")
    public void SaveMemo (
            @RequestBody
            MemoSaveRequest memoSaveRequest,
            @AuthenticationPrincipal
            UserDetails userDetails

    ){

        memoService.save(memoSaveRequest,userDetails);




    }


    @PostMapping("/view")
    public MemoViewDTO ViewMemo (
            @RequestBody
            MemoViewRequest memoViewRequest,
            @AuthenticationPrincipal
            UserDetails userDetails


    ){


       return memoService.viewMemo(userDetails,memoViewRequest);

    }



}
