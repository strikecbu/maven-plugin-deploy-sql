--EMGM_CFG_SYSPARM.sql
--{} 2018,11,26
--�]���citi-edm�ҲաA�G�R���H�U���DB�]�w�A���config.properties����
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_ENABLE', 'EDM_DEBUG');
--{} 2018,11,27
--�]���O�d�Υt�~�g��Service�ӱH�e�A�G�[�^�H�U���DB�]�w
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_ENABLE', 'EDM_DEBUG');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_ENABLE',
 'true', '�}�Ҷl�HEDM�Ѽ�(true=�ҥ�)', 'system', current_timestamp);
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_DEBUG',
 'false', '�}��EDM debug�Ѽ�(true=�ҥ�)', 'system', current_timestamp);
--����O�_�ϥ�cola base citi-edm�Ҳ�
DELETE [dbo].EMGM_CFG_SYSPARM where parmId IN ('EDM_USE_COLA_BASE_MODULE');
INSERT INTO [dbo].[EMGM_CFG_SYSPARM] (parmId, parmValue, parmDesc, updater, updateTime) VALUES ('EDM_USE_COLA_BASE_MODULE',
 'false', '����O�_�ϥ�cola base citi-edm�Ҳ�', 'system', current_timestamp);

--EMGM_SHARE_LINK_COUNT.sql

--EMGM_LOCKEDINFO.sql

--EMGM_API_TRANSLOG.sql

--EMGM_REFERRER_INFO.sql

