package com.demo.kakao.dao;

import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@RequiredArgsConstructor
@Repository
public class RoomDAO {

    private final SqlSessionTemplate sqlSession;
}
