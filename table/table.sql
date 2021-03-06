drop table kakao_users;
drop table kakao_join_users;
drop table kakao_rooms;
drop table kakao_chats;
drop table kakao_friends;
drop table kakao_read_users;
drop table kakao_files;

-- status: 현재 상태 ( 삭제, 방장 등등 )
-- type: 타입( 파일, 이미지 / 1 대 1 채팅방, 단채 채팅방 )
-- createAt: 생성 시간
-- updateAt: 업데이트 시간

create table kakao_users (
    user_id VARCHAR2(255),
    provider VARCHAR2(20),
    name VARCHAR2(50),
    profile_image VARCHAR2(255),
    background_image VARCHAR2(255),
    status INTEGER,
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_users_pk primary key (user_id)
);

create table kakao_friends (
    friend_id INTEGER,
    from_id varchar2(255),
    to_id varchar2(255),
    nickname varchar2(50),
    status INTEGER,
    type INTEGER,
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_friends_pk primary key (to_id, from_id, friend_id)
);

-- type: 개인, 단체
create table kakao_rooms (
    room_id INTEGER,
    name varchar2(50),
    type INTEGER,
    status INTEGER,
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_rooms_pk primary key (room_id)
);

--status: 1: 방장, 2: 보통, 3: 삭제
create table kakao_join_users (
    user_id varchar2(255),
    room_id INTEGER,
    status INTEGER,
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_join_users_pk primary key(room_id, user_id)
);

-- type { 1: 문자메시지, 2: 참가메시지, 3: 탈퇴메시지, 4: 파일(이미지, 동영상 등)}
create table kakao_chats (
    chat_id INTEGER,
    user_id VARCHAR2(255),
    room_id INTEGER,
    status INTEGER,
    type INTEGER,
    content varchar2(300),
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_chats_pk primary key(room_id, user_id, chat_id)
);

-- 읽은 사람 메시지 
create table kakao_read_users (
    user_id varchar2(255),
    room_id INTEGER,
    chat_id INTEGER,
    createAt DATE,
    reserved1 varchar2(300),
    reserved2 varchar2(300),
    reserved3 varchar2(300),
    constraint kakao_read_users_pk primary key(room_id, user_id)
);

-- 파일 
create table kakao_files(
    file_id INTEGER,
    user_id VARCHAR2(266),
    original_name VARCHAR2(260),
    original_ext VARCHAR2(8),
    file_name VARCHAR2(260),
    createAt date,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_files_pk primary key (user_id, file_id)
);

-- sequence
create sequence kakao_friends_seq start with 1 increment by 1 nocycle nocache;
create sequence kakao_rooms_seq start with 1 increment by 1 nocycle nocache;
create sequence kakao_chats_seq start with 1 increment by 1 nocycle nocache;
create sequence kakao_files_seq start with 1 increment by 1 nocycle nocache;

-- sequence
drop sequence kakao_rooms_seq;
drop sequence kakao_chats_seq;
drop sequence kakao_friends_seq;
drop sequence kakao_files_seq;

-- unique index
CREATE UNIQUE INDEX kakao_friends_index ON kakao_friends (from_id, to_id);

-- chats(type: invite) -> trigger 작동 (join_users, read_users insert)
-- trigger
-- 유저가 입장, 퇴장 트리거



-- 데이터 주입
-- users
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test1', 'test1', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test2', 'test2', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test3', 'test3', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test4', 'test4', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test5', 'test5', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test6', 'test6', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test7', 'test7', '이미지', '이미지', 1, sysdate);
insert into kakao_users (user_id, name, profile_image, background_image, status, createAt) values ('test8', 'test8', '이미지', '이미지', 1, sysdate);

--friends
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test3', '테스트3', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test4', '테스트4', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test2', '테스트2', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test5', '테스트5', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test6', '테스트6', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test7', '테스트7', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test8', '테스트8', 1, sysdate);

insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test1', '테스트2', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test3', '테스트3', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test4', '테스트4', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test5', '테스트5', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test6', '테스트6', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test7', '테스트7', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test2', 'test8', '테스트8', 1, sysdate);

-- rooms
insert into kakao_rooms (room_id, name, type, status, createAt) values (kakao_rooms_seq.nextval, '', 1, '1', sysdate);
insert into kakao_rooms (room_id, name, type, status, createAt) values (kakao_rooms_seq.nextval, '', 1, '1', sysdate);
insert into kakao_rooms (room_id, name, type, status, createAt) values (kakao_rooms_seq.nextval, '', 2, '1', sysdate);

-- join_users
insert into kakao_join_users (user_id, room_id, status, createAt) values ('test1', 1, 1, sysdate);
insert into kakao_join_users (user_id, room_id, status, createAt) values ('test2', 1, 1, sysdate);

insert into kakao_read_users (user_id, room_id, chat_id, createat) values('test1', 1, 0, sysdate);
insert into kakao_read_users (user_id, room_id, chat_id, createat) values('test2', 1, 0, sysdate);

insert into kakao_join_users (user_id, room_id, status, createAt) values ('test1', 2, 1, sysdate);
insert into kakao_join_users (user_id, room_id, status, createAt) values ('test3', 2, 1, sysdate);

insert into kakao_read_users (user_id, room_id, chat_id, createat) values('test1', 2, 0, sysdate);
insert into kakao_read_users (user_id, room_id, chat_id, createat) values('test3', 2, 0, sysdate);

insert into kakao_join_users (user_id, room_id, status, createAt) values ('test1', 3, 1, sysdate);
insert into kakao_join_users (user_id, room_id, status, createAt) values ('test2', 3, 1, sysdate);
insert into kakao_join_users (user_id, room_id, status, createAt) values ('test3', 3, 1, sysdate);

insert into kakao_read_users  (user_id, room_id, chat_id, createat) values('test1', 3, 0, sysdate);
insert into kakao_read_users  (user_id, room_id, chat_id, createat) values('test2', 3, 0, sysdate);
insert into kakao_read_users  (user_id, room_id, chat_id, createat) values('test3', 3, 0, sysdate);

-- chats
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test1', 1, 1, 1, '안녕하세요', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test2', 1, 1, 1, '반갑습니다', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test1', 1, 1, 1, 'testMsg1', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test2', 1, 1, 1, 'testMsg2', SYSDATE);

insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test1', 2, 1, 1, '안녕하세요', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test3', 2, 1, 1, '반갑습니다', SYSDATE);

insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test1', 3, 1, 1, '안녕하세요', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test2', 3, 1, 1, '반갑습니다', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test3', 3, 1, 1, 'testMsg1', SYSDATE);
insert into kakao_chats (chat_id, user_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 'test1', 3, 1, 1, 'testMsg2', SYSDATE);

commit;

-- 유저 이미지 불러오기 (수정 권장)
select *
from (select 
A.USER_ID as user_id,
A.NAME as name,
A.PROFILE_IMAGE as profile_image
from kakao_rooms
join kakao_join_users
on kakao_rooms.room_id = kakao_join_users.room_id
join kakao_users A
on A.user_id = kakao_join_users.user_id)
where rownum <= 4;

-- find friend room
select A.room_id as room_id
from kakao_join_users A
join kakao_join_users B
on A.room_id = B.room_id and A.user_id <> B.user_id
join kakao_rooms R
on R.room_id = B.room_id
where R.type = 1
and (A.user_id, B.user_id) in (select from_id, to_id
from kakao_friends
where friend_id = '1');

WITH CUTOFF_RS AS (select FR.*,
    case when (select count(*)
    from kakao_friends
    where STATUS = 2
        and ((from_id =FR.to_id and to_id = FR.from_id)
        or
        (from_id =FR.from_id and to_id = FR.to_id))
    ) <= 0 then '1'
    else '2' END AS CUTOFF_RS
    from kakao_friends FR
    where
        from_id = 'test1')
        
select *
from (select 
        A.USER_ID as user_id,
        A.NAME as name,
        DECODE(B.CUTOFF_RS,'1' , A.PROFILE_IMAGE , null) AS PROFILE_IMAGE
    from kakao_rooms
    join kakao_join_users
        on kakao_rooms.room_id = kakao_join_users.room_id
    join CUTOFF_RS B
        on kakao_join_users.user_id = B.to_id
    join kakao_users A
        on A.user_id = kakao_join_users.user_id
    where kakao_rooms.room_id = 1)
where rownum <= 4;

WITH CUTOFF_RS AS (select FR.*,
case when (select count(*)
from kakao_friends
where STATUS = 2
    AND ((from_id =FR.to_id and to_id = FR.from_id)
    or
    (from_id =FR.from_id and to_id = FR.to_id))
  ) <= 0 then '1'
else '2' END AS CUTOFF_RS
from kakao_friends FR
where
    from_id = 'test1')
select *
from (select
A.USER_ID,
A.NAME,
DECODE(B.CUTOFF_RS,'1' , A.PROVIDER , null) AS PROVIDER,
DECODE(B.CUTOFF_RS,'1' , A.PROFILE_IMAGE , null) AS PROFILE_IMAGE,
DECODE(B.CUTOFF_RS,'1' , A.BACKGROUND_IMAGE , null) AS BACKGROUND_IMAGE,
DECODE(B.CUTOFF_RS,'1' , A.CREATEAT , null) AS CREATEAT,
DECODE(B.CUTOFF_RS,'1' , A.UPDATEAT , null) AS UPDATEAT
from kakao_rooms
join kakao_join_users
on kakao_rooms.room_id = kakao_join_users.room_id
join CUTOFF_RS B
on kakao_join_users.user_id = B.to_id
join kakao_users A
on A.user_id = kakao_join_users.user_id
where kakao_rooms.room_id = '1')
where rownum <= 4;

select seq, content, user_id, rownum
from (select rownum as seq, content, user_id, rownum, type
from (select 
    content,
    user_id,
    type
from kakao_chats
join kakao_join_users
using(join_id)
where kakao_chats.room_id = 1
order by kakao_chats.createAt desc))
where user_id = 'test1'
and type = 2;

select * 
from (select chat_id, user_id, type, rank() over(order by kakao_chats.createAt desc) as seq
from kakao_chats
join kakao_join_users
using(join_id)
where kakao_chats.room_id = 1
order by kakao_chats.createAt desc)
where user_id = 'test1'
and type = 2;



    
    
    
    
    
    
