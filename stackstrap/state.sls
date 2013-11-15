#
# Wordpress state file
# 
# Deploys wordpress on nginx + mysql
#

include:
  - avahi
  - nginx
  - mysql.server
  - php5.fpm

{% from "utils/users.sls" import skeleton %}
{% from "mysql/macros.sls" import mysql_user_db %}
{% from "nginx/macros.sls" import nginxsite %}
{% from "php5/macros.sls" import php5_fpm_instance %}

{{ skeleton("wordpress", 6000, 6000) }}
{{ mysql_user_db("wordpress", "wordpress") }}
{{ php5_fpm_instance("wordpress", 6000, "wordpress", "wordpress") }}
{{ nginxsite("wordpress", "wordpress", "wordpress",
             template="php-fastcgi.conf",
             server_name="_",
             create_root=False,
             defaults={
              'port': 6000,
              'try_files': '/index.php'
             })
}}

/home/wordpress/domains/wordpress/public:
  file:
    - symlink
    - target: /project/public

# vim: set ft=yaml ts=2 sw=2 sts=2 et ai :
