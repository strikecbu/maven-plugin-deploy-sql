
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
