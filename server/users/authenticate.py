import os
from django.http import HttpResponse
from rest_framework import exceptions as excp
from django.views.decorators.csrf import csrf_exempt
import json


from django.contrib.auth.backends import ModelBackend
from users.models import User
from django.conf import settings
import logging
from rest_framework import status
from rest_framework.response import Response
import jwt
import requests
import datetime, time
import pytz
def  get_uid(id_token):
    try:
        payload = jwt.decode(id_token, verify=False, algorithms="RS256")
        return payload["sub"]
    except:
        return None
def verify_auth_token(id_token):
    utc=pytz.UTC
    payload = jwt.decode(id_token, verify=False, algorithms="RS256")
    print(payload)
    headers = jwt.get_unverified_header(id_token)
    today =  datetime.datetime.now().replace(tzinfo=utc)
    today_sec = time.mktime(today.timetuple())
    if  headers["alg"]=='RS256':
        google_serv = requests.get('https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com')
        for k,v in google_serv.json().items():
            if k==headers['kid']:
                break
        #payload["aud"]==os.getenv("AUD") and payload["iss"]==os.getenv("ISS") and
        if payload["iat"]<= today_sec  and  payload["sub"]!=None and payload["auth_time"]<=today_sec:
            print(payload["sub"])
            return payload["sub"]
    return None
class PasswordlessAuthBackend(ModelBackend):
    user_id=None

    def authenticate(self,request, *args, **kwargs):
        print("in  authenthicate")
        logger = logging.getLogger(__name__)
        id_token=request.query_params.get('id_token')
        print(f"id_token {id_token}")
        if id_token:
            try:
                logger.info(id_token)
                uid = verify_auth_token(id_token)
                print(f"uid {uid}")
                if uid!=None:
                        try:
                            user = User.objects.get(username=uid)
                            return (user,None) 
                        except:
                            entity = User.objects.get(id=1)
                            #entity.save()
                            return  (entity,None)

                else:
                        return None
                        #return HttpResponse('Unauthorized', status=401)
                        #return Response("nothing to see here", status=status.HTTP_401_UNAUTHORIZED)
            except:
                    #return HttpResponse('Unauthorized', status=401)
                    #raise excp.AuthenticationFailed('Authentication failed')
                    return None
                    #return HttpResponse('Unauthorized', status=401)
                    #return Response("nothing to see here", status=status.HTTP_401_UNAUTHORIZED)
        else:
            return None
            #return HttpResponse('Unauthorized', status=400)
            #return Response("nothing to see here", status=status.HTTP_401_UNAUTHORIZED)
    def get_user(self, user_id):
        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            #return Response("nothing to see here", status=status.HTTP_401_UNAUTHORIZED)
            return None