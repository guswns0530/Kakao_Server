package com.demo.kakao.vo;

import lombok.Data;

@Data
public class FriendVO {
    private String friendId;
    private String fromId;
    private String toId;
    private String nickname;
    private String status;
    
    // 조회용
    private String userId;
}
