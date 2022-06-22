package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.RoomVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RoomDAOTest {

    @Autowired
    private RoomDAO roomDAO;
    @Test
    void insert() {
        RoomVO vo = new RoomVO();
        vo.setName("");
        vo.setType("1");

        roomDAO.insert(vo);
    }

    @Test
    void delete() {
        Map<String, String> map = new HashMap<>();

        map.put("roomId", "1");

        roomDAO.delete(map);
    }
}