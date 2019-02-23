--EMGM_CFG_SYSPARM.sql
--{} 2018,11,26
--эノciti-edm家舱珿埃ㄢDB砞﹚эconfig.properties
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_ENABLE', 'EDM_DEBUG');
--{} 2018,11,27
--玂痙ノ糶Serviceㄓ盚癳珿ㄢDB砞﹚
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_ENABLE', 'EDM_DEBUG');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_ENABLE',
 'true', '秨币秎盚EDM把计(true=币ノ)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_DEBUG',
 'false', '秨币EDM debug把计(true=币ノ)', 'system', current_timestamp);
--北琌ㄏノcola base citi-edm家舱
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_USE_COLA_BASE_MODULE');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_USE_COLA_BASE_MODULE',
 'false', '北琌ㄏノcola base citi-edm家舱', 'system', current_timestamp);

--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

