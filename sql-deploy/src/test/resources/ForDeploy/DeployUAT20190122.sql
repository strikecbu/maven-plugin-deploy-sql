--EMGM_CFG_SYSPARM.sql
--{} 2019,01,22
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('BUS_API_PROTOCOL');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_PROTOCOL', 'TLS', '�ϥΪ�protocol(�w�]��TLS)', 'system', current_timestamp);
--�ק�w�]��
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'N', updateTime = current_timestamp WHERE parmId = 'BUS_API_IGNORE_SSL_VALI';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'N', updateTime = current_timestamp WHERE parmId = 'SPM_API_IGNORE_SSL_VALI';





GO
--EMGM_SHARE_LINK_COUNT.sql

GO
--EMGM_LOCKEDINFO.sql

GO
--EMGM_API_TRANSLOG.sql

GO
--EMGM_REFERRER_INFO.sql

GO
