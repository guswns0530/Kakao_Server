package com.demo.kakao.domain.dao;

import com.demo.kakao.domain.vo.RoomVO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@RequiredArgsConstructor
@Repository
public class RoomDAO {

    private final SqlSessionTemplate sqlSession;

    public int insert(RoomVO vo) {
        return sqlSession.insert("room.insert", vo);
    }

    public int delete(RoomVO vo) {
        return sqlSession.delete("room.delete", vo);
    }
}
