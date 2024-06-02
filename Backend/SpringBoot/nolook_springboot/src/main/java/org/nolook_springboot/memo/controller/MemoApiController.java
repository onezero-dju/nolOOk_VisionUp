package org.nolook_springboot.memo.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.memo.model.MemoSaveRequest;
import org.nolook_springboot.memo.service.MemoService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/memo")
@RequiredArgsConstructor
@Slf4j
public class MemoApiController {

    private final MemoService memoService;

    @PostMapping("/save")
    public void saveMemo (
            @RequestBody
            MemoSaveRequest memoSaveRequest
    ){

        memoService.save(memoSaveRequest);


    }


    @PostMapping("/view/")
    public void viewMemo (

    ){


    }



}
