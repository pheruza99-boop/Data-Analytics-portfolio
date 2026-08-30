select * from audio_cards;
select * from audiobooks; 
select * from listenings; 

-- Выведите сколько пользователей добавили книгу 'Coraline', 
-- сколько пользователей прослушало больше 10%. 
SELECT 
    COUNT(cards.user_id) AS added_users,
    COUNT(DISTINCT CASE 
        WHEN cards.progress > books.duration * 0.1 
        THEN cards.user_id 
    END) AS listened_more_10
FROM audio_cards cards
JOIN audiobooks books 
ON books.uuid = cards.audiobook_uuid
WHERE books.title = 'Coraline';


--По каждой операционной системе и названию книги выведите количество пользователей, 
--сумму прослушивания в часах, не учитывая тестовые прослушивания. 

SELECT 
    l.os_name,
    b.title,
    COUNT(DISTINCT l.user_id) AS users_count,
    SUM(EXTRACT(EPOCH FROM (l.finished_at - l.started_at)))/3600 AS listening_hours
FROM listenings l
JOIN audiobooks b
ON l.audiobook_uuid = b.uuid
WHERE l.is_test = 0
GROUP BY l.os_name, b.title;


-- Найдите книгу, которую слушает больше всего людей. 
SELECT 
    b.title,
    COUNT(DISTINCT l.user_id) AS users_count
FROM listenings l
JOIN audiobooks b
ON l.audiobook_uuid = b.uuid
GROUP BY b.title
ORDER BY users_count DESC
LIMIT 1;

-- Найдите книгу, которую чаще всего дослушивают до конца.
SELECT 
    b.title,
    COUNT(DISTINCT c.user_id) AS finished_count
FROM audiobooks b
JOIN audio_cards c
ON b.uuid = c.audiobook_uuid
WHERE c.state = 'finished'
GROUP BY b.title
ORDER BY finished_count DESC
LIMIT 1;
