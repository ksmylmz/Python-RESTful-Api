from minilib import db 
from datetime import datetime
import mysql.connector
import json


class model(db):
        
    def login(self,data):
        username  = data["username"]
        key  = data["userkey"]
        qry = "select count(1) from user where username= %s and userkey= %s ";
        params = (username,key)
        result  =  self.getItem(qry,params)
        if len(result)>0:
            try:
                token = self.getItem("select generateToken(%s,%s)",params)
                return token
            except mysql.connector.errors.ProgrammingError:
                return "Something goes wrong"
        else:
            "Authentication falied, check credentials"
            
    def getRecord(self,data):
        token = data["token"]
        product_code = data["product_code"]
        username  = self.checkToken(token)
        if username==False:
            return {'result':"Invalid Token"}
        qry = "Select * from product where username=%s and product_code=%s "
        params=(username,product_code)
        try:           
            result = self.getlist(qry,params)
            if len(result)>0:
                items = []
                for i in result:
                    items.append({'product_code':i[2],'product_desc':i[3],'price':i[4],'stock':i[5]})
                return items
                    

            else:
                return {'result':"this product not found"}     
        except mysql.connector.errors.ProgrammingError as error:
            print(error)
            return {'result':"Something goes wrong"}
        
    
    
    def insert(self,data):
        token = data["token"]
        product_code = data["product_code"]
        product_desc = data["product_desc"]
        price = data["price"]
        stock = data["stock"]
        
        username  = self.checkToken(token)
        if username==False:
            return {'result':"Invalid Token"}
        qry = "insert into product (username,product_code,product_desc,price,stock) values (%s,%s,%s,%s,%s)"
        params = (username,product_code,product_desc,price,stock)
        result= self.gosql(qry,params)
        if result:
            self.log(username,"insert",json.dumps(data),"Insert Proccess success")
            return {'result':"Insert Proccess success"}
        else:
            self.log(username,"insert",json.dumps(data),"insert proccess failed")
            return {'result':"Something goes wrong, insert proccess failed"}
        
    def update(self,data):
        token = data["token"]
        product_code = data["product_code"]
        product_desc = data["product_desc"]
        price = data["price"]
        stock = data["stock"]
        
        
        username  = self.checkToken(token)
        if username==False:
            return {'result':"Invalid Token"}
        
        qry = "update product set  product_desc=%s,price=%s,stock =%s where product_code=%s and username=%s"
        params = (product_desc,price,stock,product_code,username)
        result= self.gosql(qry,params)
        if result:
            self.log(username,"update",json.dumps(data),"Update Proccess success")
            return {'result':"Update Proccess success"}
        else:
            self.log(username,"update",json.dumps(data),"Update proccess failed")
            return {'result':"Something goes wrong, update proccess failed"}  
        
    
        
    def delete(self,data):
        token = data["token"]
        product_code = data["product_code"]
        
        
        username  = self.checkToken(token)
        if username==False:
            return {'result':"Invalid Token"}
        
        qry = "delete from product where product_code=%s and username=%s"
        params = (product_code,username)
        result= self.gosql(qry,params)
        if result:
            self.log(username,"update",json.dumps(data),"Delete Proccess success")
            return {'result':"Delete Proccess success"}
        else:
            self.log(username,"delete",json.dumps(data),"Delete proccess failed")
            return {'result':"Something goes wrong, delete proccess failed"}      
        

    def checkToken(self,token):
        qry = "select username from user where token=%s and  validtime>=now()";
        params = (token,)
        result  =  self.getItem(qry,params)
        
        
        if result!=None:
            try:
                return result
            except mysql.connector.errors.ProgrammingError:
                return False
        else:
            return False
        
        
            
        
    
