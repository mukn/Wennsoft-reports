/** This is a time report split per employee.
	**/

SELECT
	EmpGrp.Employee_Code
	,Emps.Last_Name
	,Emps.First_Name
	,EmpGrp.Labor_Date
	,EmpGrp.Daily_hours

FROM 
	(SELECT CAST(EMPLOYID AS int) AS Employee_Code, WS_Transaction_Date AS Labor_Date, CASE WHEN DYOFWEEK ='Monday' THEN SUM(MONDAY / 100.0) WHEN DYOFWEEK ='Tuesday' THEN SUM(TUESDAY / 100.0) WHEN DYOFWEEK ='Wednesday' THEN SUM(WEDNESDAY / 100.0) WHEN DYOFWEEK ='Thursday' THEN SUM(THURSDAY / 100.0) WHEN DYOFWEEK ='Friday' THEN SUM(FRIDAY / 100.0) WHEN DYOFWEEK ='Saturday' THEN SUM(SATURDAY / 100.0) WHEN DYOFWEEK ='Sunday' THEN SUM(SUNDAY / 100.0) END AS Daily_hours, LTRIM(RTRIM(UPRTRXCD)) AS Pay_Type
	FROM WS10702
	GROUP BY EMPLOYID, WS_Transaction_Date, DYOFWEEK, UPRTRXCD) AS EmpGrp
	LEFT OUTER JOIN
	(SELECT CAST(EMPLOYID AS int) AS Employee_Code, LTRIM(RTRIM(FRSTNAME)) AS First_Name, LTRIM(RTRIM(LASTNAME)) AS Last_Name 
	FROM UPR00100) AS Emps
		ON EmpGrp.Employee_Code = Emps.Employee_Code
	
WHERE EmpGrp.Labor_Date > (GETDATE() - 8)
