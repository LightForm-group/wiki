---
title: Fraction of a Phase
author: Sakina Rehman
tags:
  - thermocalc
  - morton pc
  - python
toc: true
subcollection: TC Python
published: true
---
# Fraction of a Phase

This example prints the composition of a phase in a single equilibrium calculation for a Fe-based alloy (Fe-Cr-C). The mass fraction for both Cr and C have been set (please note, TC-Python automatically calculates the mass fraction of Fe) and the temperature has been fixed. For the phase ```FCC_A1``` the composition as a weight fraction is outputted from this script

```
from tc_python import *

with TCPython() as session:
    # create equilibrium calculation object and set conditions
    eq_calculation = (
        session.
            set_cache_folder(os.path.basename(__file__) + "_cache").
            select_database_and_elements("FEDEMO", ["Fe", "Cr", "C"]).
            get_system().
            with_single_equilibrium_calculation().
            set_condition(ThermodynamicQuantity.temperature(), 1300.0).
            set_condition(ThermodynamicQuantity.mass_fraction_of_a_component("Cr"), 0.1).
            set_condition(ThermodynamicQuantity.mass_fraction_of_a_component("C"), 0.01)

    )

    calc_result = eq_calculation.calculate()

    compo_phase = calc_result.get_value_of(ThermodynamicQuantity.
                                           composition_of_phase_as_weight_fraction('FCC_A1', 'Cr'))
print(compo_phase)

```
