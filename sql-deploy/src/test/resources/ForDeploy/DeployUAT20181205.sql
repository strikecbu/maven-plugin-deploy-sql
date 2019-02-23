--EMGM_CFG_SYSPARM.sql
--{} 2018,12,03
--因改只用citi-edm模組，故刪除以下兩個DB設定，改取config.properties的值
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_ENABLE', 'EDM_DEBUG');
--因改只用citi-edm模組，故刪除控制是否使用cola base citi-edm模組
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_USE_COLA_BASE_MODULE');

--{} 2018,12,05
--update put cnt batch settings from monthly to daily
UPDATE [dbo].[EMGM_CFG_SYSPARM] SET parmValue = '0 31 0 * * ?' WHERE parmId = 'SCH_SEND_SPM_CLICK_CNT';


--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

