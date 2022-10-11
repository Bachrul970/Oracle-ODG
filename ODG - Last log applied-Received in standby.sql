select 'Last Log applied : ' Logs, to_char(next_time,'DD-MON-YY:HH24:MI:SS') Time
from v$archived_log
where sequence# = (select max(sequence#) from v$archived_log where applied='YES')
union
select 'Last Log received : ' Logs, to_char(next_time,'DD-MON-YY:HH24:MI:SS') Time
from v$archived_log
where sequence# = (select max(sequence#) from v$archived_log);