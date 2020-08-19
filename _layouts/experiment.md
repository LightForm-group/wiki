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
      <th>Analysis codes</th>
      <td>
      {% if page.analysis_codes %}
        <ul class="experiment-analysis-code-link">
        {% for analysis_code in page.analysis_codes -%}
        <li><a href="{{ analysis_code.link }}">{{ analysis_code.name }}</a></li>
        {% endfor -%}
        </ul>
      {% else %}
      -
      {% endif %}            
      </td>
    <tr>
      <th>Tutorials</th>
      <td>            
      {% if page.tutorials %}
        <ul class="experiment-tutorial-link">
        {% for tutorial_title in page.tutorials %}
          {% for tut in site.tutorials -%}
              {% if tut.title == tutorial_title -%}
                  {% assign page_href = tut.url | prepend: site.baseurl %}
                  <li><a href="{{ page_href }}">{{ tut.title }}</a></li>
              {% endif -%}
          {% endfor %}
        {% endfor %}
        </ul>
      {% else %}
      -
      {% endif %}
      </td>
    </tr>
  </tr>
</table>
<br/>

{{ content }}
