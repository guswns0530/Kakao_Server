package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.FriendVO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Repository
public class FriendDAO {
    private final SqlSessionTemplate sqlSession;

    public List<Map<String, Object>> selectFromIdList(Map<String, Object> map) {
        return sqlSession.selectList("friend.selectFromIdList", map);
    }

    public List<Map<String, Object>> selectToIdList(Map<String, Object> map) {
        return sqlSession.selectList("friend.selectToIdList", map);
    }

    public List<Map<String, Object>> selectDeleteList(Map<String, Object> map) {
        return sqlSession.selectList("friend.selectDeleteList", map);
    }

    public int insert(FriendVO vo) {
        return sqlSession.insert("friend.insert", vo);
    }

    public int update(FriendVO vo) {
        return sqlSession.update("friend.update", vo);
    }

    public int delete(FriendVO vo) {
        return sqlSession.update("friend.delete", vo);
    }
}
