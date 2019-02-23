--EMGM_CFG_SYSPARM.sql
--{} 2019,02,21
-- cross domain for captcha 設定全部允許
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = '*', updateTime = current_timestamp WHERE parmId = 'CORS_DOMAIN_URL_CAPTCHA';

--{} 2019,02,22
-- add set JVM System property protocol
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('BUS_API_JVM_PROTOCOL');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_JVM_PROTOCOL', '', '使用的protocol(預設為""不使用)', 'system', current_timestamp);



GO
--EMGM_SHARE_LINK_COUNT.sql

GO
--EMGM_LOCKEDINFO.sql

GO
--EMGM_API_TRANSLOG.sql

GO
--EMGM_REFERRER_INFO.sql

GO
