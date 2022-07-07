
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

select (
    select LISTAGG(name, ', ') within group (order by name) as name
    from
        (
        select nvl(DECODE(CUTOFF_RS.CUTOFF_RS, 1, nickname, null ), name) as name
        from kakao_join_users
        join kakao_users
        on kakao_join_users.user_id = kakao_users.user_id
        left outer join CUTOFF_RS
        on kakao_users.user_id = CUTOFF_RS.to_id
        where room_id = R.room_id
        and kakao_users.user_id != JU.user_id
        )
) as name,
R.room_id
from kakao_join_users JU
join kakao_rooms R
on JU.room_id = R.room_id
where JU.user_id = 'test1';



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

 select nvl(DECODE(CUTOFF_RS.CUTOFF_RS, 1, nickname, null ), name) as name
        from kakao_join_users
        join kakao_users
        on kakao_join_users.user_id = kakao_users.user_id
        left outer join CUTOFF_RS
        on kakao_users.user_id = CUTOFF_RS.to_id
        where room_id = R.room_id
        and kakao_users.user_id != ;
        
        
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


select A.ROOM_ID,
    NVL(A.NAME, LISTAGG(nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null ), D.NAME), ', ') within group (order by C.nickname, D.NAME)) AS NAME,
    COUNT(*) + 1 AS CNT,
    E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
    from kakao_rooms A
    LEFT OUTER JOIN (
    SELECT E.ROOM_ID,
        MAX(E.CONTENT) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_CONTENT,
        MAX(E.TYPE) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_TYPE, 
        MAX(E.STATUS) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_STATUS, 
        MAX(E.CREATEAT) KEEP(DENSE_RANK LAST ORDER BY E.CREATEAT) CHAT_CREATEAT
    FROM KAKAO_CHATS E
    GROUP BY E.ROOM_ID) E
    ON A.ROOM_ID = E.ROOM_ID
    JOIN kakao_join_users B
    ON A.ROOM_ID = B.ROOM_ID
    LEFT OUTER JOIN CUTOFF_RS C
    ON B.USER_ID = C.TO_ID
    LEFT OUTER JOIN kakao_users D
    ON B.USER_ID = D.USER_ID
    
where B.USER_ID != 'test1'
GROUP BY A.ROOM_ID, A.NAME, E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT ;

SELECT *
FROM
(
SELECT DECODE(STATUS, 1, CONTENT, NULL) CONTENT, CHAT_ID, TYPE, STATUS
FROM KAKAO_CHATS
WHERE ROOM_ID = 1
ORDER BY CREATEAT DESC
)
WHERE ROWNUM <= 1;

          
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
select *
    from kakao_rooms A
    JOIN kakao_join_users B
    ON A.ROOM_ID = B.ROOM_ID
    LEFT OUTER JOIN CUTOFF_RS C
    ON B.USER_ID = C.TO_ID
    LEFT OUTER JOIN kakao_users D
    ON B.USER_ID = D.USER_ID
    LEFT OUTER JOIN KAKAO_CHATS E
    ON A.ROOM_ID = E.ROOM_ID
where B.USER_ID != 'test1';


select count(*)
from kakao_chats
where chat_id > 
(select B.chat_id
from kakao_join_users A
join kakao_read_users B
using(join_id)
where A.user_id = 'test1'
and A.room_id = 1)
and type in (1, 2);
                    
