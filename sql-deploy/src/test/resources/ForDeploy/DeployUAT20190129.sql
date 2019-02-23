--EMGM_CFG_SYSPARM.sql
--{} 2019,01,29
--修改被推薦人&推薦人CBOL連結 for UAT VA
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw/eMGM/client-landing/receive.html?referralCode=', updateTime = current_timestamp WHERE parmId = 'EMGM_CBOL_REFEREE';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw/eMGM/client-landing/', updateTime = current_timestamp WHERE parmId = 'EMGM_CBOL_REFERRER';
-- cross domain for captcha 添加對應domain
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw,http://127.0.0.1:8888,https://uat.onlinebanking.citigold.citibank.com.tw', updateTime = current_timestamp WHERE parmId = 'CORS_DOMAIN_URL_CAPTCHA';




GO
--EMGM_SHARE_LINK_COUNT.sql

GO
--EMGM_LOCKEDINFO.sql

GO
--EMGM_API_TRANSLOG.sql

GO
--EMGM_REFERRER_INFO.sql

GO
