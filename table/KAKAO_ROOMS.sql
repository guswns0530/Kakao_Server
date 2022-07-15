-- 에러 있음 --

with
    CUTOFF_RS as (
        select
            FR.*,
            case
                when (
                    select
                        count(*)
                    from
                        kakao_friends
                    where
                        STATUS = 2
                        and from_id = FR.from_id
                        and to_id = FR.to_id
                ) <= 0 then '1'
                else '2'
            end as CUTOFF_RS
        from
            kakao_friends FR
        where
            from_id = 'test1'
    )

select
    A.ROOM_ID,
    nvl(A.NAME, LISTAGG(nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null), D.NAME), ', ') within group (
        order by
            C.nickname,
            D.NAME
    )) as NAME,
    nvl(A.NAME, LISTAGG(D.user_id, ', ') within group (
        order by
            C.nickname,
            D.NAME
    )) as USERID,
    LISTAGG(nvl(D.user_id, 'null'), ', ') within
group
    (
        order by
            C.nickname,
            D.NAME
    ) as NAME,
    count(B.USER_ID) + 1 as CNT,
    DECODE(E.CHAT_STATUS, 1, E.CHAT_CONTENT, null) as CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT,
    sum((
        select
            count(*)
        from
            kakao_chats G
        where
            A.ROOM_ID = G.ROOM_ID
            and G.chat_id > F.chat_id
    )) as UNREAD_CNT
from
    kakao_rooms A
    join (
        select
            E.ROOM_ID,
            max(E.CONTENT) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_CONTENT,
            max(E.type) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_TYPE,
            max(E.STATUS) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_STATUS,
            max(E.CREATEAT) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_CREATEAT
        from
            KAKAO_CHATS E
        group by
            E.ROOM_ID
    ) E on A.ROOM_ID = E.ROOM_ID
    join kakao_join_users B on A.ROOM_ID = B.ROOM_ID
    left outer join CUTOFF_RS C on B.USER_ID = C.TO_ID
    left outer join kakao_users D on B.USER_ID = D.USER_ID
    join kakao_read_users F on A.ROOM_ID = F.ROOM_ID
    and B.USER_ID = F.USER_ID
where
    B.USER_ID != 'test1'
group by
    A.ROOM_ID,
    A.NAME,
    E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
order by
    CHAT_CREATEAT asc;
    
    
-- 구림 --
with
    CUTOFF_RS as (
        select
            FR.*,
            case
                when (
                    select
                        count(*)
                    from
                        kakao_friends
                    where
                        STATUS = 2
                        and from_id = FR.from_id
                        and to_id = FR.to_id
                ) <= 0 then '1'
                else '2'
            end as CUTOFF_RS
        from
            kakao_friends FR
        where
            from_id = 'test1'
    )

select
    A.ROOM_ID,
    nvl(A.NAME, LISTAGG(nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null), D.NAME), ', ') within group (
        order by
            C.nickname,
            D.NAME
    )) as NAME,
    nvl(A.NAME, LISTAGG(D.user_id, ', ') within group (
        order by
            C.nickname,
            D.NAME
    )) as USERID,
    LISTAGG(nvl(D.user_id, 'null'), ', ') within
    group
    (
        order by
            C.nickname,
            D.NAME
    ) as NAME,
    count(B.USER_ID) + 1 as CNT,
    DECODE(E.CHAT_STATUS, 1, E.CHAT_CONTENT, null) as CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT,
    max((
        select
            count(*)
        from
            kakao_chats G
        where
            A.ROOM_ID = G.ROOM_ID
            and G.chat_id > F.chat_id
    )) as UNREAD_CNT
from
    kakao_rooms A
    join (
        select
            E.ROOM_ID,
            max(E.CONTENT) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_CONTENT,
            max(E.type) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_TYPE,
            max(E.STATUS) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_STATUS,
            max(E.CREATEAT) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT
            ) CHAT_CREATEAT
        from
            KAKAO_CHATS E
        group by
            E.ROOM_ID
    ) E on A.ROOM_ID = E.ROOM_ID
    join kakao_join_users B on A.ROOM_ID = B.ROOM_ID
    left outer join CUTOFF_RS C on B.USER_ID = C.TO_ID
    left outer join kakao_users D on B.USER_ID = D.USER_ID
    join kakao_read_users F on A.ROOM_ID = F.ROOM_ID
    and B.USER_ID = F.USER_ID
where
    B.USER_ID != 'test1'
group by
    A.ROOM_ID,
    A.NAME,
    E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
order by
    CHAT_CREATEAT asc;
    
    with
    CUTOFF_RS as (
        select
            FR.*,
            case
                when (
                    select
                        count(*)
                    from
                        kakao_friends
                    where
                        STATUS = 2
                        and from_id = FR.from_id
                        and to_id = FR.to_id
                ) <= 0 then '1'
                else '2'
            end as CUTOFF_RS
        from
            kakao_friends FR
        where
            from_id = 'test1'
    )

select
    A.room_id as ROOM_ID,
    nvl(A.NAME, LISTAGG(nvl(DECODE(C.CUTOFF_RS, 1, C.nickname, null), D.NAME), ', ') within group (
        order by
            C.nickname,
            D.NAME
    )) as ROOM_NAME,
    nvl(A.NAME, LISTAGG(D.user_id, ', ') within group (
        order by
            C.nickname,
            D.NAME
    )) as USER_IDS,
    count(B.USER_ID) + 1 AS JOIN_USER_CNT,
    DECODE(E.CHAT_STATUS, 1, E.CHAT_CONTENT, null) as CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT,
    max((
        select
            count(*)
        from
            kakao_chats G
        where
            G.room_id = A.room_Id
            and G.CHAT_ID > (
                select
                    chat_id
                from
                    KAKAO_READ_USERS
                where
                    room_id = G.room_id
                    and user_id = 'test1'
                    and status in (
                        1,
                        2
                    )
            )
    )) as UNREAD_CNT
from
    KAKAO_ROOMS A
    join (
        select
            E.ROOM_ID,
            max(E.CONTENT) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT,
                    E.CHAT_ID
            ) CHAT_CONTENT,
            max(E.type) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT,
                    E.CHAT_ID
            ) CHAT_TYPE,
            max(E.STATUS) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT,
                    E.CHAT_ID
            ) CHAT_STATUS,
            max(E.CREATEAT) keep (
                DENSE_RANK last
                order by
                    E.CREATEAT,
                    E.CHAT_ID
            ) CHAT_CREATEAT
        from
            KAKAO_CHATS E
        group by
            E.ROOM_ID
    ) E on A.ROOM_ID = E.ROOM_ID
    join KAKAO_JOIN_USERS B on A.ROOM_ID = B.ROOM_ID
    left outer join CUTOFF_RS C on B.USER_ID = C.TO_ID
    left outer join KAKAO_USERS D on B.USER_ID = D.USER_ID
where
    B.USER_ID != 'test1'
    and A.STATUS = 1
group by
    A.ROOM_ID,
    A.NAME,
    A.ROOM_ID,
    A.NAME,
    E.CHAT_CONTENT,
    E.CHAT_TYPE,
    E.CHAT_STATUS,
    E.CHAT_CREATEAT
order by CHAT_CREATEAT desc;