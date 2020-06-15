---
layout: post
---

{% assign filename = page.url | split: "/" -%} 
{% assign tut_link = "-" -%}
{% for tut in site.tutorials -%}
    {% assign tut_filename = tut.url | split: "/" -%}
    {% if tut_filename[-1] == filename[-1] -%}
        {% assign page_href = tut.url | prepend: site.baseurl %}
        {% assign tut_link = '<a href="' | append: page_href | append: '">Link</a>' -%}
    {% endif -%}
{% endfor %}  

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
    <tr>
      <th>Tutorial</th>
      <td>{{ tut_link }}</td>
    </tr>
  </tr>
</table>
<br/>

{{ content }}

{{ "## Metadata template" | markdownify }}
{% assign exp_title_clean = page.title | replace: " ", "-" | downcase | replace: "(", "_" | replace: ")", "_" -%}
{% include checklist_controls.html exp_title_clean=exp_title_clean %}
{% include get_checklist_formatted.html exp_title_clean=exp_title_clean %}
