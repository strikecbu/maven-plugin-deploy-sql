--EMGM_CFG_SYSPARM.sql
--{} 2019,01,19
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('BUS_API_IS_USE_PROXY', 'BUS_API_PROXY_HOST', 'BUS_API_PROXY_PORT');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_IS_USE_PROXY', 'NO', '控制call BUS是否使用Proxy(YES開啟)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_PROXY_HOST', '', '使用Proxy的host', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES
('BUS_API_PROXY_PORT', '', '使用Proxy的port', 'system', current_timestamp);



--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

