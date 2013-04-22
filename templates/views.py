# coding: UTF-8

from django.shortcuts import render_to_response, redirect
from django.template import RequestContext
# from django.http import HttpResponse
# from django.core.paginator import Paginator

from utilites import Messages
import messages


def home_page(request):
    return render_to_response('home.html', context, 
                              context_instance=RequestContext(request))