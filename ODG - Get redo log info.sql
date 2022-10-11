set lines 600 pages 600
col member format a70
select st.group#
, st.sequence#
, ceil(st.bytes / 1048576) mb
, lf.member
from v$standby_log st
, v$logfile lf
where st.group# = lf.group#
/

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

set lines 500 pages 500
column member format a70
SELECT a.group#, a.bytes/1024/1024 size_mb, b.member  
FROM v$log a, v$logfile b 
WHERE a.group# = b.group#;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
set lines 500 pages 500
column member format a70
SELECT lf.group#, l_type.log_type AS TYPE, lf.MEMBER
    FROM    v$logfile lf
         JOIN
            (SELECT group#, 'ORL' AS log_type FROM v$log
             UNION
             SELECT group#, 'SRL' AS log_type FROM v$standby_log) l_type
         ON lf.group# = l_type.group#
ORDER BY lf.group#;


