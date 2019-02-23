--EMGM_CFG_SYSPARM.sql
--{} 2018,12,06
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('SPM_API_IGNORE_SSL_VALI', 'BUS_API_IGNORE_SSL_VALI');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_API_IGNORE_SSL_VALI',
 'Y', '控制是否忽略檢查SPM SSL憑證', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_IGNORE_SSL_VALI',
 'Y', '控制是否忽略檢查BUS SSL憑證', 'system', current_timestamp);

--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

