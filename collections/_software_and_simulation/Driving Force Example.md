---
title: Driving Force (Gibbs Energy Fit) Example
author: Sakina Rehman
tags:
  - thermocalc
  - morton pc
  - python
toc: true
subcollection: TC Python
published: true
---
# Driving Force Example

Using TC-Python, the Gibbs energy for a specific phase can be calculated for a multivariate system to help calculate driving forces.

Please check the below modules are installed and available on your PC. These are all installed on the Morton PC, it is recommended you use the Morton PC and use the PyCharm IDE.

```from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
import numpy as np
from tc_python import *
import pandas as pd
```
To ensure/check which phases are present in the system, the following function can be utilised. This is useful when the Gibbs energy of a specific phase is required.
```
def list_stable_phases(result):
​
    stable_phases = result.get_stable_phases()
    print(stable_phases)
```
This function below provides a 3D plot of the Gibbs energy as a function of two independent variables. In this case, a ternary Al-Cr-Ni system is considered where the Gibbs energy is calculated for changing solute concentration of Al and Cr.
```
def plot_3d(list_of_x, list_of_y, list_of_z, xlabel, ylabel, zlabel, title):
​
    #Plot a 3d figure using matplotlib given data and labels on the three axes.
​
    fig = plt.figure()
    fig.suptitle(title, fontsize=14, fontweight='bold')
    ax = plt.subplot(projection='3d')
    z = np.empty([len(list_of_x), len(list_of_y)])
    k = 0
    for index_x, x in enumerate(list_of_x):
        for index_y, y in enumerate(list_of_y):
            z[index_x, index_y] = list_of_z[k]
            k = k + 1
​
    xx, yy = np.meshgrid(list_of_x, list_of_y, indexing='ij')
    ax.plot_surface(xx, yy, z, cmap=cm.coolwarm, linewidth=1, antialiased=True)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_zlabel(zlabel)
    for spine in ax.spines.values():
        spine.set_visible(False)
​
    plt.show()
​
​
```
This is the main script, which is a single equilibrium calculation using the NIDEMO database. 
>Please note that there are many databases available for Ni, Al, Ti based alloys. To check please open Thermo-Calc 2022a GUI and check the available databases.

The temperature has been fixed at 973.15 K and ```ALL_PHASES``` have been set to dormant, except the ```FCC_L12#2``` phase. This is the phase of interest (the ordered precipitate phase in this system). Please refer to the database manual/documentation for phase naming information for your system.
```
with TCPython() as start:
    # single equilibrium calculation
    calculation = (
        start
            .set_cache_folder(os.path.basename(__file__) + "_cache")
            .select_database_and_elements("NIDEMO", ["Ni", "Al", "Cr"])
            .get_system()
            .with_single_equilibrium_calculation()
            .set_condition(ThermodynamicQuantity.temperature(), 973.15)
            .set_phase_to_dormant(ALL_PHASES)
            .set_phase_to_entered('FCC_L12#2',1.0)
            .disable_global_minimization()
    )
```
A range of solute mole fractions are considered, please do not set the minimum as zero but instead a very small number.
```
    list_of_x_Al = np.linspace(1e-4, 15e-2, 10)
    list_of_x_Cr = np.linspace(1e-4, 30e-2, 10)
​
    list_of_gibbs_gp = []
    x_Als = []
    x_Crs = []
​
    for x_Al in list_of_x_Al:
        for x_Cr in list_of_x_Cr:
            calc_result = (calculation
                           .set_condition(ThermodynamicQuantity.mole_fraction_of_a_component("Al"), x_Al)
                           .set_condition(ThermodynamicQuantity.mole_fraction_of_a_component("Cr"), x_Cr)
                           .calculate()
                           )
​
```
This section focuses on retrieving the Gibbs energy of the given phase for the range of solute concentrations. The results are printed to the terminal and a 3D plot is provided.
```
            gibbs_gp = calc_result.get_value_of('G')
            list_of_gibbs_gp.append(gibbs_gp)
            x_Als.append(x_Al)
            x_Crs.append(x_Cr)
​
            print("X(Al)={0:.2f}".format(x_Al) + " , X(Cr)={0:.2f}".format(x_Cr) + ", Gibbs = {0:.2f}".format(
                gibbs_gp) + "[kJ/mol]")
​
    list_stable_phases(calc_result)
    plot_3d(list_of_x_Al, list_of_x_Cr, list_of_gibbs_gp, 'X(Al)', 'X(Cr)', 'Gibbs Energy [kJ/mol]',
            "Gibbs Energy for Ni-Al-Cr alloy at 973.15K")
​
```
This saves the data as a .csv value, which can be used in further post-processing, especially when obtaining the multivariate polynomial fits.
```
    data_Gp = [x_Als, x_Crs,list_of_gibbs_gp ]
    data_Gp = pd.DataFrame(data_Gp)
    data_Gp = data_Gp.T
    #data_Gp.columns = ['x_al', 'x_cr','G_gp']
    data_Gp.to_csv('data_Gp.csv', index=False)
```

