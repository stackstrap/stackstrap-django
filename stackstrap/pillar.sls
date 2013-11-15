---
stackstrap:
  template_name: "WordPress"
  template_description:
    This is the StackStrap wordpress template that is maintained as a fork of the
    official wordpress repository making it super easy to pick a specific version
    of wordpress by simply specifying that version tag as the GIT ref when you
    setup the template in the StackStrap admin.

  # define which files should have our context applied as templates
  file_templates:
    - public/wp-config.php

# vim: set ft=yaml ts=2 sw=2 sts=2 et ai :
