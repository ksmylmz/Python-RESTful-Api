# Python-RESTful-Api



- 	The purpose of this repo is to give an idea about rest api at a basic level. 
- 	The following libraries were used for the application
          Flask, mysql.connector


 You should getting a token, from login method for connection any method.  Each token is valid for 1 hour
 For generating token, you should be add like that function to your database
 
 		CREATE DEFINER=`root`@`localhost` FUNCTION `generateToken`(_username 				varchar(45),_userkey varchar(45)) RETURNS varchar(45) CHARSET latin1
		BEGIN
	SET SQL_SAFE_UPDATES=0;
    UPDATE user 
	SET 
		token = (select SHA1((SELECT CONCAT(_username, NOW(), 'asdzxcxf'))) _token) ,
		validtime = (select (NOW() + INTERVAL 60 MINUTE) _validtime)
	WHERE
		username = _username
			AND userkey = _userkey;
	SET SQL_SAFE_UPDATES=1;
		RETURN (select token from user where username=_username and userkey=_userkey);
		END

endpoinds and simple of  json request raws like below 

base url  = http://127.0.0.1:5000
for activation the 5000 post listener, run the app.py file 

/login    
Method = POST

		{"username":"python","userkey":"asdzxcxf"}



/getrecord    
Method = POST

		{
		"token":"9d0a080b6cdc9dee8a888fc123d18b89d81909c5",
		"product_code":"abcde"
		}




/login    
Method = POST

		{"username":"python","userkey":"asdzxcxf"}



/insert    
Method = POST

		{
		"token":"92603740e66367aa211aa4d1032b0b17b3103ea8",
		"product_code":"ffff",
		"product_desc":"bla bla bla",
		"price":10,
		"stock":3
		}





/update    
Method = PATCH

		{
		"token":"92603740e66367aa211aa4d1032b0b17b3103ea8",
		"product_code":"cccc",
		"product_desc":"bla bla bla",
		"price":40,
		"stock":10
		}


/delete
Method = DELETE

		{
		"token":"92603740e66367aa211aa4d1032b0b17b3103ea8",
		"product_code":"xxxxx"
		}




