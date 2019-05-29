---
layout: post
---
<br/>
<table class="vertical-header smaller">
  <tr>
      <th>Champion</th>
      <td>{{ page.author }}</td>
  </tr>
  <tr>
      <th>Analysis code</th>
      <td>
      {% if page.analysis_code %}
        <a href="{{ page.analysis_code }}">Link</a>
      {% else %}
      -
      {% endif %}            
      </td>
  </tr>
</table>
<br/>

{{ content }}

{% include get_checklists.html %}
{% include prose_checklist_urls.html %}

{% assign checklist_name = page.title | replace: " ", "-" | downcase -%}
{% assign exp_title_clean = page.title | replace: " ", "-" | downcase | replace: "(", "_" | replace: ")", "_" -%}

{{ "## Metadata template" | markdownify }}
{% for cl in checklists -%}
{% if cl == checklist_name -%} 
  {% assign checklist_exists = true -%}
  {% assign cl_edit_url = prose_cl_edit_url | append: exp_title_clean | append: ".yml" -%}
  {% assign cl_history_url = github_cl_history_url | append: exp_title_clean | append: ".yml" -%}
  <a href="{{ cl_edit_url }}" class="checklist-action edit-checklist">edit</a> | <a href="{{ cl_history_url }}" class="checklist-action checklist-history">history</a>
  {% capture my_include %}{% include checklist.md checklist=checklist_name %}{% endcapture %}
  {{ my_include | markdownify }}
{% endif -%}
{% endfor %}

{% if checklist_exists != true -%}
  {% assign prose_cl_new_url = prose_cl_new_url | append: exp_title_clean | append: ".yml" -%}
  <a href="{{ prose_cl_new_url }}" class="checklist-action add-checklist">add</a>
{% endif -%}
