---
title: Property Model Parameter Fitting
author: Sakina Rehman
tags:
  - thermocalc
  - morton pc
  - python
toc: true
subcollection: TC Python
published: true

---
# Property Model Parameter Fitting

This example shows how to optimize the parameters of a Property Model. Typically that approach is used in order
to fit a Property Model to experimental data. That can be useful for any application where no analytical correlation
between the input parameters (composition, temperature and other parameters) and the material property can be established.
Examples might be solid solution strength models or martensite temperature models where the transformation barrier is 
modeled.

For the purpose of this example, the linear fitting to noisy data is shown.

A 'model parameter' is a value that can be changed from the outside of the model in the way demonstrated here.
Internally it can be represented in any way; the only requirement is that the Property Model implements the 'Python
Property Model Development Framework' interface methods :func:`provide_model_parameters` and :func:`set_model_parameter`.


```
from tc_python import *
import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize



dependent_element = "Fe"
composition = {"C": 0.1}  # in wt-%


def model(p, temps, calculator):
    """Representation of the Property Model, primarily to set the model parameters `a` and `b` during the solver
    iterations."""

    # replace the model parameters by the current trial
    (calculator
        .set_model_parameter("a", p[0])
        .set_model_parameter("b", p[1]))

    # looping over the complete 'experimental' dataset
    result = []
    for temp in temps:
        calculator.set_temperature(temp)
        this_result = calculator.calculate()
        result.append(this_result.get_value_of("result"))

    print("Intermediate fitting result: a = {}, b= {}".format(p[0], p[1]))
    return result


with TCPython() as session:
    system = (session
                .select_database_and_elements("FEDEMO", [dependent_element] + list(composition.keys()))
                .get_system())

    # the custom Property Model is not located in the default Property Model directory, but in the specified
    # subdirectory
    print("Available property models : {}".format(session.get_property_models("property_models")))
    calculator = (system
                  .with_property_model_calculation("Simple linear model", "property_models")
                  .set_composition_unit(CompositionUnit.MASS_PERCENT))

    for element in composition:
        calculator.set_composition(element, composition[element])

    print("Model parameters: {}".format(calculator.get_model_parameters()))
    print("Currently set value of model parameter a = {}".format(calculator.get_model_parameter_value("a")))
    print("Currently set value of model parameter b = {}".format(calculator.get_model_parameter_value("b")))

    # generate data points with noise
    num_points = 150
    temps_x = np.linspace(200, 1000, num_points)  # in K

    # parameter `a` is about 1000 and parameter `b` is about 0.5
    experiment_y = 1000 + 0.5 * temps_x + np.random.uniform(-1, 1, num_points) * 100

    # setup the initial guess of `a` and `b` and define the fitting functions
    fit_func = lambda p, x, calc: model(p, x, calc)            # target function
    err_func = lambda p, x, y: fit_func(p, x, calculator) - y  # distance to the target function
    params_0 = [100.0, 0.01]                                   # some initial guess for the parameters being far off

    # run the fitting
    opt_result = optimize.least_squares(err_func, params_0, args=(temps_x, experiment_y))  # type: dict
    params_opt = opt_result["x"]
    print("Best optimized parameters: a = {}, b = {}".format(params_opt[0], params_opt[1]))

    # plot of the data and the fit
    fig, ax = plt.subplots()
    fig.suptitle('Fitting of linear Property Model', fontsize=14, fontweight='bold')
    ax.plot(temps_x, experiment_y, "ro", temps_x, fit_func(params_opt, temps_x, calculator), "r-")
    ax.set_xlabel("temperature / K")
    ax.set_ylabel("'experimental' property")
    plt.show()

```
![alt text](https://github.com/LightForm-group/wiki/blob/master/collections/_software_and_simulation/param_fit.png)
