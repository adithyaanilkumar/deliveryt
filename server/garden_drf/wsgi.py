"""
WSGI config for garden_drf project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.0/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application
#from dotenv import load_dotenv


os.environ.setdefault("DJANGO_SETTINGS_MODULE", "garden_drf.settings")
'''
project_folder = os.path.expanduser('~/garden_drf')
load_dotenv(os.path.join(project_folder, '.env'))'''
application = get_wsgi_application()
