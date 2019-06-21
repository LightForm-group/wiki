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

{% assign exp_title_clean = page.title | replace: " ", "-" | downcase | replace: "(", "_" | replace: ")", "_" -%}

{{ "## Metadata template" | markdownify }}
{% for cl in checklists -%}
  {% if cl == exp_title_clean -%} 
    {% assign checklist_exists = true -%}
    {% assign cl_edit_url = github_cl_edit_url | append: exp_title_clean | append: ".yml" -%}
    {% assign cl_history_url = github_cl_history_url | append: exp_title_clean | append: ".yml" -%}
    <a href="{{ cl_edit_url }}" class="checklist-action edit-checklist">edit</a> | <a href="{{ cl_history_url }}" class="checklist-action checklist-history">history</a>
    {% capture my_include %}{% include checklist.md checklist=exp_title_clean %}{% endcapture %}
    {{ my_include | markdownify }}
  {% endif -%}
{% endfor %}

{% if checklist_exists != true -%}
  {% assign cl_add_redirect_url = "add_metadata_file#" | append: exp_title_clean | prepend: "/" | prepend: site.baseurl | prepend: site.url -%}
  <a href="{{ cl_add_redirect_url }}" class="checklist-action add-checklist">add</a>
{% endif -%}
