from django.apps import AppConfig


class OwnerConfig(AppConfig):
    name = 'owner'
    def ready(self):
        import owner.signals