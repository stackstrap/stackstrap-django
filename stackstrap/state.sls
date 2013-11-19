#
# Django state file
#
# Deploys Django for development
#

include:
  - avahi
  - nginx
  - mysql.server

{% from "utils/users.sls" import skeleton %}
{% from "mysql/macros.sls" import mysql_user_db %}
{% from "nginx/macros.sls" import nginxsite %}

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

# vim: set ft=yaml ts=2 sw=2 sts=2 et ai :
