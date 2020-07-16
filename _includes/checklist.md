{% assign checklist_fn = include.checklist | append: ".yml" %}
{% for i in site.static_files %}
  {% assign inc_url_split = i.path | split: "/_includes/data/" %}
  {% assign inc_url = inc_url_split[1] %}
  {% assign inc_dir_split = inc_url | split: "/" %}
  {% assign inc_dir = inc_dir_split[0] -%}
  {% if inc_dir == "checklists" %}
    {% if i.name == checklist_fn %}
      {% assign inc_url_path = "data/" | append: inc_url %}
```yaml
{% include {{ inc_url_path }} %}
```
    {% endif %}
  {% endif %}
{% endfor %}
