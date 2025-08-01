
SET SERVEROUTPUT ON SIZE 1000000;

DECLARE
  v_in    VARCHAR2(30) := 'acbbcadefghkkhgfed'; 
  v_len   PLS_INTEGER;
  v_char  CHAR(1);
  v_count PLS_INTEGER;
BEGIN
 
  v_len := LENGTH(v_in);
  IF v_len = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: String is empty.');
    RETURN;
  ELSIF v_len > 30 THEN
    DBMS_OUTPUT.PUT_LINE('Error: Maximum string length is 30.');
    RETURN;
  END IF;

  IF REGEXP_LIKE(v_in, '[^A-Za-z]') THEN
    DBMS_OUTPUT.PUT_LINE('Error: Only alphabetic characters allowed.');
    RETURN;
  END IF;

 
  FOR i IN 1 .. v_len LOOP
    v_char  := SUBSTR(v_in, i, 1);

    v_count := v_len - LENGTH(REPLACE(v_in, v_char, ''));
    IF v_count > 2 THEN
      DBMS_OUTPUT.PUT_LINE('Error: Character "'||v_char||'" appears more than twice.');
      RETURN;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('String: '||v_in);
  FOR i IN 1 .. v_len LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(v_in, i, 1));
  END LOOP;
END;
