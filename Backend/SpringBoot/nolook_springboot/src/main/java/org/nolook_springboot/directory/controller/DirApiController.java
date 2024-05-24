package org.nolook_springboot.directory.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.nolook_springboot.directory.db.DirectoryEntity;
import org.nolook_springboot.directory.db.DirectoryRepository;
import org.nolook_springboot.directory.model.DirRequest;
import org.nolook_springboot.directory.service.DirService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
            DirRequest dirRequest
    ){
        dirService.DirSave(dirRequest);
    }

    @PostMapping("/view")
    public void DirView(
            @RequestBody
            DirRequest dirRequest
    ){
        dirService.DirSave(dirRequest);
    }



}
