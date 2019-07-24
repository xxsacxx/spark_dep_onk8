from pyspark import SparkContext
import pip
sc = SparkContext()
if hasattr(pip, 'main'):

    pip.main(['install', 'requests'])
else:
    pip._internal.main(['install', 'requests'])

import requests

url = "https://www.python.org/ftp/python/3.7.3/python-3.7.3-embed-win32.zip"
response = requests.get(url, stream=True)

with open("dep.zip", "wb") as handle:
  for chunk in response.iter_content():
  	handle.write(chunk)
sc.addPyFile("dep.zip")
import dep.zip
import pandas as pd
import numpy as np
print("finally")
