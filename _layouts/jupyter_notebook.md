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

{{
   "This is a static version of a Jupyter notebook. Click to interact with the notebook: [![Binder](https://mybinder.org/badge_logo.svg)](" | append: binder_url | append: ")" | markdownify
}}

{{ content }}

