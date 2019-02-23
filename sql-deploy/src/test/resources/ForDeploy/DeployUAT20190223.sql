--EMGM_CFG_SYSPARM.sql
--{} 2019,02,23
--JVM protocol
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'TLSv1.2', parmDesc = 'https.protocols使用的protocol(預設為""不設定)' WHERE parmId = 'BUS_API_JVM_PROTOCOL';

--調整各項連結
--update EMGM lead page
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://pat.webatm.citibank.com.tw/extfunc33/page/otp',
updateTime = CURRENT_TIMESTAMP WHERE parmId = 'EMGM_LEAD_PAGE';
-- BUS API URL
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apacctltwap204.apac.nsroot.net:92/enoapi/enoapi.ashx', updateTime = current_timestamp WHERE parmId = 'BUS_GET_CUST_BY_GRB_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apacctltwap204.apac.nsroot.net:92/enoapi/enoapi.ashx', updateTime = current_timestamp WHERE parmId = 'BUS_GET_CUST_BY_ID_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apacctltwap204.apac.nsroot.net:92/enoapi/enoapi.ashx', updateTime = current_timestamp WHERE parmId = 'BUS_GET_CUST_OPEN_BY_ID_URL';
-- SPM API URL
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/getAnnualStat', updateTime = current_timestamp WHERE parmId = 'SPM_GET_ANNUAL_STAT_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/getDashBoard', updateTime = current_timestamp WHERE parmId = 'SPM_GET_DASH_BOARD_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/getGiftList', updateTime = current_timestamp WHERE parmId = 'SPM_GET_GIFT_LIST_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/getReferralCode', updateTime = current_timestamp WHERE parmId = 'SPM_GET_REFERRAL_CODE_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/putClickCnt', updateTime = current_timestamp WHERE parmId = 'SPM_PUT_CLICK_CNT_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/putGiftList', updateTime = current_timestamp WHERE parmId = 'SPM_PUT_GIFT_LIST_URL';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://apaccititwap316.apac.nsroot.net:442/api/EMGMApi/putReferee', updateTime = current_timestamp WHERE parmId = 'SPM_PUT_REFEREE_URL';

--CBOL URL TODO
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw/eMGM/client-landing/receive.html?referralCode=' WHERE parmId = 'EMGM_CBOL_REFEREE';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw/eMGM/client-landing/' WHERE parmId = 'EMGM_CBOL_REFERRER';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https%3A%2F%2Fuat.onlinebanking.citigold.citibank.com.tw%2FeMGM%2Fclient-landing%2Freceive.html%3FreferralCode%3D' WHERE parmId = 'EMGM_CBOL_SHARE_LINK_HOST';



GO
--EMGM_LOCKEDINFO.sql

GO
--EMGM_SHARE_LINK_COUNT.sql

GO
--EMGM_API_TRANSLOG.sql

GO
--EMGM_REFERRER_INFO.sql

GO
