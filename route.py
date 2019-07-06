from flask import Flask,render_template,request,redirect,url_for,Response
import json
from model import model

class route():
    md = None
    app  =Flask(__name__)
    def __init__(self):
        
        md  = model()      
                
        @self.app.route("/")
        def index():
            result = {'result':"Unauthorized access attempt"}
            return Response(json.dumps(result), mimetype='application/js')
        
        @self.app.route("/getrecord", methods=["POST"])
        def get():
            data  = self.jsonDecode(request.data.decode("utf-8"))
            result  = md.getRecord(data)
            return Response(json.dumps(result), mimetype='application/js')
        
        
        @self.app.route("/insert", methods=["POST"])
        def postrecords():
            data  = self.jsonDecode(request.data.decode("utf-8"))
            result  = md.insert(data)
            return Response(json.dumps(result), mimetype='application/js')

        
        
        @self.app.route("/update", methods=["PATCH"])
        def patch():
            data  = self.jsonDecode(request.data.decode("utf-8"))
            result  = md.update(data)
            return Response(json.dumps(result), mimetype='application/js')
        
        
        @self.app.route("/delete",methods=["DELETE"])
        def delete():
            data  = self.jsonDecode(request.data.decode("utf-8"))
            result  = md.delete(data)
            return Response(json.dumps(result), mimetype='application/js')
            
        
        @self.app.route("/login", methods=["POST"])
        def login():
            data  = self.jsonDecode(request.data.decode("utf-8"))
            result  = md.login(data)
            return Response('{"result":"'+result+'"}', mimetype='application/json')
        

        
        
    def jsonDecode(self,_json):
        parsed  =json.loads(_json)
        return parsed