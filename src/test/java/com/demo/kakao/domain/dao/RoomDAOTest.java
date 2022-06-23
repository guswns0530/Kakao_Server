package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.RoomVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RoomDAOTest {

    @Autowired
    private RoomDAO roomDAO;

    @Test
    void selectRoomList() {
        HashMap<String, String> map = new HashMap<>();

        map.put("userId", "test1");

        List<HashMap<String, String>> resultMap = roomDAO.selectRoomList(map);

        System.out.println("resultMap = " + resultMap);
    }

    @Test
    void selectProfileInRoomList() {
        HashMap<String, String> map = new HashMap<>();

        map.put("userId", "test1");
        map.put("roomId", "3");

        List<HashMap<String, String>> resultMap = roomDAO.selectProfileInRoomList(map);

        System.out.println("resultMap = " + resultMap);
    }
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