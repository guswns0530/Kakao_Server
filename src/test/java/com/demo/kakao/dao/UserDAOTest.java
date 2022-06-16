package com.demo.kakao.dao;

import com.demo.kakao.vo.UserVO;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;
import java.util.Map;

@SpringBootTest
public class UserDAOTest{
    @Autowired
    private UserDAO userDao;

    @DisplayName("모든 유저 선택")
    @Test
    public void selectList() {
        List<Map<String, Object>> maps = userDao.selectList();

        System.out.println("maps = " + maps);
    }

    @DisplayName("한 유저 검색")
    @Test
    public void select() {
        String userId= "admin";

        Map<String, Object> map = userDao.select(userId);

        System.out.println("map = " + map);
    }

    @DisplayName("유저 입력")
    @Test
    public void insert() {
        UserVO userVO = new UserVO();

        userVO.setUserId("test5");
        userVO.setName("testUser");
        userVO.setProvider("kakao");

        int result = userDao.insert(userVO);

        System.out.println("result = " + result);
    }

    @DisplayName("유저 수정")
    @Test
    public void update() {
        UserVO userVO = new UserVO();

        userVO.setUserId("admin");
        userVO.setName("박현준");

        int result = userDao.update(userVO);

        System.out.println("result = " + result);
    }

    @DisplayName("유저 삭제")
    @Test
    public void delete() {
        String userId = "admin";

        int result = userDao.delete(userId);

        System.out.println("result = " + result);
    }
}
