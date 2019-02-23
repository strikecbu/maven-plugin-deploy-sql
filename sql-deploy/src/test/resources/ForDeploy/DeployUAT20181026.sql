--EMGM_CFG_SYSPARM.sql
--{} 2018,10,26
DELETE [dbo].[EMGM_CFG_SYSPARM];
-- DEV MODE
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('DEVELOP_TEST',
 'YES', '�}�o���եΪ�FLAG', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('DEVELOP_OTP_TEST',
 'YES', '�}�o����OTP�Ϊ�FLAG', 'system', current_timestamp);


-- �@��Ѽ�
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CLIENT_TIME_OUT', '10', '��ݺ����Τ@Timeout�ɶ�(����)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('TIME_OUT', '10', '�e�ݺ����Τ@Timeout�ɶ�(����)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('COLA_CBOL_HOST', '../static', 'EMGM CBOL url', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_LEAD_PAGE', 'http://localhost:8081/emgm-web/page/index', 'EMGM leadPage url', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CITI_LEAD_PAGE', 'https://www.citibank.com.tw/', 'citi leadPage url', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_HOST','../static', 'EMGM CBOL HOST URL', 'system', current_timestamp);
--CORS_DOMAIN_URL
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CORS_DOMAIN_URL', '*', 'CORS DOMAIN Access-Control-Allow-Origin ', 'system', current_timestamp);
--CAPTCHA CORS_DOMAIN_URL
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('CORS_DOMAIN_URL_CAPTCHA', 'http://localhost:8087', 'CORS DOMAIN Access-Control-Allow-Origin', 'system', current_timestamp);
--§��CBOL���|
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EMGM_CBOL_GIFT_HOST',
 '../static/art/images/', 'CBOL §���Ϥ�base���|', 'system', current_timestamp);


-- API common
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('IS_USE_OWN_SSL_KEY',
 'NO', '�O�_�ϥΦ۩w�qSSL KEY', 'system', current_timestamp);

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
 'UTF-8', 'EDM content charset (�i�H�]�wutf-8 or big5...����)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_ENABLE',
 'true', '�}�Ҷl�HEDM�Ѽ�(true=�ҥ�)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_DEBUG',
 'false', '�}��EDM debug�Ѽ�(true=�ҥ�)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_HOST',
 'soe-mx.apac.nsroot.net', '�o�eEDM��Server', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_FROM_ADDR',
 'citi@imta.citicorp.com', 'EDM FROM ADDRESS', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_FROM_PERSON',
 '��X�]�x�W�^�Ȧ�', 'EDM FROM PERSON (TITLE)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_USR',
 'iisiandyemail@gmail.com', 'EDM SERVER user name(webatm@citi.com)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_PWD',
 'iisi@1234', 'EDM SERVER password', 'system', current_timestamp);

--EDM Subject settings
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_REFERRER_SUBJECT',
 '�P�±z�ѻP��X�˽�a����', 'EDM ���ˤH�H�� TITLE', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_REFEREE_SUBJECT',
 '�z���]�I�޲z�ȵ{�Y�N�i�}', 'EDM �Q���ˤH�H�� TITLE', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_SPM_REFEREE_SUBJECT',
 '�m�W�M�ݱz���˽�§�J', 'EDM �s�o�H�� TITLE', 'system', current_timestamp);

--batch settings
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SCH_SEND_SPM_CLICK_CNT',
 '0 31 0 1 * ?', '�妸�ǰeSPM�~�ֿn�I����(�� �� �p�� �C��ĴX�� �� �C�P���ĴX�� �~)', 'system', current_timestamp);

 --OTP
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_ALLOW_TIMEOUT',
 '100000', 'otp����otp���\timeout�ɶ�(ms)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_MAX_SEND_TIMES',
 '7', 'OTP�̤j�o�e����(�t�Ĥ@��)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_VALI_TIMES',
 '7', 'OTP�i���~����', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('OTP_SMS',
 '�P�±z�n�J��XE-MGM�t�ΡA�z���u²�T�ʺA�K�XOTP�v�� {0}�A�K�X�N��{1}��ᥢ�ġC�Щ������J�K�X�����ӽСC', 'OTP ²�T���e', 'system', current_timestamp);



--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

