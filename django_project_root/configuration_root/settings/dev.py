from .base import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '{{ project.short_name }}',
        'USER': '{{ project.short_name }}',
    }
}

DEBUG = True
TEMPLATE_DEBUG = True

STATIC_URL = "/static/"
STATIC_DIR = project_dir("static")

MEDIA_URL = "/media/"
MEDIA_DIR = project_dir("media")
