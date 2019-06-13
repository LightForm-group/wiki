---
{% comment %} 
  # This page provides links to the experiment metadata files in the "/_includes/checklists" folder so DataLight can read them.
{% endcomment %} 

{% for exp in site.experiments -%}
  {% assign exp_title = exp.title | replace: " ", "-" | downcase | replace: "(", "_" | replace: ")", "_" -%}
  {% assign filename = exp.url | split: "/" -%}
  {% if filename[-1] != "index" -%}
    <pre>https://raw.githubusercontent.com/LightForm-group/wiki/master/_includes/checklists/{{ exp_title -}}.yml</pre>
  {% endif %}
{% endfor %}