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

{{ "## Metadata template" | markdownify }}
{% assign exp_title_clean = page.title | replace: " ", "-" | downcase | replace: "(", "_" | replace: ")", "_" -%}
{% include checklist_controls.html exp_title_clean=exp_title_clean %}
{% include get_checklist_formatted.html exp_title_clean=exp_title_clean %}
