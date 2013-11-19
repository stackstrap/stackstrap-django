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

{% from "utils/users.sls" import skeleton %}
{% from "mysql/macros.sls" import mysql_user_db %}
{% from "nginx/macros.sls" import nginxsite %}
{% from "supervisor/macros.sls" import supervise %}

django_env:
  virtualenv:
    - managed
    - name: /home/django/virtualenv
    - requirements: /home/django/current/application/requirements/{{ config.get('requirements', mode) }}.txt
    - user: stackstrap
    - no_chown: True
    - system_site_packages: True
    - require:
      - user: stackstrap
      - pkg: virtualenv_pkgs

{{ skeleton("django", 6000, 6000) }}
{{ mysql_user_db("django", "django") }}
{{ nginxsite("django", "django", "django",
             template="proxy-django.conf",
             server_name="_",
             create_root=False,
             defaults={
              'port': 8000
             })
}}
{{ supervise("django", "/home/django" ,6000, 6000,{
        "django": {
            "program": 
        }
    }) 
}}

# vim: set ft=yaml ts=2 sw=2 sts=2 et ai :
