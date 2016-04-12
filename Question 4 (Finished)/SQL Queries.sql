-- 4a

===================================================
SELECT e.pName.title || '. ' ||  e.pName.firstName || ' ' || e.pName.surName || ' lives in ' || e.pAddress.city
AS "First name contains 'on'"
FROM tEmployee e
WHERE INSTR(e.pName.firstName,'on') > 0
AND
e.pAddress.city = 'Edinburgh';

Task 4a                  


First name contains 'on'                                                       
--------------------------------------------------------------------------------
Mrs. Alison Smith lives in Edinburgh                                            
Mr. Connor OBrien lives in Edinburgh                                            
Mr. Orson Carte lives in Edinburgh                                              

===================================================


-- 4b
