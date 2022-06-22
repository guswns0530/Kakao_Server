package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.JoinUserVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class JoinUserDAOTest {

    @Autowired
    private JoinUserDAO dao;

    @Test
    void insert() {
        JoinUserVO joinUserVO = new JoinUserVO();

        joinUserVO.setUserId("test1");
        joinUserVO.setRoomId("1");

        dao.insert(joinUserVO);
    }

    @Test
    void delete() {
        JoinUserVO joinUserVO = new JoinUserVO();

        joinUserVO.setJoinId("2");

        dao.delete(joinUserVO);
    }
}