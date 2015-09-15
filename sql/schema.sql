CREATE TABLE gl_acct (
 BID            NUMERIC(4)	NOT NULL
,UID            NUMERIC(6)      NOT NULL
,ACC            NUMERIC(25)     NOT NULL
,EXT            NUMERIC(25)
,AP             SMALLINT        NOT NULL
,OPEN_DATE	DATE            NOT NULL
,CLOSE_DATE	DATE
,USAGE		SMALLINT
,CONSTRAINT gl_acct_pk PRIMARY KEY(acc) USING INDEX TABLESPACE wbindx
);
COMMENT ON TABLE  gl_acct		IS 'Счета';
COMMENT ON COLUMN gl_acct.ap		IS '1/-1 Active/Passive';
COMMENT ON COLUMN gl_acct.usage		IS 'Расчётный, транзитный, депозитный...';
