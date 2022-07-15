-- 유저 채팅 불러오기 Parameter( user_id, room_id )
-- 후에 파일 불러오기
-- 최종
WITH CUTOFF_RS AS -- whit_start
(select FR.*, 
    case when 
        (select count(*)
        from kakao_friends
        where STATUS = 2
        AND ((from_id =FR.to_id and to_id = FR.from_id) or (from_id =FR.from_id and to_id = FR.to_id)))
    <= 0 then '1'
    else '2' END AS CUTOFF_RS
from kakao_friends FR
where from_id = 'test1') -- whit_end
select 
A.USER_ID,
A.NAME,
DECODE(B.CUTOFF_RS,'1' , A.PROVIDER , null) AS PROVIDER,
DECODE(B.CUTOFF_RS,'1' , B.NICKNAME , null) AS NICKNAME,
DECODE(B.CUTOFF_RS,'1' , A.PROFILE_IMAGE , null) AS PROFILE_IMAGE,
DECODE(B.CUTOFF_RS,'1' , A.BACKGROUND_IMAGE , null) AS BACKGROUND_IMAGE,
C.chat_id AS CHAT_ID,
DECODE(C.status, '1', C.content, null) AS CONTENT,
C.type AS TYPE,
C.seq AS SEQ,
C.CREATEAT AS CHAT_CREATEAT
from
    (select chat_id, content, kakao_chats.user_id, kakao_chats.status status, type, dense_rank() over(order by kakao_chats.createAt desc) as seq, kakao_chats.createAT --방안에 있는 모든 채팅 
        from kakao_chats
        join kakao_join_users
        on kakao_chats.user_id = kakao_join_users.user_id and kakao_chats.room_id = kakao_join_users.room_id
    where kakao_chats.room_id = 1
    and kakao_chats.createAt >= 
        (select createAt
            from kakao_join_users
        where room_id = 1
        and user_id = 'test1')
    order by kakao_chats.createAt desc) C
    join kakao_users A
    on c.user_id = A.user_id
    left outer join CUTOFF_RS B
    on B.to_id = A.user_id
where seq between 1 and 20;

-- 채팅 삭제
update kakao_chats set status = 2 where  chat_id = ?;

-- 채팅 입력
insert into kakao_chats (chat_id, join_id, room_id, content, status, type, createAt) values (KAKAO_CHATS_SEQ.nextval, 조인 아이디, 룸 아이디, 컨텐트, 1, 타입, sysdate);

-- 읽은 살마 조회