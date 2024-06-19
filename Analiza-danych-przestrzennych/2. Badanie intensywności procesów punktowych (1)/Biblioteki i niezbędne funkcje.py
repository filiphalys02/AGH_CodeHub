import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import math as m

sns.set() 
sns.set_theme(style="whitegrid")

def homogeneous_poisson_on_rectangle(intensity, x_lim, y_lim):
    area = (x_lim[1]-x_lim[0])*(y_lim[1]-y_lim[0])
    n = area*intensity
    number = np.random.poisson(n)
    x = np.random.uniform(low = x_lim[0], high = x_lim[1], size = number)
    y = np.random.uniform(low = y_lim[0], high = y_lim[1], size = number)
    
    points = pd.DataFrame()
    points['X'] = x
    points['Y'] = y
    return points
    
def unhomogeneous_poisson_on_rectangle(intensity_function, x_lim, y_lim):
    def g(x):
        return -funkcja(x[0], x[1])
    intensity=-sp.optimize.minimize(g, x0=[(x_lim[0]+x_lim[1])/2, (y_lim[0]+y_lim[1])/2], bounds=[x_lim, y_lim]).fun
    poisson = homogeneous_poisson_on_rectangle(intensity, x_lim, y_lim)
    dlugosc = len(poisson)
    
    for i in range(dlugosc):
        prawdopodobienstwo = 1 - (funkcja(poisson['X'][i], poisson['Y'][i])/intensity)
        if prawdopodobienstwo > np.random.uniform(0,1):
            poisson = poisson.drop(i)
    return poisson

def materna_on_rectangle(parent_intensity, daughter_intensity, cluster_radius, x_lim, y_lim):
    x_lim_2 = [x_lim[0] - cluster_radius, x_lim[1] + cluster_radius]
    y_lim_2 = [y_lim[0] - cluster_radius, y_lim[1] + cluster_radius]
    punkty_parent = homogeneous_poisson_on_rectangle(parent_intensity, x_lim_2, y_lim_2)
    x = punkty_parent['X']
    y = punkty_parent['Y']
    koncowe_x = np.array([])
    koncowe_y = np.array([])
    
    for i in range(len(punkty_parent)):
        daughter_poisson = homogeneous_poisson_on_rectangle(daughter_intensity, [x[i]-cluster_radius, x[i]+cluster_radius], [y[i]-cluster_radius, y[i]+cluster_radius])
        punkty_X_daughter = daughter_poisson['X']
        punkty_Y_daughter = daughter_poisson['Y']
    
        for j in range(len(daughter_poisson)):
            if ((punkty_X_daughter[j]-x[i])**2 + (punkty_Y_daughter[j]-y[i])**2) > cluster_radius**2:
                punkty_Y_daughter = punkty_Y_daughter.drop(j)
                punkty_X_daughter = punkty_X_daughter.drop(j)
        koncowe_x = np.append(koncowe_x, punkty_X_daughter)
        koncowe_y = np.append(koncowe_y, punkty_Y_daughter)
    XY = {'X' : koncowe_x, 'Y' : koncowe_y}
    punkty = pd.DataFrame(data = XY)
    return punkty

def thomas_on_rectangle(parent_intensity, mean_cluster_size, cluster_sigma, x_lim, y_lim):
    x_lim_2 = [0,0]
    y_lim_2 = [0,0]
    x_lim_2[0] = x_lim[0]-4*cluster_sigma
    x_lim_2[1] = x_lim[1]+4*cluster_sigma
    y_lim_2[0] = y_lim[0]-4*cluster_sigma
    y_lim_2[1] = y_lim[1]+4*cluster_sigma
    punkty_poisson = homogeneous_poisson_on_rectangle(parent_intensity, x_lim_2, y_lim_2)
    
    koncowe_x = np.array([])
    koncowe_y = np.array([])
    
    for i in range(len(punkty_poisson)):
        randomowa_liczba_poissona = np.random.poisson(mean_cluster_size)
        losowy_x = np.random.normal(punkty_poisson['X'][i], cluster_sigma, randomowa_liczba_poissona)
        losowy_y = np.random.normal(punkty_poisson['Y'][i], cluster_sigma, randomowa_liczba_poissona)
        koncowe_x = np.append(koncowe_x, losowy_x)
        koncowe_y = np.append(koncowe_y, losowy_y)
    XY = {'X' : koncowe_x, 'Y': koncowe_y}
    punkty = pd.DataFrame(data = XY)
    for i in range(len(punkty)):
        if punkty['X'][i] < x_lim[0] or punkty['X'][i] > x_lim[1] or punkty['Y'][i] < y_lim[0] or punkty['Y'][i] > y_lim[1]:
            punkty.drop(i)
    return punkty
  
poisson = homogeneous_poisson_on_rectangle(20, [-10,10], [-5,5])
poisson 

def funkcja(x,y):
    return 10*(m.cos((m.pi/4)*x)+1)
poisson_nieregularny = unhomogeneous_poisson_on_rectangle(funkcja, [-10,10], [-5,5])
poisson_nieregularny

materna = materna_on_rectangle(0.15, 15, 1.25, [-10,10], [-5,5])
materna

thomas = thomas_on_rectangle(0.3, 20, 0.75, [-10,10], [-5,5])
thomas 
