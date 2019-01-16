--testSQL1.sql
--{} 2018,08,22
UPDATE NOW_TEST1 SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,23
UPDATE NOW_TEST1 SET COL2 = 'newValue2' where COL1 = 'oid2';



GO
--testSQL.sql
--@pk:OID
--{} 2018,08,22
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,23
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';


--{} 2018,08,24
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';

--{} 2018,08,27
UPDATE NOW_TEST SET COL2 = 'newValue2' where COL1 = 'oid2';


