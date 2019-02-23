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

