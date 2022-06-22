package com.demo.kakao.domain.vo;

import lombok.Data;

@Data
public class FriendVO {
    private String friendId;
    private String fromId;
    private String toId;
    private String nickname;

    // 조회용
}
