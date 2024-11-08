-- Service calls
SELECT
	TRIM(c.Service_Call_ID) AS WO_Number
	,TRIM(a.Appointment) AS Appt_Number
	,TRIM(c.Status_of_Call) AS WO_Status
	,TRIM(c.Type_of_Call) AS WO_Source
	,TRIM(c.ADRSCODE) AS Location_Code
	,TRIM(c.LOCATNNM) AS Location_Name
	,TRIM(C.Service_Description) AS WO_Description
	,TRIM(c.Technician_Team) AS Service_Team
	,TRIM(c.Technician_ID) AS Technician_1
	,TRIM(c.Technician) AS Technician_2
	,TRIM(c.Resolution_ID) AS Resolution_Code
	,TRIM(c.Resolution_Description) AS Resolution_Description
	,c.Date_of_Service_Call AS WO_Date
	,a.Task_Date AS Date_Appt
	,CASE
		WHEN YEAR(a.Completion_Date) = 1900 THEN NULL
		ELSE a.Completion_Date
	END AS Date_Complete_Appt
	,c.Completion_Date AS Date_Complete_WO
	,c.DATE1 AS WO_Created_Date
	,TRIM(c.Contract_Number) AS Contract_Number
	,TRIM(c.Divisions) AS Division
	,TRIM(c.CUSTNMBR) AS Customer_Code
	,TRIM(c.CUSTNAME) AS Customer_Name
	,(c.Bill_Customer_Number) AS Customer_Bill_Code
	--,*
FROM
	SV00300 AS c
	LEFT JOIN
	SV00301 AS a
		ON c.Service_Call_ID = a.Service_Call_ID

WHERE
	Status_of_Call = 'OPEN'			-- Select only open calls
	AND (GETDATE() - a.Task_Date ) > 30        -- Select only appointments aged by 30 or more days

ORDER BY a.Task_Date DESC, c.Service_Call_ID, a.Appointment
