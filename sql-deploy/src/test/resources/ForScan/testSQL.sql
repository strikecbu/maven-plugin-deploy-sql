--{} NORMAL_TYPE
--@pk:OID
--{} init
CREATE TABLE [dbo].[NOW_TEST](
	[OID] [varchar](32) NOT NULL,
	[COL2] [varchar](14) NOT NULL,

 CONSTRAINT [P_NOW_TEST] PRIMARY KEY CLUSTERED
(
	[OID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

INSERT INTO NOW_TEST (OID, COL2) VALUES ('oid1', 'value1');
INSERT INTO NOW_TEST (OID, COL2) VALUES ('oid2', 'value2');
INSERT INTO NOW_TEST (OID, COL2) VALUES ('oid3', 'value3');

--{} update

--{} 2018,08,21
UPDATE NOW_TEST SET COL2 = 'newValue1' where COL1 = 'oid1';
--@upsert:on
INSERT INTO NOW_TEST (OID, COL2) VALUES ('oid4', 'value4');
--@upsert:off
--{} 2018,08,22
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,23
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';


--{} 2018,08,24
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,27
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--@upsert:on

--簡易難度
INSERT INTO XCOLA.dbo.DUL_SOID_MAPPING (OID, ID_NO, AGENT_CODE) VALUES ('4EE340B2A3FE4CD686960F6273AA5E98', 'M123456789', '92757');

--普通難度
INSERT INTO XCOLA.dbo.API_TRANSLOG (OID, API_NAME, REQUEST_HEADER, REQUEST_DATA, RESPONSE_HEADER, RESPONSE_DATA, HTTP_STATUS, TRACKING_ID_REQ, TRACKING_ID_RESP, APPL_TIME, BOD, ID_NUMBER) VALUES ('2fe3d07400fa46789d7e4a4bd939842c', 'API_CI_IPA', '{"channelId":["COA"],"businessCode":["GCB"],"countryCode":["TW"],"uuid":["1cc43f6b-59cb-443f-bebb-0c7fe564f6d8"],"consumerOrgCode":["COLA"],"Content-Type":["application/json; charset=UTF-8"],"Accept":["application/json"]}', '{"applicant":{"studentIndicator":"NO","financialInformation":{"incomeDetails":[{"incomeType":"DECLARED_INCOME","fixedAmount":"3000000","frequency":"ANNUALLY"}]},"employmentDetails":[{"employerName":"茲托紅與","employerRegistrationNumber":"12345678","occupationCode":"OTHER","otherOccupationDescription":"空白","industryCode":"OTHER","otherIndustryDescription":"空白","employmentDurationInYears":"18","employmentDurationInMonths":"01"}]},"controlFlowId":"687a337a486c3574504c7a4c6c64434d567a716a356951334e5258627357682b3631384658774b6872746b3d"}', '{"Date":["Thu, 24 May 2018 08:36:29 GMT"],"Transfer-Encoding":["chunked"],"uuid":["22222222222222"],"Content-Type":["application/json;charset=UTF-8"],"responseTimestamp":["Thu May 24 16:36:29 CST 2018"],"Citiuuid":["111111111111"],"Server":["Apache-Coyote/1.1"]}', '{"CustomerSearchResponse":{"customerIndicator":"NEW_TO_BANK","controlFlowId":"57446a455379616c744961477972793757324941795a4c46686539433637374d55493134374a69617768343d"},"clientCertificates":[],"cardInterchangeMessageCode":"IDENTITY_CHECK_POSITIVE","applicationId":"664319970378","controlFlowId":"687a337a486c3574504c7a4c6c64434d567a716a356951334e5258627357682b3631384658774b6872746b3d","applicationStage":"APPROVAL","requestedProductDecision":[{"creditDecision":"000"}]}', '200', 'M123456789_1d8468f1', '', '2018-05-24 16:36:29.263', '19800101', 'M123456789');

--高級難度
INSERT INTO XCOLA.dbo.DUL_SOID_MAPPING (OID, ID_NO, AGENT_CODE) VALUES (
    '4EE340B2A3FE4CD686960F6273AA5E98', 'M123456789', '92757'
)

--極端難度
INSERT INTO XCOLA.dbo.CLM_KEY_VALUE_UB (OID, KEY_ID, DATA_TYPE, VALUE_STRING, VALUE_HTML, KEY_GROUP, KEY_DESCRIPTION, COLA_PATH, IMAGE_FLAG, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, export_img_no) VALUES ('07,F8ACDA386349A8BD826A28E17487BC', 'ApplPageSubmit_TAG', 'html', '', 'var s=s_gi(''citiintltaiwandev'');
s.linkTrackVars=''prop11,products,events'';
s.linkTrackEvents=''event26,event6'';
s.products=''Credit;<!--CardType-->'';
s.prop11=''pre-login application'';
s.events=''event26,event6'';
s.tl(this,''o'',''Application Step1'');', 'GENERAL_SCRIPT', 'GENERAL_SCRIPT 20151012', null, null, 'A', '2015-10-12 16:40:36.770', 'USER001', null, null);

--@upsert:off

--{} 2019,08,12
--@skip:on
delete from [dbo].[CLM_KEY_VALUE_UB]
WHERE KEY_ID = '123';
--@skip:off