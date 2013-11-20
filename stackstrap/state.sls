#
# Django state file
#
# Deploys Django for development
#

include:
  - avahi
  - nginx
  - mysql.server
  - virtualenv
  - supervisor

{% from "utils/users.sls" import skeleton -%}
{% from "mysql/macros.sls" import mysql_user_db -%}
{% from "nginx/macros.sls" import nginxsite -%}
{% from "supervisor/macros.sls" import supervise -%}

{% set short_name = pillar['project']['short_name'] -%}
{% set home = "/home/" + short_name -%}
{% set virtualenv = home + "/virtualenv" -%}
{% set appdir = home + "/current/" + short_name -%}

{{ skeleton(short_name, 6000, 6000) }}

{{ short_name }}_env:
  virtualenv:
    - managed
    - name: {{ virtualenv }}
    - requirements: {{ home }}/current/requirements/dev.txt
    - user: {{ short_name }}
    - no_chown: True
    - system_site_packages: True
    - require:
      - file: /home/{{ short_name }}
      - pkg: virtualenv_pkgs

{{ mysql_user_db(short_name, short_name) }}

{{ nginxsite(short_name, short_name, short_name,
             template="proxy-django.conf",
             server_name="_",
             create_root=False,
             defaults={
              'port': 8000
             })
}}
{{ supervise(short_name, home, short_name, short_name, {
        "django": {
            "command": "/bin/sh -c '" + virtualenv + "/bin/django-admin.py runserver 0:8000 2>&1'",
            "directory": appdir,
            "environment": "DJANGO_SETTINGS_MODULE=" + short_name + ".settings.dev"
        }
    }) 
}}

# vim: set ft=yaml ts=2 sw=2 sts=2 et ai :
