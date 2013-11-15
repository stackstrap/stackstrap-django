---
stackstrap:
  template_name: "Django"
  template_description:
    This is the StackStrap Django template which is based off of the
    book 'Two Scoops of Django' by Daniel Greenfeld and Audrey Roy.

  # define which files should have our context applied as templates
  file_templates:
    - README.rst

  path_templates:
    'django_project_root/configuration_root': 'django_project_root/{{ project.short_name }}'
    'django_project_root': '{{ project.short_name }}'

# vim: set ft=yaml ts=2 sw=2 sts=2 et ai :
