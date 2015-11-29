#!jinja|yaml

{% set datamap = salt['formhelper.get_defaults']('powerdns', saltenv) %}

include: {{ salt['pillar.get']('powerdns:lookup:recursor:sls_include', []) }}
extend: {{ salt['pillar.get']('powerdns:lookup:recursor:sls_extend', '{}') }}

pdns_recursor:
  pkg:
    - installed
    - pkgs: {{ datamap.recursor.pkgs }}
  service:
    - running
    - name: {{ datamap.recursor.service.name }}
    - sig: {{ datamap.recursor.service.sig|default('pdns_recursor') }}

{% if 'main' in datamap.recursor.config.manage and datamap.recursor.config.main.settings is defined %}
pdns_recursor_config:
  file:
    - {{ datamap.recursor.config.main.ensure|default('managed') }}
    - name: {{ datamap.recursor.config.main.path }}
    - user: {{ datamap.recursor.config.main.user|default('root') }}
    - group: {{ datamap.recursor.config.main.group|default('root') }}
    - mode: {{ datamap.recursor.config.main.mode|default(644) }}
    - watch_in:
      - service: pdns_recursor
    - contents: |
  {% for k, v in datamap.recursor.config.main.settings|default({})|dictsort %}
        {{ k }}={{ v -}}
  {% endfor %}
{% endif %}
