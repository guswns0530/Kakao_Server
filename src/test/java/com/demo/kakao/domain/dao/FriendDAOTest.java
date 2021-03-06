package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.dao.FriendDAO;
import com.demo.kakao.domain.vo.FriendVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
class FriendDAOTest {
    @Autowired
    private FriendDAO friendDAO;

    @Test
    public void selectFromIdList() {
        Map<String, Object> map = new HashMap<>();

        String userId = "test1";
        map.put("userId", userId);

        List<Map<String, Object>> maps = friendDAO.selectFromIdList(map);
        System.out.println("maps = " + maps);
    }

    @Test
    public void selectToIdList() {
        Map<String, Object> map = new HashMap<>();

        String userId = "test3";
        map.put("userId", userId);


        List<Map<String, Object>> maps = friendDAO.selectToIdList(map);

        System.out.println("maps = " + maps);
    }
    @Test
    public void selectDeleteList() {
        Map<String, Object> map = new HashMap<>();

        String userId = "test1";
        map.put("userId", userId);

        List<Map<String, Object>> maps = friendDAO.selectDeleteList(map);

        System.out.println("maps = " + maps);
    }

    @Test
    public void selectRoom() {
        Map<String, Object> map = new HashMap<>();

        map.put("friendId", "2");

        Map<String, String> resultMap = friendDAO.selectRoom(map);

        System.out.println("resultMap = " + resultMap);
    }

    @Test
    public void insert() {
        FriendVO friendVO = new FriendVO();

        friendVO.setFromId("admin");
        friendVO.setToId("test2");
        friendVO.setNickname("테스트2");

        try {
            int result = friendDAO.insert(friendVO);
            System.out.println("result = " + result);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Test
    public void update() {
        FriendVO friendVO = new FriendVO();

        friendVO.setFriendId("1");
        friendVO.setNickname("테스트9999");

        int result = friendDAO.update(friendVO);

        System.out.println("result = " + result);
    }

    @Test
    public void delete() {
        FriendVO friendVO = new FriendVO();

        friendVO.setFriendId("1");

        int result = friendDAO.delete(friendVO);

        System.out.println("result = " + result);

    }
}