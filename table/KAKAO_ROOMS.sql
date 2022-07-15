-- 모든 룸 가져오기
WITH CUTOFF_RS AS (select FR.*,
case when (select count(*)
from kakao_friends
where STATUS = 2
AND from_id = FR.from_id
AND to_id = FR.to_id
) <= 0 then '1'
else '2' END AS CUTOFF_RS
from kakao_friends FR
where from_id = 'test1')
select 
    A.ROOM_ID,
    NVL(A.NAME, 
        LISTAGG(nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null ), D.NAME), ', ') 
        within group (order by C.nickname, D.NAME)) AS NAME,
    NVL(A.NAME, 
        LISTAGG(D.user_id, ', ') 
        within group (order by C.nickname, D.NAME)) AS USERID,
    COUNT(B.USER_ID) + 1 AS CNT,
    DECODE(E.CHAT_STATUS, 1, E.CHAT_CONTENT, null) AS CHAT_CONTENT,
    LISTAGG(NVL(D.user_id,'null'), ', ') 
        within group (order by C.nickname, D.NAME) AS Profile,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT,
    SUM((select COUNT(*) FROM kakao_chats G WHERE A.ROOM_ID = G.ROOM_ID AND F.createAt < G.createAt)) AS CNT2
from 
    kakao_rooms A
    JOIN (
    SELECT E.ROOM_ID,
        MAX(E.CONTENT) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_CONTENT,
        MAX(E.TYPE) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_TYPE, 
        MAX(E.STATUS) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_STATUS, 
        MAX(E.CREATEAT) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_CREATEAT
    FROM KAKAO_CHATS  E
    GROUP BY E.ROOM_ID) E
    ON A.ROOM_ID = E.ROOM_ID
    JOIN kakao_join_users B
    ON A.ROOM_ID = B.ROOM_ID
    LEFT OUTER JOIN CUTOFF_RS C
    ON B.USER_ID = C.TO_ID
    LEFT OUTER JOIN kakao_users D
    ON B.USER_ID = D.USER_ID
    JOIN kakao_read_users F
    ON A.ROOM_ID = F.ROOM_ID
    AND B.USER_ID = F.USER_ID
where B.USER_ID != 'test1'
GROUP BY 
    A.ROOM_ID, 
    A.NAME,
    E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
ORDER BY CHAT_CREATEAT asc;


select count(*) cnt
from kakao_chats A
where A.createAt >= (
    select createAt
    from kakao_read_users
    where room_id = A.room_id
    and user_id = 'test1'
)
and room_id = 1;

select * from kakao_read_users;
select * from kakao_chats;
select * from kakao_rooms;


select A.ROOM_ID,COUNT(B.chat_id)
from kakao_rooms A
JOIN kakao_read_users C
ON A.ROOM_ID = C.ROOM_ID
LEFT OUTER JOIN kakao_chats B
ON A.ROOM_ID = B.ROOM_ID
AND A.createAt < B.createAt
WHERE C.USER_ID = 'test1'
GROUP BY A.ROOM_ID
;
