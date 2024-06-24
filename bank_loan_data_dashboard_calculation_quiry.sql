
--*********SUMMARY_DASHBOARD**********

--Select_all_data
SELECT * FROM bank_loan_data

--Calculate_KPIS

--@1@Loan_application
--Total_loan_application
SELECT COUNT(id) AS Total_loan_application FROM bank_loan_data
--MONTH_TO_DATE_loan_application
SELECT COUNT(id) AS MTD_loan_application FROM bank_loan_data 
WHERE MONTH(issue_date) = 12
--PRIVIOUS_MONTH_TO_DATE_loan_application
SELECT COUNT(id) AS PMTD_loan_application FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--@2@Funded_amount
--Total_funded_amount
SELECT SUM(loan_amount) AS Total_funded_amount FROM bank_loan_data
--MTD_funded_amount
SELECT SUM(loan_amount) AS MTD_funded_amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12
--PMTD_funded_amount
SELECT SUM(loan_amount) AS PMTD_funded_amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--@3@Amount_recevied
--Total_amount_recevied
SELECT SUM(total_payment) AS Total_amount_recevied FROM bank_loan_data
--MTD_amount_recevied
SELECT SUM(total_payment) AS MTD_amount_recevied FROM bank_loan_data
WHERE MONTH(issue_date) = 12
--PMTD_amount _recevied
SELECT SUM(total_payment) AS PMTD_amount_recevied FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--@4@Average_intrest_rate
--Total_average_intrest_rate
SELECT AVG(int_rate) * 100 AS Total_average_int_rate FROM bank_loan_data
--MTD_average_int_rate
SELECT AVG(int_rate) * 100 AS MTD_average_int_rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12
--PMTD_average_int_rate
SELECT AVG(int_rate) * 100 AS PMTD_average_int_rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--@5@Average_DTI
--Total_average_DTI
SELECT AVG(dti) * 100 AS Total_average_DTI FROM bank_loan_data
--MTD_average_DTI
SELECT AVG(dti) *100 AS MTD_average_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12
--PMTD_average_DTI
SELECT AVG(dti) * 100 AS PMTD_average_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11





--GOOD_LOAN_KPIs
--Good_loan_application
SELECT COUNT(id) AS Good_loan_application FROM bank_loan_data
WHERE loan_status = 'Fully paid' OR loan_status = 'Current'

--Good_loan_funded_amount
SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully paid' OR loan_status = 'Current' 

--Good_loan_amount_recevied
SELECT SUM(total_payment) AS Good_loan_amount_recevied FROM bank_loan_data
WHERE loan_status = 'Fully paid' OR loan_status = 'Current' 

--Good_loan_persentage
SELECT ( COUNT ( CASE WHEN loan_status = 'Fully paid' OR loan_status = 'Current'
THEN id END ) * 100.0 ) / COUNT(id)  AS Good_loan_persentage 
FROM bank_loan_data




--BAD_LOAN_KPIs 
--Bad_loan_application
SELECT COUNT(id) AS Bad_loan_applicatin FROM bank_loan_data
WHERE loan_status = 'Charged off'

--Bad_loan_funded_amount
SELECT SUM(loan_amount) AS Bad_loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged off' 

--Bad_loan_amount_recevied
SELECT SUM(total_payment) AS Bad_loan_amount_recevied FROM bank_loan_data
WHERE loan_status = 'Charged off'

--Bad_loan_persentage
SELECT ( COUNT ( CASE WHEN loan_status = 'Charged off' THEN id END )
* 100.0 / COUNT(id) ) AS Bad_loan_persentage FROM bank_loan_data


--Loan_status

--SELECT 
--		loan_status,
--		COUNT(id) AS Total_loan_application ,
--		SUM(total_payment) AS Total_amount_recevied ,
--		SUM(loan_amount) AS Total_funded_amount,
--		AVG(int_rate * 100 ) AS Average_rate_of_intrest ,
--		AVG(dti * 100 ) AS Average_DTI 
--		FROM bank_loan_data
--		GROUP BY loan_status 

SELECT loan_status , 
		COUNT(id) AS Total_loan_application ,
		SUM(total_payment) AS Total_amount_recevied ,
		SUM(loan_amount) AS Total_funded_amount ,
		AVG(int_rate * 100) AS Average_rate_of_intrest ,
		AVG(dti * 100) AS Average_dti
		FROM bank_loan_data
		GROUP BY loan_status


--SELECT 
--	loan_status, 
--	SUM(total_payment) AS MTD_Total_Amount_Received, 
--	SUM(loan_amount) AS MTD_Total_Funded_Amount 
--FROM bank_loan_data
--WHERE MONTH(issue_date) = 12 
--GROUP BY loan_status


--SELECT loan_status ,
--		SUM(total_payment) AS MTD_Total_amount_recevied ,
--		SUM(loan_amount) AS MTD_Total_funded_amount
--		FROM bank_loan_data 
--		WHERE MONTH(issue_date) = 12
--		GROUP BY loan_status

SELECT loan_status ,
		SUM(total_payment) AS MTD_total_amount_recevied ,
		SUM(loan_amount) AS MTD_total_funded_amount 
		FROM bank_loan_data
		WHERE MONTH(issue_date) = 12 
		GROUP BY loan_status



--*****OVERVIEW_DASGBOARD******* 

--in_this_dashboard_we_analysing_Total_loan_application_on_the_basis_of_MONTH_STATE_TEARMS
--PORPOSE_EMPLOYEE_LENGHTH_HOME_OWERSHIP

--@1@MONTH
SELECT
		MONTH(issue_date) AS Month_Number ,
		DATENAME(MONTH , issue_date) AS Month_Name ,
		SUM(loan_amount) AS Total_Funded_Amount ,
		SUM(total_payment) AS Total_Amount_Recevied 
		FROM bank_loan_data 
		GROUP BY MONTH(issue_date) , DATENAME(MONTH , issue_date)
		ORDER BY MONTH(issue_date)

--@2@STATE
SELECT 
		address_state AS state ,
		COUNT(id) AS Total_Loan_Application ,
		SUM(loan_amount) AS Total_Funded_Amount ,
		SUM(total_payment) AS Total_Amount_Recevied 
		FROM bank_loan_data
		GROUP BY address_state
		ORDER BY address_state

--@3@TERM
SELECT 
		term AS Term ,
		COUNT(id) AS Total_Loan_Application ,
		SUM(loan_amount) AS Total_Funded_Amount ,
		SUM(total_payment) AS Total_Amount_Recevied 
		FROM bank_loan_data
		GROUP BY term
		ORDER BY term

--@4@EMPLOYEE_LENGTH
SELECT 
		emp_length AS Employee_Length ,
		COUNT(id) AS Total_Loan_Application ,
		SUM(loan_amount) AS Total_Funded_Amount ,
		SUM(total_payment) AS Total_Amount_Recevied 
		FROM bank_loan_data
		GROUP BY emp_length
		ORDER BY emp_length

--@5@PURPOSE
SELECT 
		purpose AS Purpose ,
		COUNT(id) AS Total_Loan_Application ,
		SUM(loan_amount) AS Total_Funded_Amount ,
		SUM(total_payment) AS Total_Amount_Recevied 
		FROM bank_loan_data
		GROUP BY purpose
		ORDER BY purpose

--@6@HOME_WONWERSHIP
SELECT 
		home_ownership AS Home_Ownership ,
		COUNT(id) AS Total_Loan_Application ,
		SUM(loan_amount) AS Total_Funded_Amount ,
		SUM(total_payment) AS Total_Amount_Recevied 
		FROM bank_loan_data
		GROUP BY home_ownership
		ORDER BY home_ownership