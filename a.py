from pyspark import SparkContext
sc = SparkContext()
sc.addPyFile("dependencies.zip")
import dependencies
import pandas as pd
import numpy as np
print("finally")
