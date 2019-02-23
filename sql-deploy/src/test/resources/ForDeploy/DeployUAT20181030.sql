--EMGM_CFG_SYSPARM.sql
--{} 2018,10,30
--SPM UAT URL
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/getAnnualStat' WHERE parmId = 'SPM_GET_ANNUAL_STAT_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/getDashBoard' WHERE parmId = 'SPM_GET_DASH_BOARD_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/getGiftList' WHERE parmId = 'SPM_GET_GIFT_LIST_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/getReferralCode' WHERE parmId = 'SPM_GET_REFERRAL_CODE_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/putClickCnt' WHERE parmId = 'SPM_PUT_CLICK_CNT_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/putGiftList' WHERE parmId = 'SPM_PUT_GIFT_LIST_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'http://apaccititwua127.apac.nsroot.net:8080/api/EMGMApi/putReferee' WHERE parmId = 'SPM_PUT_REFEREE_URL';
--BUS UAT URL
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'https://apacctltwua201.apac.nsroot.net:90/enoapi/enoapi.ashx' WHERE parmId = 'BUS_GET_CUST_BY_GRB_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'https://apacctltwua201.apac.nsroot.net:90/enoapi/enoapi.ashx' WHERE parmId = 'BUS_GET_CUST_BY_ID_URL';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'https://apacctltwua201.apac.nsroot.net:90/enoapi/enoapi.ashx' WHERE parmId = 'BUS_GET_CUST_OPEN_BY_ID_URL';

--EDM setting for UAT
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'webatm@citi.com' WHERE parmId = 'EDM_FROM_ADDR';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'imbapprelay-restricted.wlb2.nam.nsroot.net' WHERE parmId = 'EDM_HOST';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = '' WHERE parmId = 'EDM_PWD';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = '' WHERE parmId = 'EDM_USR';

--bus API base setting
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'citibank@PMOM' WHERE parmId = 'BUS_API_USERNAME';
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'connectP@ssw0rd' WHERE parmId = 'BUS_API_PASSWORD';

-- gift pics base url
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'https://www.citibank.com.tw/eMGM/gift/' WHERE parmId = 'EMGM_CBOL_GIFT_HOST';

-- show API log
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('DEVELOP_SHOW_API_LOG');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('DEVELOP_SHOW_API_LOG',
 'YES', '顯示API LOG於前端（YES開啟）', 'system', current_timestamp);

-- share link base url
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EMGM_CBOL_SHARE_LINK_HOST');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_SHARE_LINK_HOST',
'https%3A%2F%2Fuat.newwebatm.citibank.com.tw%2Fextfunc33%2Fstatic%2Fui%2FdummyLead%2FleadReferee.html%3FreferralCode%3D',
'Dashboard底下分享連結，含參數?xxx=，其後值動態帶入', 'system', current_timestamp);




--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

