-- 유저 채팅 -- 
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
DECODE(B.CUTOFF_RS,'1' , A.CREATEAT , null) AS CREATEAT,
DECODE(B.CUTOFF_RS,'1' , A.UPDATEAT , null) AS UPDATEAT,
C.chat_id AS CHAT_ID,
C.content AS CONTENT,
C.type AS TYPE,
C.seq AS SEQ,
C.CREATEAT AS CHAT_CREATEAT
from
    (select *
    from
        (select chat_id, content, user_id, type, dense_rank() over(order by kakao_chats.createAt desc) as seq, kakao_chats.createAT --방안에 있는 모든 채팅 
            from kakao_chats
            join kakao_join_users
            using(join_id)
    where kakao_chats.room_id = 1
    order by kakao_chats.createAt desc)
    where seq <= 
    (select min(seq) seq -- 내가 들어온 시점
    from
        (select chat_id, user_id, type, dense_rank() over(order by kakao_chats.createAt desc) as seq -- ''
            from kakao_chats
            join kakao_join_users
            using(join_id)
        where kakao_chats.room_id = 1
        order by kakao_chats.createAt desc)
    where user_id = 'test1'
    AND type = 2)) C
    join kakao_users A
    on A.user_id = C.user_id
    left outer join CUTOFF_RS B
    on B.to_id = A.user_id
where seq between 1 and 20;


-- 유저 채팅 불러오기 Parameter( user_id, room_id )
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
DECODE(B.CUTOFF_RS,'1' , A.CREATEAT , null) AS CREATEAT,
DECODE(B.CUTOFF_RS,'1' , A.UPDATEAT , null) AS UPDATEAT,
C.chat_id AS CHAT_ID,
DECODE(C.status, '1', C.content, null) AS CONTENT,
C.type AS TYPE,
C.seq AS SEQ,
C.CREATEAT AS CHAT_CREATEAT
from
    (select chat_id, content, user_id, kakao_chats.status status, type, dense_rank() over(order by kakao_chats.createAt desc) as seq, kakao_chats.createAT --방안에 있는 모든 채팅 
        from kakao_chats
        join kakao_join_users
        using(join_id)
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
    
-- 읽은 유저 Parameter ( room_id ) --
select RU.chat_id
from kakao_join_users JR
join kakao_read_users RU
on JR.join_id = RU.join_id
where JR.room_id = 1
order by chat_id desc;

-- 채팅 삭제 Parameter ( chat_id )-- 
update kakao_chats
set status = 2
where chat_id = 38;

-- getRoom start


-- getRoom end

--LISTAGG(name, ', ') within group (order by name) as name,
--nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null ), U.name) as name,