--{} SYS_TYPE
--{} init
--@pk:parmId // primary key
create table TEST
(
    parmId     varchar(30)  not null
        constraint P_TEST
            primary key,
    parmValue  varchar(300) not null,
    parmDesc   varchar(300),
    updater    varchar(10),
    updateTime datetime
)

--{} update
--{} 2020,06,10 //data format yyyy,MM,dd
--@upsert:on //insert script must put in this section
delete TEST where 1 = 1;
INSERT INTO TEST (parmId, parmValue, parmDesc, updater, updateTime) VALUES (N'TEST_KEY', N'TEST_VALUE', N'desc', N'sys', current_timestamp);
--@upsert:off

-- // update script don't require --@upsert section
UPDATE TEST SET parmValue = '123' WHERE parmId = 'TEST';

--@skip:on
DELETE TABLE TEST;
--@skip:off

