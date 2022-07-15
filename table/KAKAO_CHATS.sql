-- ���� ä�� �ҷ����� Parameter( user_id, room_id )
with
    CUTOFF_RS as -- whit_start
    (
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
                        and (
                            (
                                from_id = FR.to_id
                                and to_id = FR.from_id
                            )
                            or (
                                from_id = FR.from_id
                                and to_id = FR.to_id
                            )
                        )
                ) <= 0 then '1'
                else '2'
            end as CUTOFF_RS
        from
            kakao_friends FR
        where
            from_id = 'test1'
    ) -- whit_end

select
    A.USER_ID,
    A.NAME,
    DECODE(B.CUTOFF_RS, '1', A.PROVIDER, null) as PROVIDER,
    DECODE(B.CUTOFF_RS, '1', B.NICKNAME, null) as NICKNAME,
    DECODE(B.CUTOFF_RS, '1', A.PROFILE_IMAGE, null) as PROFILE_IMAGE,
    DECODE(B.CUTOFF_RS, '1', A.BACKGROUND_IMAGE, null) as BACKGROUND_IMAGE,
    C.chat_id as CHAT_ID,
    DECODE(C.status, '1', C.content, null) as CONTENT,
    C.type as type,
    C.seq as SEQ,
    C.CREATEAT as CHAT_CREATEAT
from
    (
        select
            chat_id,
            content,
            kakao_chats.user_id,
            kakao_chats.status status,
            type,
            dense_rank() over(order by kakao_chats.createAt desc) as seq,
            kakao_chats.createAT --��ȿ� �ִ� ��� ä��
        from
            kakao_chats
            join kakao_join_users on kakao_chats.user_id = kakao_join_users.user_id
            and kakao_chats.room_id = kakao_join_users.room_id
        where
            kakao_chats.room_id = 1
            and kakao_chats.createAt >= (
                select
                    createAt
                from
                    kakao_join_users
                where
                    room_id = 1
                    and user_id = 'test1'
            )
        order by
            kakao_chats.createAt desc
    ) C
    join kakao_users A on c.user_id = A.user_id
    left outer join CUTOFF_RS B on B.to_id = A.user_id
where
    seq between 1 and 20;

-- ä�� ��ȸ ( ���� ) --
with
    CUTOFF_RS as -- whit_start
    (
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
                        and (
                            (
                                from_id = FR.to_id
                                and to_id = FR.from_id
                            )
                            or (
                                from_id = FR.from_id
                                and to_id = FR.to_id
                            )
                        )
                ) <= 0 then '1'
                else '2'
            end as CUTOFF_RS
        from
            kakao_friends FR
        where
            from_id = 'test1'
    ) -- whit_end

select
    a.chat_id,
    DECODE(A.STATUS, '1', A.CONTENT, null) as CONTENT,
    a.user_id,
    a.status,
    a.type,
    a.seq,
    a.createAt,
    nvl(B.NICKNAME, C.NAME) as NAME,
    DECODE(B.CUTOFF_RS, '2', null, C.PROFILE_IMAGE) as PROFILE_IMAGE,
    DECODE(B.CUTOFF_RS, '2', null, C.BACKGROUND_IMAGE) as BACKGROUND_IMAGE
from
    (
        select
            A.chat_id,
            A.content,
            A.user_id,
            A.status,
            A.type,
            dense_rank() over(order by A.createAt desc) as seq,
            A.createAt --sub start
        from
            kakao_chats A
            join kakao_join_users B on A.room_id = B.room_id
        where
            B.createAt <= A.createAt
            and B.user_id = 'test1'
            and A.room_id = 1
    ) A --sub end
    left outer join CUTOFF_RS B on A.user_id = B.to_id
    join kakao_users C on A.user_id = C.user_id
where
    seq >= 1
    and seq <= 20 -- start ~ end
order by
    seq,
    chat_id desc;

-- ä�� ����
update
    kakao_chats
set
    status = 2
where
    chat_id = ?;

-- ä�� �Է�
insert into
    kakao_chats (
        chat_id,
        user_id,
        room_id,
        content,
        status,
        type,
        createAt
    )
values
    (
        KAKAO_CHATS_SEQ.nextval,
        ���� ���̵�,
        �� ���̵�,
        ����Ʈ,
        1, -- �⺻
        Ÿ��,
        sysdate
    );
    
-- ���� ��� ��ȸ
select chat_id
from kakao_read_users
where room_id = 1
order by chat_id desc;