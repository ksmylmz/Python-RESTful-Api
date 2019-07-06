import mysql.connector


mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="",
  database = "webservice"
)
mycursor = mydb.cursor(prepared=True)

"""        sql = "select * from user where id= %s "
        val = (1,)"""

class db:
    mycursor = mydb.cursor(prepared=True)
    
    def getlist(self,sql,params):
        list = []
        row =[]
        mycursor.execute(sql, params)
        result = mycursor.fetchall()

        for x in result:
            for y in x:
                row.append(self.decode(y))
            list.append(row) 
            row = []
        return list
    
    def getItem(self,sql,params):
        mycursor.execute(sql,params);
        result = mycursor.fetchone()
        if result is not None:
            return self.decode(result[0])
        else:
            return False
    
    def gosql(self,sql,params):
        try:
            mycursor.execute(sql,params);
            mydb.commit()
            return True
        except mysql.connector.ProgrammingError as error:
            return False

      
        
        
    def log(self,username,function,requestdata,responsedata):       
        qry = "insert into log (username,function,requestdata,responsedata,timestamp) values (%s,%s,%s,%s,now())"
        params=(username,function,requestdata,responsedata)
        result = self.gosql(qry, params)
        if result:
            print("logged")
        else:
            print("log fail")
        
    
    def decode(self,item):
        if type(item) is bytearray:
            return item.decode("utf-8")
        else:
            return item
        
        
    
    

