--DeployUAT20181205.sql
--EMGM_CFG_SYSPARM.sql
--{} 2018,12,03
--�]��u��citi-edm�ҲաA�G�R���H�U���DB�]�w�A���config.properties����
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_ENABLE', 'EDM_DEBUG');
--�]��u��citi-edm�ҲաA�G�R������O�_�ϥ�cola base citi-edm�Ҳ�
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_USE_COLA_BASE_MODULE');

--{} 2018,12,05
--update put cnt batch settings from monthly to daily
UPDATE [dbo].[EMGM_CFG_SYSPARM] SET parmValue = '0 31 0 * * ?' WHERE parmId = 'SCH_SEND_SPM_CLICK_CNT';


--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql


--DeployUAT20181206.sql
--EMGM_CFG_SYSPARM.sql
--{} 2018,12,06
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('SPM_API_IGNORE_SSL_VALI', 'BUS_API_IGNORE_SSL_VALI');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('SPM_API_IGNORE_SSL_VALI',
 'Y', '����O�_�����ˬdSPM SSL����', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('BUS_API_IGNORE_SSL_VALI',
 'Y', '����O�_�����ˬdBUS SSL����', 'system', current_timestamp);

--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql


--Deploy20190101.sql
--testSQL1.sql
--{} 2018,08,22
UPDATE NOW_TEST1 SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,23
UPDATE NOW_TEST1 SET COL2 = 'newValue2' where COL1 = 'oid2';



GO
--testSQL.sql
--@pk:OID
--{} 2018,08,22
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,23
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';


--{} 2018,08,24
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,27
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';



--Deploy20190110.sql

--簡易難度
UPDATE XCOLA.dbo.DUL_SOID_MAPPING SET OID = '4EE340B2A3FE4CD686960F6273AA5E98', ID_NO = 'M123456789', AGENT_CODE = '92757' WHERE OID = '4EE340B2A3FE4CD686960F6273AA5E98'
IF @@ROWCOUNT=0
	INSERT INTO XCOLA.dbo.DUL_SOID_MAPPING (OID, ID_NO, AGENT_CODE) VALUES ('4EE340B2A3FE4CD686960F6273AA5E98', 'M123456789', '92757');

--普通難度
UPDATE XCOLA.dbo.API_TRANSLOG SET OID = '2fe3d07400fa46789d7e4a4bd939842c', API_NAME = 'API_CI_IPA', REQUEST_HEADER = '{"channelId":["COA"],"businessCode":["GCB"],"countryCode":["TW"],"uuid":["1cc43f6b-59cb-443f-bebb-0c7fe564f6d8"],"consumerOrgCode":["COLA"],"Content-Type":["application/json; charset=UTF-8"],"Accept":["application/json"]}', REQUEST_DATA = '{"applicant":{"studentIndicator":"NO","financialInformation":{"incomeDetails":[{"incomeType":"DECLARED_INCOME","fixedAmount":"3000000","frequency":"ANNUALLY"}]},"employmentDetails":[{"employerName":"茲托紅與","employerRegistrationNumber":"12345678","occupationCode":"OTHER","otherOccupationDescription":"空白","industryCode":"OTHER","otherIndustryDescription":"空白","employmentDurationInYears":"18","employmentDurationInMonths":"01"}]},"controlFlowId":"687a337a486c3574504c7a4c6c64434d567a716a356951334e5258627357682b3631384658774b6872746b3d"}', RESPONSE_HEADER = '{"Date":["Thu, 24 May 2018 08:36:29 GMT"],"Transfer-Encoding":["chunked"],"uuid":["22222222222222"],"Content-Type":["application/json;charset=UTF-8"],"responseTimestamp":["Thu May 24 16:36:29 CST 2018"],"Citiuuid":["111111111111"],"Server":["Apache-Coyote/1.1"]}', RESPONSE_DATA = '{"CustomerSearchResponse":{"customerIndicator":"NEW_TO_BANK","controlFlowId":"57446a455379616c744961477972793757324941795a4c46686539433637374d55493134374a69617768343d"},"clientCertificates":[],"cardInterchangeMessageCode":"IDENTITY_CHECK_POSITIVE","applicationId":"664319970378","controlFlowId":"687a337a486c3574504c7a4c6c64434d567a716a356951334e5258627357682b3631384658774b6872746b3d","applicationStage":"APPROVAL","requestedProductDecision":[{"creditDecision":"000"}]}', HTTP_STATUS = '200', TRACKING_ID_REQ = 'M123456789_1d8468f1', TRACKING_ID_RESP = '', APPL_TIME = '2018-05-24 16:36:29.263', BOD = '19800101', ID_NUMBER = 'M123456789' WHERE OID = '2fe3d07400fa46789d7e4a4bd939842c'
IF @@ROWCOUNT=0
	INSERT INTO XCOLA.dbo.API_TRANSLOG (OID, API_NAME, REQUEST_HEADER, REQUEST_DATA, RESPONSE_HEADER, RESPONSE_DATA, HTTP_STATUS, TRACKING_ID_REQ, TRACKING_ID_RESP, APPL_TIME, BOD, ID_NUMBER) VALUES ('2fe3d07400fa46789d7e4a4bd939842c', 'API_CI_IPA', '{"channelId":["COA"],"businessCode":["GCB"],"countryCode":["TW"],"uuid":["1cc43f6b-59cb-443f-bebb-0c7fe564f6d8"],"consumerOrgCode":["COLA"],"Content-Type":["application/json; charset=UTF-8"],"Accept":["application/json"]}', '{"applicant":{"studentIndicator":"NO","financialInformation":{"incomeDetails":[{"incomeType":"DECLARED_INCOME","fixedAmount":"3000000","frequency":"ANNUALLY"}]},"employmentDetails":[{"employerName":"茲托紅與","employerRegistrationNumber":"12345678","occupationCode":"OTHER","otherOccupationDescription":"空白","industryCode":"OTHER","otherIndustryDescription":"空白","employmentDurationInYears":"18","employmentDurationInMonths":"01"}]},"controlFlowId":"687a337a486c3574504c7a4c6c64434d567a716a356951334e5258627357682b3631384658774b6872746b3d"}', '{"Date":["Thu, 24 May 2018 08:36:29 GMT"],"Transfer-Encoding":["chunked"],"uuid":["22222222222222"],"Content-Type":["application/json;charset=UTF-8"],"responseTimestamp":["Thu May 24 16:36:29 CST 2018"],"Citiuuid":["111111111111"],"Server":["Apache-Coyote/1.1"]}', '{"CustomerSearchResponse":{"customerIndicator":"NEW_TO_BANK","controlFlowId":"57446a455379616c744961477972793757324941795a4c46686539433637374d55493134374a69617768343d"},"clientCertificates":[],"cardInterchangeMessageCode":"IDENTITY_CHECK_POSITIVE","applicationId":"664319970378","controlFlowId":"687a337a486c3574504c7a4c6c64434d567a716a356951334e5258627357682b3631384658774b6872746b3d","applicationStage":"APPROVAL","requestedProductDecision":[{"creditDecision":"000"}]}', '200', 'M123456789_1d8468f1', '', '2018-05-24 16:36:29.263', '19800101', 'M123456789');

--高級難度
UPDATE XCOLA.dbo.DUL_SOID_MAPPING SET OID = '4EE340B2A3FE4CD686960F6273AA5E98', ID_NO = 'M123456789', AGENT_CODE = '92757' WHERE OID = '4EE340B2A3FE4CD686960F6273AA5E98'
IF @@ROWCOUNT=0
	INSERT INTO XCOLA.dbo.DUL_SOID_MAPPING (OID, ID_NO, AGENT_CODE) VALUES (
    '4EE340B2A3FE4CD686960F6273AA5E98', 'M123456789', '92757'
)

--極端難度
UPDATE XCOLA.dbo.CLM_KEY_VALUE_UB SET OID = '07,F8ACDA386349A8BD826A28E17487BC', KEY_ID = 'ApplPageSubmit_TAG', DATA_TYPE = 'html', VALUE_STRING = '', VALUE_HTML = 'var s=s_gi(''citiintltaiwandev'');
s.linkTrackVars=''prop11,products,events'';
s.linkTrackEvents=''event26,event6'';
s.products=''Credit;<!--CardType-->'';
s.prop11=''pre-login application'';
s.events=''event26,event6'';
s.tl(this,''o'',''Application Step1'');', KEY_GROUP = 'GENERAL_SCRIPT', KEY_DESCRIPTION = 'GENERAL_SCRIPT 20151012', COLA_PATH = null, IMAGE_FLAG = null, ACTION_FLAG = 'A', MODIFY_DATE = '2015-10-12 16:40:36.770', MODIFIER = 'USER001', EXPORT_NO = null, export_img_no = null WHERE OID = '07,F8ACDA386349A8BD826A28E17487BC'
IF @@ROWCOUNT=0
	INSERT INTO XCOLA.dbo.CLM_KEY_VALUE_UB (OID, KEY_ID, DATA_TYPE, VALUE_STRING, VALUE_HTML, KEY_GROUP, KEY_DESCRIPTION, COLA_PATH, IMAGE_FLAG, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, export_img_no) VALUES ('07,F8ACDA386349A8BD826A28E17487BC', 'ApplPageSubmit_TAG', 'html', '', 'var s=s_gi(''citiintltaiwandev'');
s.linkTrackVars=''prop11,products,events'';
s.linkTrackEvents=''event26,event6'';
s.products=''Credit;<!--CardType-->'';
s.prop11=''pre-login application'';
s.events=''event26,event6'';
s.tl(this,''o'',''Application Step1'');', 'GENERAL_SCRIPT', 'GENERAL_SCRIPT 20151012', null, null, 'A', '2015-10-12 16:40:36.770', 'USER001', null, null);



GO

--DeployUAT20190119.sql
--EMGM_CFG_SYSPARM.sql
--{} 2019,01,19
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('BUS_API_IS_USE_PROXY', 'BUS_API_PROXY_HOST', 'BUS_API_PROXY_PORT');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_IS_USE_PROXY', 'NO', '����call BUS�O�_�ϥ�Proxy(YES�}��)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_PROXY_HOST', '', '�ϥ�Proxy��host', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_PROXY_PORT', '', '�ϥ�Proxy��port', 'system', current_timestamp);



--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql


--DeployUAT20190122.sql
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

--DeployUAT20190129.sql
--EMGM_CFG_SYSPARM.sql
--{} 2019,01,29
--�ק�Q���ˤH&���ˤHCBOL�s�� for UAT VA
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw/eMGM/client-landing/receive.html?referralCode=', updateTime = current_timestamp WHERE parmId = 'EMGM_CBOL_REFEREE';
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'https://portaluat.citibank.com.tw/eMGM/client-landing/', updateTime = current_timestamp WHERE parmId = 'EMGM_CBOL_REFERRER';
-- cross domain for captcha �K�[����domain
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

--DeployUAT20190222.sql
--EMGM_CFG_SYSPARM.sql
--{} 2019,02,21
-- cross domain for captcha �]�w�������\
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = '*', updateTime = current_timestamp WHERE parmId = 'CORS_DOMAIN_URL_CAPTCHA';

--{} 2019,02,22
-- add set JVM System property protocol
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('BUS_API_JVM_PROTOCOL');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_JVM_PROTOCOL', '', '�ϥΪ�protocol(�w�]��""���ϥ�)', 'system', current_timestamp);



GO
--EMGM_SHARE_LINK_COUNT.sql

GO
--EMGM_LOCKEDINFO.sql

GO
--EMGM_API_TRANSLOG.sql

GO
--EMGM_REFERRER_INFO.sql

GO

--DeployUAT20190223.sql
--EMGM_CFG_SYSPARM.sql
--{} 2019,02,23
--JVM protocol
UPDATE dbo.EMGM_CFG_SYSPARM SET parmValue = 'TLSv1.2', parmDesc = 'https.protocols�ϥΪ�protocol(�w�]��""���]�w)' WHERE parmId = 'BUS_API_JVM_PROTOCOL';

--�վ�U���s��
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

