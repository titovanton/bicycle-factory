# coding: UTF-8

# from models import FutureMessage
from utilites import Messages
import messages


class DefaultContextMiddleware(object):
    def process_request(self, request):
        request.alert_messages = []


# class FutureMessageMiddleware(object):
#     """
#     Используется в случае необходимости вывести сообщение посли redirect.
#     Должна исполняться сразу после DefaultContextMiddleware

#     """

#     def process_request(self, request):
#         if request.user.is_authenticated():
#             msgs = FutureMessage.objects.filter(user=request.user)
#             request.alert_messages += [Messages(m.title, m.text) for m in msgs]
#             msgs.delete()