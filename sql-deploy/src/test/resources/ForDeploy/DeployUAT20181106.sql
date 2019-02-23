--EMGM_CFG_SYSPARM.sql
--{} 2018,11,06
--clean API TransLog Job
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('CLEAN_API_LOG_DAYS_BEFORE', 'SCH_CLEAN_API_LOG');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CLEAN_API_LOG_DAYS_BEFORE',
'60','�M���h�֤ѫe��API trans log', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SCH_CLEAN_API_LOG',
'0 35 2 * * ?', '�妸�M��api transLog(�� �� �p�� �C��ĴX�� �� �C�P���ĴX�� �~)', 'system', current_timestamp);

-- set UAT CBOL cross allow domain
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'https://uat.onlinebanking.citigold.citibank.com.tw'
WHERE parmId = 'CORS_DOMAIN_URL_CAPTCHA';





--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

