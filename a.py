from pyspark import SparkContext
from pip._internal import main       
sc = SparkContext()     

main(['install', 'requests'])        
                                               
import requests
               
url = "http://192.168.41.247:2611/dependencies.zip"
response = requests.get(url, stream=True)                                   
                                         
with open("dep.zip", "wb") as handle:
  for chunk in response.iter_content():
        handle.write(chunk)            
sc.addPyFile("dep.zip")    
import dep.zip         
import pandas as pd
import numpy as np 
print("finally")  
                