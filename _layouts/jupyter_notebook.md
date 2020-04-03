---
layout: post
---



{% assign notebook_dir = page.path | split: "/" %}
{% assign notebook_dir = notebook_dir[-1] | split: ".md" %}
{% assign notebook_dir = site.jupyter_notebooks_dir | append: "/" | append: notebook_dir[0] %}
{% assign binder_notebook_dir = notebook_dir | replace: "/", "%2F" %}

{% assign binder_url = "https://mybinder.org/v2/gh/" | append: site.github_user_or_organisation %}
{% assign binder_url = binder_url | append: site.baseurl | append: "/" | append: site.jupyter_notebooks_branch | append: "?filepath=" %}
{% assign binder_url = binder_url | append: binder_notebook_dir %}

Page path: {{ page.path | split: ", " }}<br/>
Notebook dir: {{ notebook_dir }}<br/>
Binder notebook dir: {{ binder_notebook_dir }}<br/>
Binder URL: {{ binder_url }}<br/>


{{
   ">Note: this page has been generated from a Jupyter notebook. View the notebooks on GitHub [here](https://github.com/LightForm-group/wiki)." | markdownify
}}

{{ content }}


<!-- https://mybinder.org/v2/gh/LightForm-group/wiki/jupyter-notebooks?filepath=_includes%2Fjupyter_notebooks%2Fmatrix_multiplication.ipynb -->
