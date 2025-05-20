CALL LoadDIM_Store();
CALL LoadDIM_Customer();
CALL LoadDIM_Category();
CALL LoadDIM_Publisher();
CALL LoadDIM_Product();
CALL LoadDIM_Employee(); 
CALL LoadDIM_Date();
CALL LoadFCT_Sales();

SELECT * FROM FCT_Sales