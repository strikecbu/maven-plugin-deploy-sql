--EMGM_CFG_SYSPARM.sql
--{} 2018,11,07
UPDATE [dbo].EMGM_CFG_SYSPARM SET
parmValue = 'https%3A%2F%2Fuat.onlinebanking.citigold.citibank.com.tw%2FeMGM%2Fclient-landing%2Freceive.html%3FreferralCode%3D'
WHERE parmId = 'EMGM_CBOL_SHARE_LINK_HOST';

--CBOL Referrer URL
--推薦人與被推薦人 CBOL URL
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EMGM_CBOL_REFERRER', 'EMGM_CBOL_REFEREE');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_REFERRER',
 'https://uat.onlinebanking.citigold.citibank.com.tw/eMGM/client-landing/', '推薦人CBOL URL', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_REFEREE',
 'https://uat.onlinebanking.citigold.citibank.com.tw/eMGM/client-landing/receive.html?referralCode=', '被推薦人CBOL URL', 'system', current_timestamp);

--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

