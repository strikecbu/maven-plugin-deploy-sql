--EMGM_CFG_SYSPARM.sql
--{} 2018,10,26
DELETE [dbo].[EMGM_CFG_SYSPARM];
-- DEV MODE
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('DEVELOP_TEST',
 'YES', '開發測試用的FLAG', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('DEVELOP_OTP_TEST',
 'YES', '開發測試OTP用的FLAG', 'system', current_timestamp);


-- 一般參數
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CLIENT_TIME_OUT', '10', '後端網頁統一Timeout時間(分鐘)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('TIME_OUT', '10', '前端網頁統一Timeout時間(分鐘)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('COLA_CBOL_HOST', '../static', 'EMGM CBOL url', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_LEAD_PAGE', 'http://localhost:8081/emgm-web/page/index', 'EMGM leadPage url', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CITI_LEAD_PAGE', 'https://www.citibank.com.tw/', 'citi leadPage url', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_HOST','../static', 'EMGM CBOL HOST URL', 'system', current_timestamp);
--CORS_DOMAIN_URL
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CORS_DOMAIN_URL', '*', 'CORS DOMAIN Access-Control-Allow-Origin ', 'system', current_timestamp);
--CAPTCHA CORS_DOMAIN_URL
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CORS_DOMAIN_URL_CAPTCHA', 'http://localhost:8087', 'CORS DOMAIN Access-Control-Allow-Origin', 'system', current_timestamp);
--禮物CBOL路徑
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_GIFT_HOST',
 '../static/art/images/', 'CBOL 禮物圖片base路徑', 'system', current_timestamp);


-- API common
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('IS_USE_OWN_SSL_KEY',
 'NO', '是否使用自定義SSL KEY', 'system', current_timestamp);

-- SPM API
--URL
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_GET_REFERRAL_CODE_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/getReferralCode', 'SPM PUT REFEREE API URL ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_PUT_REFEREE_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/putReferee', 'SPM PUT REFEREE API URL ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_GET_DASH_BOARD_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/getDashBoard', 'SPM GET DASH BOARD API URL ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_GET_GIFT_LIST_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/getGiftList', 'SPM GET GIFT LIST API URL ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_PUT_GIFT_LIST_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/putGiftList', 'SPM PUT GIFT LIST API URL ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_GET_ANNUAL_STAT_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/getAnnualStat', 'SPM GET ANNUAL STAT API URL ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_PUT_CLICK_CNT_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/putClickCnt', 'SPM PUT CLICK CNT API URL ', 'system', current_timestamp);

--Timeout & retry
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_API_TIMEOUT',
 '60000', 'SPM API Timeout(ms) ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_API_RETRY_TIMES',
'0', 'SPM API retry times ', 'system', current_timestamp);


--BUS API
--URL
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_GET_CUST_BY_ID_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/getCustById', 'BUS GET CUST BY ID API URL ', 'system',
 current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_GET_CUST_BY_GRB_URL',
 'https://127.0.0.1:8443/mutual-authentication-server/getCustByGrb', 'BUS GET CUST BY GRB API URL ', 'system',
 current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_GET_CUST_OPEN_BY_ID_URL',
 'https://127.0.0.1:8443/emgmDummyServer/getCustOpenDateById', 'BUS GET CUST OPEN DATE BY ID API URL', 'system',
 current_timestamp);

--Timeout & retry
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_TIMEOUT',
 '60000', 'BUS API Timeout(ms) ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_RETRY_TIMES',
'0', 'BUS API retry times ', 'system', current_timestamp);

-- base parameters
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_USERNAME',
 'UserName', 'BUS BASE PARAM UserName ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_PASSWORD',
 'Password', 'BUS BASE PARAM Password ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_CUST_GRB_FUNC_ID',
 'QGRB', 'BUS BASE PARAM UserName ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_CUST_ID_BIR_FUNC_ID',
 'QGRB', 'BUS BASE PARAM Password ', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_CUST_ID_OPEN_FUNC_ID',
 'QGRBID', 'BUS BASE PARAM FunctionId ', 'system', current_timestamp);


-- EMGM API params
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_API_USERNAME',
 'SPMAP', 'EMGM API USERNAME', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_API_PASSWORD',
 'connectp@ssword', 'EMGM API PASSWORD', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_API_FUNCTION_ID',
 'SENDEDM', 'EMGM API FUNCTION_ID', 'system', current_timestamp);


-- EDM settings
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_CHARSET',
 'UTF-8', 'EDM content charset (可以設定utf-8 or big5...等等)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_ENABLE',
 'true', '開啟郵寄EDM參數(true=啟用)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_DEBUG',
 'false', '開啟EDM debug參數(true=啟用)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_HOST',
 'soe-mx.apac.nsroot.net', '發送EDM的Server', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_FROM_ADDR',
 'citi@imta.citicorp.com', 'EDM FROM ADDRESS', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_FROM_PERSON',
 '花旗（台灣）銀行', 'EDM FROM PERSON (TITLE)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_USR',
 'iisiandyemail@gmail.com', 'EDM SERVER user name(webatm@citi.com)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_PWD',
 'iisi@1234', 'EDM SERVER password', 'system', current_timestamp);

--EDM Subject settings
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_REFERRER_SUBJECT',
 '感謝您參與花旗薦賞家活動', 'EDM 推薦人信件 TITLE', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_REFEREE_SUBJECT',
 '您的財富管理旅程即將展開', 'EDM 被推薦人信件 TITLE', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_SPM_REFEREE_SUBJECT',
 '獻上專屬您的薦賞禮遇', 'EDM 群發信件 TITLE', 'system', current_timestamp);

--batch settings
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SCH_SEND_SPM_CLICK_CNT',
 '0 31 0 1 * ?', '批次傳送SPM年累積點擊數(秒 分 小時 每月第幾天 月 每星期第幾天 年)', 'system', current_timestamp);

 --OTP
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_ALLOW_TIMEOUT',
 '100000', 'otp頁面otp允許timeout時間(ms)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_MAX_SEND_TIMES',
 '7', 'OTP最大發送次數(含第一次)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_VALI_TIMES',
 '7', 'OTP可錯誤次數', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_SMS',
 '感謝您登入花旗E-MGM系統，您的「簡訊動態密碼OTP」為 {0}，密碼將於{1}秒後失效。請於網頁輸入密碼完成申請。', 'OTP 簡訊內容', 'system', current_timestamp);



--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

