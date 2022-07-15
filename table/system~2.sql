-- start --        
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

-- 안 읽은 채팅수 구하기
select 
    A.ROOM_ID,
    NVL(A.NAME, 
        LISTAGG(nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null ), D.NAME), ', ') 
        within group (order by C.nickname, D.NAME)) AS NAME,
    NVL(A.NAME, 
        LISTAGG(D.user_id, ', ') 
        within group (order by C.nickname, D.NAME)) AS USERID,
    COUNT(*) + 1 AS CNT,
    DECODE(E.CHAT_STATUS, 1, E.CHAT_CONTENT, null) AS CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
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
where B.USER_ID != 'test1'
GROUP BY 
    A.ROOM_ID, 
    A.NAME,
    E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
ORDER BY CHAT_CREATEAT asc;

-- end --
SELECT * FROM KAKAO_JOIN_USERS;
SELECT * FROM KAKAO_READ_USERS;
SELECT * FROM KAKAO_CHATS;
SELECT * FROM KAKAO_ROOMS;

SELECT ROOM_ID,COUNT(A.*)
FROM KAKAO_CHATS A
JOIN KAKAO_READ_USERS B
ON A.JOIN_ID = B.JOIN_ID
AND B.USER_ID = 'test1'
AND A.CREATEAT < B.CREATEAT
GROUP BY ROOM_ID;

select A.* , D. *
from KAKAO_ROOMS A
JOIN KAKAO_JOIN_USERS B
ON A.ROOM_ID = B.ROOM_ID
JOIN KAKAO_READ_USERS C
ON B.JOIN_ID = C.JOIN_ID
LEFT OUTER JOIN KAKAO_CHATS D
ON b.join_id = d.join_id;

