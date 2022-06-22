package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.JoinUserVO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class JoinUserDAO {

    private final SqlSessionTemplate sqlSession;

    public int insert(JoinUserVO vo) {
        return sqlSession.insert("join_user.insert", vo);
    }

    public int delete(JoinUserVO vo) {
        return sqlSession.update("join_user.delete", vo);
    }
}
