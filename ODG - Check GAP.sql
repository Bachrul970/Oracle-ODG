SELECT a.thread#, b. last_seq, a.applied_seq, to_char(a. last_app_timestamp,'MM/DD/YYYY HH24:MI:SS') "last_app_timestamp", b.last_seq-a.applied_seq 
ARC_DIFF FROM (SELECT  thread#, MAX(sequence#) applied_seq, MAX(next_time) last_app_timestamp 
FROM gv$archived_log WHERE applied = 'YES' or applied='IN-MEMORY' GROUP BY thread#) a, 
(SELECT  thread#, MAX (sequence#) last_seq FROM gv$archived_log GROUP BY thread#) b 
WHERE a.thread# = b.thread#;

--Check gap on standby DB with gap
SELECT /*Check gap on stby with difference*/ al.thrd "Thread", almax "Last Seq Received", lhmax "Last Seq Applied", almax-lhmax "Gap", decode(almax-lhmax, 0, 'Sync', 'Gap') "Result"
FROM (select thread# thrd, MAX(sequence#) almax FROM v$archived_log WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) al,
(SELECT thread# thrd, MAX(sequence#) lhmax FROM v$log_history WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) lh WHERE al.thrd = lh.thrd;
