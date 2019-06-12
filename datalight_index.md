---
layout: default
title: Datalight index
page_width: wide
show_breadcrumbs: false
show_meta: false
---

{% for exp in site.experiments -%}
  {% assign exp_title = exp.title | replace: " ", "-" | downcase | replace: "(", "_" | replace: ")", "_" -%}
  {% if exp_title != "experiments" -%}
    <pre>https://raw.githubusercontent.com/LightForm-group/wiki/master/_includes/checklists/{{ exp_title -}}.yml</pre>
  {% endif %}
{% endfor %}