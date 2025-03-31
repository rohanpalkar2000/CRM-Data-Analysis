CREATE DATABASE CRM;
USE CRM;

####################### Oppertunity Queries ################################

# Expected Amount
SELECT CONCAT('$', FORMAT(SUM(Expected_Amount) / 1000000, 2), 'M') AS Total_Expected_Amount
FROM oppertunity_table;


# Active Opportunities
SELECT COUNT(Active) AS Active_Opportunities
FROM user_table;

# Total Oppertunities
SELECT COUNT(opportunity_ID) AS Total_Opportunities
FROM oppertunity_table;

# Conversion rate
SELECT 
    CONCAT(ROUND((COUNT(CASE WHEN Stage = 'Closed Won' THEN 1 END) * 100.0) / COUNT(*), 2), '%') AS Conversion_Rate
FROM oppertunity_table;


# Win rate
SELECT 
    CONCAT(ROUND((COUNT(CASE WHEN Stage = 'Closed Won' THEN 1 END) * 100.0) / COUNT(*),2), '%') AS Win_Rate
FROM oppertunity_table;

# Loss rate
SELECT 
    CONCAT(ROUND((COUNT(CASE WHEN Stage = 'Closed Lost' THEN 1 END) * 100.0) / COUNT(*),2), '%') AS Loss_Rate
FROM oppertunity_table;

# Expected Amount by Opportunity Type
SELECT 
    Opportunity_Type, 
    CONCAT('$', FORMAT(SUM(Expected_Amount) / 1000000, 2), 'M') AS Total_Expected_Amount
FROM oppertunity_table
GROUP BY Opportunity_Type;


# Opportunities by Industry
SELECT A.Industry, COUNT(O.Opportunity_ID) AS Total_Opportunities
FROM Oppertunity_table O
JOIN Account A ON O.Account_ID = A.Account_ID
GROUP BY A.Industry
ORDER BY Total_Opportunities DESC
LIMIT 10;









########################### Lead Queries #########################################

# Total leads
SELECT COUNT(Total_leads) AS Total_Leads FROM leads;


# Expected Amount from Converted Leads
SELECT 
    CONCAT('$', FORMAT(SUM(O.Expected_Amount) / 1000000, 2), 'M') AS Total_Expected_Amount_from_Converted_Leads
FROM leads L
JOIN oppertunity_table O 
    ON L.Converted_Opportunity_ID = O.Opportunity_ID
WHERE L.Converted = 'True';



# Conversion Rate (%)
SELECT 
    CONCAT(ROUND((COUNT(CASE WHEN Converted = 'True' THEN 1 END) * 100.0 / COUNT(*)), 2), '%'
    ) AS Conversion_Rate 
FROM leads;


# Converted Accounts
SELECT COUNT(Converted_Account_ID) AS Converted_Accounts 
FROM leads
WHERE Converted = 'True';


# Converted Opportunities
SELECT count(Converted_Opportunities) AS Count_of_Converted_Opportunities 
FROM leads 
WHERE Converted = 'True';


# Leads by Source
SELECT Lead_Source, COUNT(*) AS Lead_Count 
FROM leads 
GROUP BY Lead_Source 
ORDER BY Lead_Count DESC
LIMIT 10;


# Leads by Industry
SELECT Industry, COUNT(*) AS Lead_Count 
FROM leads 
GROUP BY Industry 
ORDER BY Lead_Count DESC
LIMIT 10;


# Leads by Status
SELECT Status, COUNT(*) AS Lead_Count 
FROM leads 
GROUP BY Status 
ORDER BY Lead_Count DESC;

# Leads by Stage
SELECT Stage, COUNT(*) AS Lead_Count 
FROM oppertunity_table 
GROUP BY Stage 
ORDER BY Lead_Count DESC;

# Market segment by Converted oppertunity
SELECT 
    Marketing_Segmentation, 
    COUNT("Converted_Opportunity_ID") AS Converted_Opportunities
FROM leads
WHERE Converted = 'True'
GROUP BY Marketing_Segmentation
ORDER BY Converted_Opportunities DESC;

