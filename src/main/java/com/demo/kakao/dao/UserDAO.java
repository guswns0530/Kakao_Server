package com.demo.kakao.dao;

import com.demo.kakao.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.annotations.ConstructorArgs;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class UserDAO {

    private final SqlSessionTemplate sqlSession;

    public List<Map<String, Object>> selectList() {
        return sqlSession.selectList("user.selectList");
    }

    public Map<String, Object> select(String userId) {
        return sqlSession.selectOne("user.select", userId);
    }

    public int insert(UserVO vo) {
        return sqlSession.insert("user.insert", vo);
    }

    public int update(UserVO vo) {
        return sqlSession.update("user.update", vo);
    }

    public int delete(String userId) {
        return sqlSession.delete("user.delete", userId);
    }
}
