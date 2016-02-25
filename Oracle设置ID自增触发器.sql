CREATE SEQUENCE "SEQ_表名"
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 999999999999999999999999999
 START WITH 1
 CACHE 10;
 
 create or replace trigger TRIGGER_表名
  before insert on 表名
  for each row
declare
  -- local variables here
begin
  SELECT SEQ_表名.NEXTVAL INTO :NEW.ID FROM DUAL;
end TRIGGER_表名;

