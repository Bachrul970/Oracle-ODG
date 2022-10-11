--Cancel MRP(media recovery) process in standby:

alter database recover managed standby database cancel;

--Start MRP(media recovery):

alter database recover managed standby database disconnect from session;

-- For real time media recovery

alter database recover managed standby database using current logfile disconnect from session;