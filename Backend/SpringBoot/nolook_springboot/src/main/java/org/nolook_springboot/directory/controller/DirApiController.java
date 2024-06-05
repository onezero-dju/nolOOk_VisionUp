package org.nolook_springboot.directory.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.db.DirectoryRepository;
import org.nolook_springboot.directory.model.*;
import org.nolook_springboot.directory.service.DirService;
import org.nolook_springboot.memo.model.MemoViewDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/directory")
@RequiredArgsConstructor
@Slf4j
public class DirApiController {

    @Autowired
    DirService dirService;

    @PostMapping("/save")
    public void DirSave(
            @RequestBody
            DirRequest dirRequest,

            @AuthenticationPrincipal
            UserDetails userDetails

    ){
        dirService.DirSave(dirRequest,userDetails);
    }


    @GetMapping("/list")
    public List<DirectoryDTO> getDirectories(
            @AuthenticationPrincipal UserDetails userDetails
    ){
        return dirService.getDirectories(userDetails);
    }

    @PostMapping("/view")
    public List<DirMemoViewDTO> DirView(

            @RequestBody
            DirViewRequest dirViewRequest,

            @AuthenticationPrincipal UserDetails userDetails
    ){
        log.info("여기");
        return dirService.getMemoList(dirViewRequest,userDetails);
    }

    @PostMapping("/nameChange")
    public void DirNameChange(

            @RequestBody
            DirNameChangeRequest dirNameChangeRequest,

            @AuthenticationPrincipal UserDetails userDetails
    ){

        dirService.dirNameChange(dirNameChangeRequest, userDetails);

    }



}
