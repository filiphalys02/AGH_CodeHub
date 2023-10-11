import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import geopandas as gpd

def homogeneous_poisson_on_rectangle(intensity, x_lim, y_lim):
    pole = (x_lim[1] - x_lim[0]) * (y_lim[1] - y_lim[0])
    lambda0 = intensity * pole
    print(lambda0)
    n = np.random.poisson(lambda0, 1)
    x = np.random.uniform(x_lim[0], x_lim[1], n)
    y = np.random.uniform(y_lim[0], y_lim[1], n)
    XY = {"X" : x, "Y" : y}
    points = pd.DataFrame(data = XY)
    return(points)
