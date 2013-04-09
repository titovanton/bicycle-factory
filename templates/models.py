# coding: UTF-8

from django.db import models
from django.utils.timezone import now
# from django.conf import settings
# from django.contrib.auth.models import User
# from django.contrib.sessions.models import Session
from sorl.thumbnail.fields import ImageField
# from sorl.thumbnail import get_thumbnail

from utilites import machine_word, transliterate


# abstract
class Standart(models.Model):
    """Used as mixin
    """
    
    created = models.DateTimeField(verbose_name=u'Создан')
    updated = models.DateTimeField(verbose_name=u'Обновлен')
    published = models.BooleanField(verbose_name=u'Опубликован')
    order_by = models.IntegerField(null=True, blank=True, verbose_name=u"Порядок в списке")

    title = models.CharField(max_length=120, verbose_name=u'Название')
    alias = models.CharField(max_length=120, unique=True, verbose_name=u'Название латиницей')

    def save(self):
        if not self.id:
            self.created = now()

        self.updated = now()
        self.alias = machine_word(self.alias)

        super(Standart, self).save()

    def get_url(self):
        return u'/%s/%s/' % (self.__class__.__name__.lower(), self.alias)

    class Meta:
        abstract = True


# abstract
class Seo(models.Model):
    """Used as mixin
    """
    
    html_title = models.CharField(max_length=260, blank=True, null=True)
    html_keywords = models.CharField(max_length=260, blank=True, null=True)
    html_description = models.CharField(max_length=260, blank=True, null=True)

    class Meta:
        abstract = True


# class FutureMessage(models.Model):
#     """
#     Используется в случае необходимости вывести сообщение посли redirect.
#     Работает в связке с FutureMessageMiddleware

#     """

#     session = models.ForeignKey(Session, blank=True, null=True)
#     user = models.ForeignKey(User, blank=True, null=True)
#     title = models.CharField(max_length=10)
#     text = models.TextField()
