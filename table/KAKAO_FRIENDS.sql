WITH CUTOFF_RS AS (select FR.*,
case when (select count(*)
from kakao_friends
where STATUS = 2
        AND from_id =FR.to_id
        AND to_id = FR.from_id
      ) <= 0 then '1'
else '2' END AS CUTOFF_RS
from kakao_friends FR
where from_id = 'test1')
select
A.USER_ID,
A.NAME,
DECODE(B.CUTOFF_RS,'1' , A.PROVIDER , null) AS PROVIDER,
DECODE(B.CUTOFF_RS,'1' , A.PROFILE_IMAGE , null) AS PROFILE_IMAGE,
DECODE(B.CUTOFF_RS,'1' , A.BACKGROUND_IMAGE , null) AS BACKGROUND_IMAGE,
DECODE(B.CUTOFF_RS,'1' , A.CREATEAT , null) AS CREATEAT,
DECODE(B.CUTOFF_RS,'1' , A.UPDATEAT , null) AS UPDATEAT
,B.nickname
from kakao_users A
JOIN CUTOFF_RS B
ON A.user_id = B.TO_ID
where B.status = 1
and A.status = 1;

