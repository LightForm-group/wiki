---
title: TTT and CCT Curves of Ni-Al-Cr System
author: Sakina Rehman
tags:
  - thermocalc
  - morton pc
  - python
toc: true
subcollection: TC Python
published: true
---
# TTT and CCT Curves of Ni-Al-Cr System

This example simulates the precipitation of gamma-prime phase from gamma phase in a Ni-Al-Cr alloy. It demonstrates how to run TTT(temperature-time-transformation) and CCT(continuous-cooling-transformation) diagrams.
It also shows 
(1) how to set up objects(the system, precipitate phase, and matrix phase) and then reuse them, and (2) how to set an alias for the precipitate phase
```
from tc_python import *
import matplotlib.pyplot as plt

with TCPython():
    system = (SetUp()
              .set_cache_folder(os.path.basename(__file__) + "_cache")
              .select_thermodynamic_and_kinetic_databases_with_elements("NIDEMO", "MNIDEMO", ["Ni", "Al", "Cr"])
              .select_phase("DIS_FCC_A1")
              .select_phase("FCC_L12#2")
              .get_system()
              )

    precip = PrecipitatePhase("FCC_L12#2").set_interfacial_energy(0.023).set_alias('GAMMA_PRIME')
    matrix = MatrixPhase("DIS_FCC_A1").add_precipitate_phase(precip)

    ttt_results = (system.with_ttt_precipitation_calculation()
                   .set_composition_unit(CompositionUnit.MOLE_PERCENT)
                   .set_composition("Al", 10)
                   .set_composition("Cr", 10)
                   .with_matrix_phase(matrix)
                   .set_min_temperature(1000)
                   .set_max_temperature(1160)
                   .set_temperature_step(10)
                   .set_max_annealing_time(1.0e6)
                   .stop_at_volume_fraction_of_phase(1.e-4)
                   .calculate()
                   )

    cct_results = (system.with_cct_precipitation_calculation()
                   .set_composition_unit(CompositionUnit.MOLE_PERCENT)
                   .set_composition("Al", 10)
                   .set_composition("Cr", 10)
                   .with_matrix_phase(matrix)
                   .set_min_temperature(1000)
                   .set_max_temperature(1200)
                   .set_cooling_rates([1., 1.e1, 1.e2, 1.e3])
                   .stop_at_volume_fraction_of_phase(1.e-4)
                   .calculate()
                   )

    time_1, temperature_1 = ttt_results.get_result_for_precipitate("GAMMA_PRIME")
    time_2, temperature_2 = cct_results.get_result_for_precipitate("GAMMA_PRIME")

# Plot result
fig, ax = plt.subplots()
fig.suptitle('TTT and CCT', fontsize=14, fontweight='bold')
ax.set_xlabel('Time [s]')
ax.set_ylabel('Temperature [K]')
ax.semilogx(time_1, temperature_1, 'b-', label="GAMMA_PRIME (TTT)")
ax.semilogx(time_2, temperature_2, 'r--', label="GAMMA_PRIME (CCT)")
ax.legend()
plt.show()


```
![alt text](https://github.com/LightForm-group/wiki/blob/master/collections/_software_and_simulation/ttt_cct.png)
