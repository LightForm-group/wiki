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
  </tr>
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
  <tr>
    <th>Metadata templates</th>
    <td>
    {% if page.metadata_templates %}
      <ul class="experiment-tutorial-link">
      {% for metadata_temp_file in page.metadata_templates %}
          {% assign metadata_href = site.url | append: site.baseurl | append: "/_includes/metadata_templates/" | append: metadata_temp_file %}
          <li><a href="{{ metadata_href }}">{{ metadata_temp_file }}</a></li>
      {% endfor %}
      </ul>
    {% else %}
    -
    {% endif %}
    </td>
  </tr>
</table>
<br/>

{{ content }}

