from django.db import models

import uuid



class Base(models.Model):
    """
    Base parent model for all the models
    """
    id = models.UUIDField(
        primary_key=True, 
        default=uuid.uuid4, 
        editable=False
    )
    created_at = models.DateTimeField(
        auto_now = True,
    )
    updated_at = models.DateTimeField(
        auto_now_add = True,
    )


    class Meta:
        abstract = True
