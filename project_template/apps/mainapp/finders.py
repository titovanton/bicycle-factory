# -*- coding: utf-8 -*-

from django.core.files.storage import FileSystemStorage
from django.contrib.staticfiles.finders import BaseStorageFinder

from settings.path import rel_project


class BicycleFinder(BaseStorageFinder):
    storage = FileSystemStorage(rel_project('bicycle', 'static_src'))


class MainappFinder(BaseStorageFinder):
    storage = FileSystemStorage(rel_project('apps', 'mainapp', 'static_src'))


class LibsFinder(BaseStorageFinder):
    storage = FileSystemStorage(rel_project('libs'))
