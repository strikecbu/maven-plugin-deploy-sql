--{} NORMAL_TYPE

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
INSERT INTO NOW_TEST (OID, COL2) VALUES ('oid4', 'value4');

--{} 2018,08,22
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,23
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';


--{} 2018,08,24
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,27
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';