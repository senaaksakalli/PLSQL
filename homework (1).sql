-- turn on server output (adjust buffer size if needed)
SET SERVEROUTPUT ON SIZE 1000000;

DECLARE
  v_in    VARCHAR2(30) := 'acbbcadefghkkhgfed';  -- change this to your input
  v_len   PLS_INTEGER;
  v_char  CHAR(1);
  v_count PLS_INTEGER;
BEGIN
  -- 1) length check
  v_len := LENGTH(v_in);
  IF v_len = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: String is empty.');
    RETURN;
  ELSIF v_len > 30 THEN
    DBMS_OUTPUT.PUT_LINE('Error: Maximum string length is 30.');
    RETURN;
  END IF;

  -- 2) only alphabetic
  IF REGEXP_LIKE(v_in, '[^A-Za-z]') THEN
    DBMS_OUTPUT.PUT_LINE('Error: Only alphabetic characters allowed.');
    RETURN;
  END IF;

  -- 3) no char > 2 occurrences
  FOR i IN 1 .. v_len LOOP
    v_char  := SUBSTR(v_in, i, 1);
    -- count occurrences of v_char in v_in
    v_count := v_len - LENGTH(REPLACE(v_in, v_char, ''));
    IF v_count > 2 THEN
      DBMS_OUTPUT.PUT_LINE('Error: Character "'||v_char||'" appears more than twice.');
      RETURN;
    END IF;
  END LOOP;

  -- 4) OK — print header + each char on its own line
  DBMS_OUTPUT.PUT_LINE('String: '||v_in);
  FOR i IN 1 .. v_len LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(v_in, i, 1));
  END LOOP;
END;