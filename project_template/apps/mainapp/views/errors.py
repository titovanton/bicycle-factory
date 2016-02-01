# -*- coding: utf-8 -*-

from django.shortcuts import render


def page_not_found(request):

    return render(request, 'errors/404.html', {}, status=404)
