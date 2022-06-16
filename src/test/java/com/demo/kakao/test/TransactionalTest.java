package com.demo.kakao.test;

import com.demo.kakao.dao.UserDAO;
import com.demo.kakao.vo.UserVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
public class TransactionalTest {

    @Autowired
    private UserDAO userDAO;

    @Test
    @Transactional
    public void test1() {
        UserVO userVO = new UserVO();
        userVO.setUserId("admin1");
        userVO.setName("admin1");
        userVO.setProvider("kakao");

        try {
            userDAO.insert(userVO);
            userDAO.insert(userVO);
        } catch (Exception e) {
            Throwable cause = e.getCause();

            System.out.println("cause.getMessage() = " + cause.getMessage());
        }
    }
}
