package com.demo.kakao.domain.vo;

import lombok.Data;

@Data
public class UserVO {
    private String userId;
    private String provider;
    private String name;
    private String profileImage;
    private String backgroundImage;
}
