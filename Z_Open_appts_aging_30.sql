-- Service calls
SELECT
	C.Service_Call_ID AS woNumber
	,a.Appointment
	,c.Status_of_Call
	,c.Type_of_Call
	,c.ADRSCODE AS LocationCode
	,c.LOCATNNM AS LocationName
	,C.Service_Description AS woDescription
	,c.Technician_Team
	,c.Technician_ID
	,c.Technician_ID2
	,c.Technician
	,c.Resolution_ID
	,c.Resolution_Description
	,c.Date_of_Service_Call
	,a.Task_Date AS Date_Appt
	,a.Completion_Date AS Date_Complete_Appt
	,c.Completion_Date AS Date_Complete_WO
	,c.DATE1
	,c.Contract_Number
	,c.Divisions
	,c.CUSTNMBR AS CustomerCode
	,c.CUSTNAME AS CustomerName
	,c.Bill_Customer_Number
	--,*
FROM
	SV00300 AS c
	LEFT JOIN
	SV00301 AS a
		ON c.Service_Call_ID = a.Service_Call_ID

WHERE
	Status_of_Call = 'OPEN'			-- Select only open calls
	AND (GETDATE() - a.Task_Date ) > 30        -- Select only appointments aged by 30 or more days

ORDER BY a.Task_Date DESC --c.Service_Call_ID, a.Appointment
