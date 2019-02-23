--EMGM_CFG_SYSPARM.sql
--{} 2018,10,31
-- gift pics base url
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'https://www.citibank.com.tw' WHERE parmId = 'EMGM_CBOL_GIFT_HOST';

-- BUS functionId
UPDATE [dbo].EMGM_CFG_SYSPARM SET parmValue = 'QGRBN' WHERE parmId = 'BUS_API_CUST_GRB_FUNC_ID';




--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

