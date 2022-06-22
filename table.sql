drop table kakao_users;
drop table kakao_join_users;
drop table kakao_rooms;
drop table kakao_chats;
drop table kakao_friends;
drop table kakao_read_users;

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
    join_id INTEGER,
    user_id varchar2(255),
    room_id INTEGER,
    status INTEGER,
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_join_users_pk primary key(room_id, user_id, join_id)
);

-- type { 1: 문자메시지, 2: 참가메시지, 3: 탈퇴메시지, 4: 파일(이미지, 동영상 등)}
}
create table kakao_chats (
    chat_id INTEGER,
    join_id INTEGER,
    room_id INTEGER,
    status INTEGER,
    type INTEGER,
    content varchar2(300),
    createAt DATE,
    updateAt DATE,
    reserved1 VARCHAR2(300),
    reserved2 VARCHAR2(300),
    reserved3 VARCHAR2(300),
    constraint kakao_chats_pk primary key(join_id, chat_id)
);

-- 읽은 사람 메시지 
create table kakao_read_users (
    join_id INTEGER,
    chat_id INTEGER,
    reserved1 varchar2(300),
    reserved2 varchar2(300),
    reserved3 varchar2(300),
    constraint kakao_read_users_pk primary key(join_id)
);

-- sequence
create sequence kakao_friends_seq start with 1 increment by 1 nocycle nocache;
create sequence kakao_rooms_seq start with 1 increment by 1 nocycle nocache;
create sequence kakao_join_users_seq start with 1 increment by 1 nocycle nocache;
create sequence kakao_chats_seq start with 1 increment by 1 nocycle nocache;

-- sequence
drop sequence kakao_join_users_seq;
drop sequence kakao_rooms_seq;
drop sequence kakao_chats_seq;
drop sequence kakao_friends_seq;

-- unique index
CREATE UNIQUE INDEX kakao_friends_index ON kakao_friends (from_id, to_id);
CREATE UNIQUE INDEX kakao_join_users_index ON kakao_join_users (user_id, room_id);

-- trigger
CREATE trigger join_users_update_trigger
AFTER INSERT or UPDATE ON kakao_join_users
for each row
begin
    if inserting then
        insert into kakao_read_users(join_id, chat_id) values (:new.join_id, 
        nvl((select chat_id from (select chat_id from kakao_chats join kakao_rooms using(room_id) where room_id = 1 order by kakao_chats.createAT desc) where rownum = 1), 0));
    elsif updating then
        if :new.status = 1 then
            insert into kakao_read_users(join_id, chat_id) values (:new.join_id, 
        nvl((select chat_id from (select chat_id from kakao_chats join kakao_rooms using(room_id) where room_id = 1 order by kakao_chats.createAT desc) where rownum = 1), 0));
        elsif :new.status = 2 then
            delete kakao_read_users where join_id = :new.join_id;
        end if;
    end if;
end;

drop trigger join_users_update_trigger;

--데이터 주입
-- users
insert into kakao_users (user_id, name, status, createAt) values ('test1', 'test1', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test2', 'test2', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test3', 'test3', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test4', 'test4', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test5', 'test5', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test6', 'test6', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test7', 'test7', 1, sysdate);
insert into kakao_users (user_id, name, status, createAt) values ('test8', 'test8', 1, sysdate);

--friends
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test2', '테스트2', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test3', '테스트3', 1, sysdate);
insert into kakao_friends (friend_id, from_id, to_id, nickname, status, createAt) values(kakao_friends_seq.nextval, 'test1', 'test4', '테스트4', 1, sysdate);
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

-- join_users
insert into kakao_join_users ( join_id, user_id, room_id, status, createAt) values ( kakao_join_users_seq.nextval, 'test1', 1, 1, sysdate);
insert into kakao_join_users ( join_id, user_id, room_id, status, createAt) values ( kakao_join_users_seq.nextval, 'test2', 1, 1, sysdate);

insert into kakao_join_users ( join_id, user_id, room_id, status, createAt) values ( kakao_join_users_seq.nextval, 'test1', 2, 1, sysdate);
insert into kakao_join_users ( join_id, user_id, room_id, status, createAt) values ( kakao_join_users_seq.nextval, 'test3', 2, 1, sysdate);

-- chats
insert into kakao_chats (chat_id, join_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 2, 1, 1, '반갑습니다', SYSDATE);
insert into kakao_chats (chat_id, join_id, room_id, status, type, content, createAt) values (kakao_chats_seq.nextval, 2, 1, 1, '안녕하세요', SYSDATE);

commit;

-- select
with last_chat_id as 
(
    select * 
    from (select chat_id 
        from kakao_chats 
        join kakao_rooms using(room_id) 
        where room_id = 1 
        order by kakao_chats.createAT desc) 
    where rownum = 1
)

select *
from (select content
    from kakao_chats 
    join kakao_rooms using(room_id) 
    where room_id = 1 
    order by kakao_chats.createAT desc) 
where rownum = 1;

select 
B.ROOM_ID AS ROOM_ID,
B.NAME AS NAME,
B.TYPE AS TYPE
from kakao_join_users A
join kakao_rooms B
on A.room_id = B.room_id
where user_id = 'test1'
AND A.status = 1
AND B.status = 1;

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