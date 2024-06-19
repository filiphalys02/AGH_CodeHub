import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import geopandas as gpd
import libpysal as ps
import pointpats as pp

import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

def g_function_poisson(d, intensity):
    zakres=len(d)
    GD=np.array([])
    for i in range(zakres):
        gd=1-np.exp(-intensity*np.pi*(d[i]**2))
        GD=np.append(GD, gd)
    XY={"D":d, "G":GD}
    g=pd.DataFrame(data=XY)
    return(g)

def f_function_poisson(d, intensity):
    zakres=len(d)
    FD=np.array([])
    for i in range(zakres):
        fd=1-np.exp(-intensity*np.pi*(d[i]**2))
        FD=np.append(FD, fd)
    XY={"D":d, "F":FD}
    g=pd.DataFrame(data=XY)
    return(g)
