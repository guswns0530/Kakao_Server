package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.RoomVO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Repository
public class RoomDAO {

    private final SqlSessionTemplate sqlSession;

    public List<HashMap<String, String>> selectRoomList(Map<String, String> map) {
        return sqlSession.selectList("room.selectRoomList", map);
    }

    public List<HashMap<String, String>> selectProfileInRoomList(Map<String, String> map) {
        return sqlSession.selectList("room.selectProfileInRoomList", map);
    }

    public int insert(RoomVO vo) {
        return sqlSession.insert("room.insert", vo);
    }

    public int delete(Map<String, String> map) {
        return sqlSession.delete("room.delete", map);
    }
}
