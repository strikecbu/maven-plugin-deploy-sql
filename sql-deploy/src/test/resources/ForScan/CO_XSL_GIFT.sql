--{} NORMAL_TYPE
--@pk:OID
--{} init

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CO_XSL_GIFT]') AND type in (N'U'))
DROP TABLE [dbo].[CO_XSL_GIFT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CO_XSL_GIFT](
	[OID] [varchar](32) NOT NULL,
	[GIFT_ID] [varchar](20) NOT NULL,
	[GIFT_NAME] [nvarchar](100) NULL,
	[PIC_URL] [varchar](100) NULL,
	[ACTION_FLAG] [char](1) NULL,
	[MODIFY_DATE] [datetime] NULL,
	[MODIFIER] [varchar](20) NULL,
	[EXPORT_NO] [varchar](10) NULL,
	[DESC_HTML] [text] NULL,
	[EDM_DESC] [varchar](max) NULL,
	[CFMPG_PIC_URL] [varchar](200) NULL,
	[THX_BENEFIT_DESC] [varchar](100) NULL,
 CONSTRAINT [P_XSL_GIFT] PRIMARY KEY CLUSTERED 
(
	[OID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
--{} update


--{} 2019,08,12
--@skip:on
DROP TABLE [dbo].[CO_XSL_GIFT]
--@skip:off

--@upsert:on
delete from CO_XSL_GIFT where GIFT_ID in ('290');
INSERT INTO CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) values
( 'fasdjfkadsfkjsdakfj','290','韓國Neoflam鈦金不沾鍋具4件組(290)','', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', NULL);
INSERT INTO CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) values ('KFIKSISUJDIJD9JKDUPIKDIWH','291','29吋行李箱(閃耀銀)(291)','', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', NULL);
insert into CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) values ('KFIKSISUJDIJD9JKDUPMFKSOW','292','29吋行李箱(閃耀藍)(292)','', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', NULL);
insert into CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) values ('KFIKSISUJDIJD9JKDUPPDDIDD','293','懶骨頭沙發(293)','', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', NULL);
--@upsert:off

-- -- INSERT INTO CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) VALUES ('KFIKSISUJDIJD9JKDUPMPLDOE', '290', '韓國Neoflam鈦金不沾鍋具4件組(290)', '', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', null);
-- INSERT INTO CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) VALUES ('KFIKSISUJDIJD9JKDUPIKDIWH', '291', '29吋行李箱(閃耀銀)(291)', '', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', null);
-- INSERT INTO CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) VALUES ('KFIKSISUJDIJD9JKDUPMFKSOW', '292', '29吋行李箱(閃耀藍)(292)', '', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', null);
-- INSERT INTO CO_XSL_GIFT (OID, GIFT_ID, GIFT_NAME, PIC_URL, ACTION_FLAG, MODIFY_DATE, MODIFIER, EXPORT_NO, DESC_HTML, EDM_DESC, CFMPG_PIC_URL, THX_BENEFIT_DESC) VALUES ('KFIKSISUJDIJD9JKDUPPDDIDD', '293', '懶骨頭沙發(293)', '', 'A', current_timestamp, 'user001', null, '<p>NO_NEED_TO_USE</p>', '', 'NO_NEED_TO_USE', null);





