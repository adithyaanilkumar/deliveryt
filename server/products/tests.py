from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.test import RequestsClient
import requests
from users.models import User
from django.core.management.base import BaseCommand
import json
import time
import os
from datetime import timedelta
id_token_1 = ""
id_token_2 = ""
'''
class CreateSU(BaseCommand):
    def handle(self, *args, **options):
        if User.objects.count() == 0:
                username = 'garden'
                email = 'gardenfreshtohome@gmail.com'
                password = 'garden'
                print('Creating SU account for %s (%s)' % (username, email))
                admin = User.objects.create_superuser(email=email, username=username, password=password)
                admin.is_active = True
                admin.is_admin = True
                admin.save()
                time.sleep(5)
        else:
            print('Admin accounts can only be initialized if no Accounts exist, Try running tests with a clean DB')
            time.sleep(5)

'''
class AddProduct1(APITestCase):
    def test(self):
        url = "http://127.0.0.1:8000/products/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
            "name": "p1",
            "category": "c1",
            "description": "dasfghjghk",
            "image_url": "http://127.0.0.1:8000/products",
            "regular_price": 250,
            "discount_price": 200,
            "active": True,
            "popular": False,
            "stock": 500,
            "taxable": True
        }
        result = {
    "id": 1,
    "name": "p1",
    "category": "c1",
    "description": "dasfghjghk",
    "image_url": "http://127.0.0.1:8000/products",
    "regular_price": "250.00",
    "discount_price": "200.00",
    "active": True,
    "popular": False,
    "stock": "500.00",
    "taxable": True,
    "created_at": "2020-06-01T18:45:40.018238Z",
    "updated_at": "2020-06-01T18:45:40.018263Z"
}
        
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["category"], result["category"])
        self.assertEqual(response["description"], result["description"])
        self.assertEqual(response["image_url"], result["image_url"])
        self.assertEqual(response["regular_price"], result["regular_price"])
        self.assertEqual(response["discount_price"], result["discount_price"])
        self.assertEqual(response["popular"], result["popular"])
        self.assertEqual(response["stock"], result["stock"])
        self.assertEqual(response["taxable"], result["taxable"])

class AddProduct2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/products/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    "name": "p2",
    "category": "c2",
    "description": "DSzfxg",
    "image_url": "http://127.0.0.1:8000/products/",
    "regular_price": 420,
    "discount_price": 300,
    "active": True,
    "popular": True,
    "stock": 30,
    "taxable": True
}
        
        result= {
    "id": 2,
    "name": "p2",
    "category": "c2",
    "description": "DSzfxg",
    "image_url": "http://127.0.0.1:8000/products/",
    "regular_price": "420.00",
    "discount_price": "300.00",
    "active": True,
    "popular": True,
    "stock": "30.00",
    "taxable": True,
    "created_at": "2020-06-01T18:46:56.614618Z",
    "updated_at": "2020-06-01T18:46:56.614685Z"
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["category"], result["category"])
        self.assertEqual(response["description"], result["description"])
        self.assertEqual(response["image_url"], result["image_url"])
        self.assertEqual(response["regular_price"], result["regular_price"])
        self.assertEqual(response["discount_price"], result["discount_price"])
        self.assertEqual(response["popular"], result["popular"])
        self.assertEqual(response["stock"], result["stock"])
        self.assertEqual(response["taxable"], result["taxable"])

class AddProduct3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/products/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    "name": "p3",
    "category": "c1",
    "description": "sdfg",
    "image_url": "http://127.0.0.1:8000/products/",
    "regular_price": 220,
    "discount_price": 170,
    "active": True,
    "popular": False,
    "stock": 60,
    "taxable": True
}
        
        result=  {
    "id": 3,
    "name": "p3",
    "category": "c1",
    "description": "sdfg",
    "image_url": "http://127.0.0.1:8000/products/",
    "regular_price": "220.00",
    "discount_price": "170.00",
    "active": True,
    "popular": False,
    "stock": "60.00",
    "taxable": True,
    "created_at": "2020-06-01T18:47:48.624473Z",
    "updated_at": "2020-06-01T18:47:48.624554Z"
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["category"], result["category"])
        self.assertEqual(response["description"], result["description"])
        self.assertEqual(response["image_url"], result["image_url"])
        self.assertEqual(response["regular_price"], result["regular_price"])
        self.assertEqual(response["discount_price"], result["discount_price"])
        self.assertEqual(response["popular"], result["popular"])
        self.assertEqual(response["stock"], result["stock"])
        self.assertEqual(response["taxable"], result["taxable"])

class AddDelivery(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/owner/delivery/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    "name": "garden",
    "address1": "some addre line 1",
    "address2": "line2",
    "city": "kochi",
    "state": "kerala",
    "pin_code": "682020",
    "lattitude": 9.9542,
    "longtitude": 76.3024,
    "a1": 5,
    "a2": 10,
    "a3": 15,
    "c1": 10,
    "c2": 20,
    "c3": 30,
    "max_radius": 15,
    "tax": 18
}
        
        result =   {
    "id": 1,
    "name": "garden",
    "address1": "some addre line 1",
    "address2": "line2",
    "city": "kochi",
    "state": "kerala",
    "pin_code": "682020",
    "lattitude": "9.954200000000000",
    "longtitude": "76.302400000000000",
    "a1": "5.00",
    "a2": "10.00",
    "a3": "15.00",
    "c1": "10.00",
    "c2": "20.00",
    "c3": "30.00",
    "max_radius": "15.00",
    "tax": "18.00"
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["address1"], result["address1"])
        self.assertEqual(response["address2"], result["address2"])
        self.assertEqual(response["city"], result["city"])
        self.assertEqual(response["state"], result["state"])
        self.assertEqual(response["pin_code"], result["pin_code"])
        self.assertEqual(response["lattitude"], result["lattitude"])
        self.assertEqual(response["longtitude"], result["longtitude"])
        self.assertEqual(response["a1"], result["a1"])
        self.assertEqual(response["a2"], result["a2"])
        self.assertEqual(response["a3"], result["a3"])
        self.assertEqual(response["c1"], result["c1"])
        self.assertEqual(response["c2"], result["c2"])
        self.assertEqual(response["c3"], result["c3"])
        self.assertEqual(response["max_radius"], result["max_radius"])
        self.assertEqual(response["tax"], result["tax"])

class AddCoupons(APITestCase):
    def test(self):
        expiration_date = timedelta(days=10)
        url = "http://127.0.0.1:8000/orders/coupons/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    "name": "garden",
    "percentage": 50,
    "active": True,
    "expiry": expiration_date,
    "max_times": 10
}
        
        result =   {
    "id": 1,
    "name": "garden",
    "percentage": "50.00"
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["id"], result["id"])
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["percentage"], result["percentage"])

class AddUser2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/profiles/user/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data ={
                "last_login": None,
                "username": "",
                "first_name": "user2",
                "last_name": "user2",
                "email": "u2@gmail.com",
                "phone": "12345678909",
                "address": []
            }
        
        result =   {
                "id": 2,
                "last_login": None,
                "username": "H4Snmof1Q8VBQ7YBpvNe2jVPPZt2",
                "first_name": "user2",
                "last_name": "user2",
                "email": "u2@gmail.com",
                "phone": "12345678909",
                "address": []
            }
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["username"], result["username"])
        self.assertEqual(response["first_name"], result["first_name"])
        self.assertEqual(response["last_name"], result["last_name"])
        self.assertEqual(response["email"], result["email"])
        self.assertEqual(response["phone"], result["phone"])

class Address2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/profiles/address/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    "name": "user2",
    "address1": "szgGfzgggzsgf",
    "address2": "fdzgggggggggggg",
    "address3": "zdgggggggggggggzs",
    "address4": "sdgzsdgsfgsgfsgfzsg",
    "city": "SDgfsdf",
    "state": "sfgsfg",
    "pin_code": "684565",
    "deflt": True,
    "lat": 9.9682,
    "longt": 76.3182
}
        
        result =  {
    "id": 1,
    "user_name": "H4Snmof1Q8VBQ7YBpvNe2jVPPZt2",
    "name": "user2",
    "address1": "szgGfzgggzsgf",
    "address2": "fdzgggggggggggg",
    "address3": "zdgggggggggggggzs",
    "address4": "sdgzsdgsfgsgfsgfzsg",
    "city": "SDgfsdf",
    "state": "sfgsfg",
    "pin_code": "684565",
    "deflt": True,
    "lat": "9.968200000000000",
    "longt": "76.318200000000000",
    "distance": "2.323671404945812"
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["address1"], result["address1"])
        self.assertEqual(response["address2"], result["address2"])
        self.assertEqual(response["city"], result["city"])
        self.assertEqual(response["state"], result["state"])
        self.assertEqual(response["pin_code"], result["pin_code"])
        self.assertEqual(response["lat"], result["lat"])
        self.assertEqual(response["longt"], result["longt"])
        self.assertEqual(response["address3"], result["address3"])
        self.assertEqual(response["address4"], result["address4"])
        self.assertEqual(response["deflt"], result["deflt"])
        self.assertEqual(response["distance"], result["distance"])

class AddUser3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/profiles/user/"
        token = {"id_token": "", 'format': 'json'}
        data ={
                "last_login": None,
                "username": "",
                "first_name": "user3",
                "last_name": "user3",
                "email": "u3@gmail.com",
                "phone": "12345678909",
                "address": []
            }
        
        result =  {
    "id": 3,
    "last_login": None,
    "username": "MgSgKFbfSjXs4hrvnpLnxBkN0WV2",
    "first_name": "user3",
    "last_name": "user3",
    "email": "u3@gmail.com",
    "phone": "12345678909",
    "address": []
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["username"], result["username"])
        self.assertEqual(response["first_name"], result["first_name"])
        self.assertEqual(response["last_name"], result["last_name"])
        self.assertEqual(response["email"], result["email"])
        self.assertEqual(response["phone"], result["phone"])

class Address3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/profiles/address/"
        token = {"id_token": "", 'format': 'json'}
        data = {
    "name": "user3",
    "address1": "szgGfzgggzssdfgf",
    "address2": "fdzggggggdfgggggg",
    "address3": "zddfgggggggzs",
    "address4": "sdgzsdgfzsg",
    "city": "SDgfsdafdfdf",
    "state": "sfgsfdsfg",
    "pin_code": "684265",
    "deflt": True,
    "lat": 9.9686,
    "longt": 76.3181
}
        
        result = {
    "id": 2,
    "user_name": "MgSgKFbfSjXs4hrvnpLnxBkN0WV2",
    "name": "user3",
    "address1": "szgGfzgggzssdfgf",
    "address2": "fdzggggggdfgggggg",
    "address3": "zddfgggggggzs",
    "address4": "sdgzsdgfzsg",
    "city": "SDgfsdafdfdf",
    "state": "sfgsfdsfg",
    "pin_code": "684265",
    "deflt": True,
    "lat": "9.968600000000000",
    "longt": "76.318100000000000",
    "distance": "2.345324981487400"
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["name"], result["name"])
        self.assertEqual(response["address1"], result["address1"])
        self.assertEqual(response["address2"], result["address2"])
        self.assertEqual(response["city"], result["city"])
        self.assertEqual(response["state"], result["state"])
        self.assertEqual(response["pin_code"], result["pin_code"])
        self.assertEqual(response["lat"], result["lat"])
        self.assertEqual(response["longt"], result["longt"])
        self.assertEqual(response["address3"], result["address3"])
        self.assertEqual(response["address4"], result["address4"])
        self.assertEqual(response["deflt"], result["deflt"])
        self.assertEqual(response["distance"], result["distance"])
#######################################################################

class CartItem1U2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/profiles/cartitem/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    
    "quantity": 5,
    "user": 2,
    "product": 1
}
        
        result = {
    "id": 1,
    "ordered": False,
    "quantity": "5.00",
    "created_at": "2020-08-03T05:39:23.582210Z",
    "updated_at": "2020-08-03T05:39:23.582210Z",
    "amount_saved": "250.00",
    "price": "1000.00",
    "active": True,
    "user": 2,
    "product": 1
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["ordered"], result["ordered"])
        self.assertEqual(response["quantity"], result["quantity"])
        self.assertEqual(response["amount_saved"], result["amount_saved"])
        self.assertEqual(response["price"], result["price"])

class CartItem2U2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/profiles/cartitem/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    
    "quantity": 2,
    "user": 2,
    "product": 2
}
        
        result = {
    "id": 2,
    "ordered": False,
    "quantity": "2.00",
    "created_at": "2020-08-03T05:40:30.414370Z",
    "updated_at": "2020-08-03T05:40:30.414370Z",
    "amount_saved": "240.00",
    "price": "600.00",
    "active": True,
    "user": 2,
    "product": 2
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["ordered"], result["ordered"])
        self.assertEqual(response["quantity"], result["quantity"])
        self.assertEqual(response["amount_saved"], result["amount_saved"])
        self.assertEqual(response["price"], result["price"])

class GetAllCartItemU2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/profiles/cartitem/"
        token = {"id_token": id_token_1, 'format': 'json'}
        
        result = [
    {
        "id": 1,
        "ordered": False,
        "quantity": "5.00",
        "created_at": "2020-08-03T05:39:23.582210Z",
        "updated_at": "2020-08-03T05:39:23.582210Z",
        "amount_saved": "250.00",
        "price": "1000.00",
        "active": True,
        "user": 2,
        "product": 1
    },
    {
        "id": 2,
        "ordered": False,
        "quantity": "2.00",
        "created_at": "2020-08-03T05:40:30.414370Z",
        "updated_at": "2020-08-03T05:40:30.414370Z",
        "amount_saved": "240.00",
        "price": "600.00",
        "active": True,
        "user": 2,
        "product": 2
    }
]
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.get(url,params = token)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_200_OK)
        self.assertEqual(response[0]["ordered"], result[0]["ordered"])
        self.assertEqual(response[0]["quantity"], result[0]["quantity"])
        self.assertEqual(response[0]["amount_saved"], result[0]["amount_saved"])
        self.assertEqual(response[0]["price"], result[0]["price"])
        self.assertEqual(response[1]["ordered"], result[1]["ordered"])
        self.assertEqual(response[1]["quantity"], result[1]["quantity"])
        self.assertEqual(response[1]["amount_saved"], result[1]["amount_saved"])
        self.assertEqual(response[1]["price"], result[1]["price"])

class GetCartU2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/profiles/cart/"
        token = {"id_token": id_token_1, 'format': 'json'}
        
        result = [
    {
        "id": 1,
        "user": 2,
        "ordered": False,
        "cart_items": [
            {
                "id": 1,
                "user": 2,
                "ordered": False,
                "product": {
                    "id": 1,
                    "name": "p1",
                    "category": "c1",
                    "description": "dasfghjghk",
                    "image_url": "http://127.0.0.1:8000/products",
                    "regular_price": "250.00",
                    "discount_price": "200.00",
                    "active": True,
                    "popular": False,
                    "stock": "500.00",
                    "taxable": True,
                    "created_at": "2020-08-02T06:54:10.452425Z",
                    "updated_at": "2020-08-02T06:54:10.452425Z"
                },
                "quantity": "5.00",
                "created_at": "2020-08-03T05:39:23.582210Z",
                "updated_at": "2020-08-03T05:39:23.582210Z",
                "amount_saved": "250.00",
                "price": "1000.00"
            },
            {
                "id": 2,
                "user": 2,
                "ordered": False,
                "product": {
                    "id": 2,
                    "name": "p2",
                    "category": "c2",
                    "description": "DSzfxg",
                    "image_url": "http://127.0.0.1:8000/products/",
                    "regular_price": "420.00",
                    "discount_price": "300.00",
                    "active": True,
                    "popular": True,
                    "stock": "30.00",
                    "taxable": True,
                    "created_at": "2020-08-02T06:54:42.152192Z",
                    "updated_at": "2020-08-02T06:54:42.152192Z"
                },
                "quantity": "2.00",
                "created_at": "2020-08-03T05:40:30.414370Z",
                "updated_at": "2020-08-03T05:40:30.414370Z",
                "amount_saved": "240.00",
                "price": "600.00"
            }
        ],
        "total_price": "1600.00"
    }
]
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDYwMTAzNSwidXNlcl9pZCI6Ikg0U25tb2YxUThWQlE3WUJwdk5lMmpWUFBadDIiLCJzdWIiOiJINFNubW9mMVE4VkJRN1lCcHZOZTJqVlBQWnQyIiwiaWF0IjoxNTkwNjAxMDM1LCJleHAiOjE1OTA2MDQ2MzUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.i49tUj3WIuDHgufxtCufnE91lvk1rA49ptO9MLCUYLY5-sFyzBqOxa7h0T8E1bXBB0ksX8nbv-OwN5vuIyaBhu_hvxTvWadSjEjC7mJwr7h-QrvjMSw2yn1WTHGJ6xh0dW-IPm5nPVyM9hH3sGAJ4I66ail2LOTZ9K6XQZCSbtDfO7Y-7D6eVowv1N_RnMFXebVjxLVtCjWcV8K5TufBNLlUTtPsHWf_ThXwEz44PPZa7HFnl6xbURuODFRIBS26sZBKIZCpji1P6PnPFK_O1ywa5qggvsBsL3fVgW39_vLZBqBMa9WOEUcgnicb6oA34o3Wvr80GW1Sml6h0-u9iA')
        response_data = requests.get(url,params = token)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_200_OK)
        self.assertEqual(response[0]["cart_items"][0]["ordered"], result[0]["cart_items"][0]["ordered"])
        self.assertEqual(response[0]["cart_items"][0]["quantity"], result[0]["cart_items"][0]["quantity"])
        self.assertEqual(response[0]["cart_items"][0]["amount_saved"], result[0]["cart_items"][0]["amount_saved"])
        self.assertEqual(response[0]["cart_items"][0]["price"], result[0]["cart_items"][0]["price"])
        self.assertEqual(response[0]["cart_items"][1]["ordered"], result[0]["cart_items"][1]["ordered"])
        self.assertEqual(response[0]["cart_items"][1]["quantity"], result[0]["cart_items"][1]["quantity"])
        self.assertEqual(response[0]["cart_items"][1]["amount_saved"], result[0]["cart_items"][1]["amount_saved"])
        self.assertEqual(response[0]["cart_items"][1]["price"], result[0]["cart_items"][1]["price"])
        self.assertEqual(response[0]["total_price"], result[0]["total_price"])
#############################################################################

class CartItem1U3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/profiles/cartitem/"
        token = {"id_token": "", 'format': 'json'}
        data = {
    
    "quantity": 4,
    "user": 3,
    "product": 2
}
        
        result = {
    "id": 3,
    "ordered": False,
    "quantity": "4.00",
    "created_at": "2020-08-03T05:54:45.088582Z",
    "updated_at": "2020-08-03T05:54:45.088582Z",
    "amount_saved": "480.00",
    "price": "1200.00",
    "active": True,
    "user": 3,
    "product": 2
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["ordered"], result["ordered"])
        self.assertEqual(response["quantity"], result["quantity"])
        self.assertEqual(response["amount_saved"], result["amount_saved"])
        self.assertEqual(response["price"], result["price"])

class CartItem2U3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/profiles/cartitem/"
        token = {"id_token": "", 'format': 'json'}
        data = {
    
    "quantity": 6,
    "user": 3,
    "product": 3
}
        
        result = {
    "id": 4,
    "ordered": False,
    "quantity": "6.00",
    "created_at": "2020-08-03T05:55:16.808235Z",
    "updated_at": "2020-08-03T05:55:16.808235Z",
    "amount_saved": "300.00",
    "price": "1020.00",
    "active": True,
    "user": 3,
    "product": 3
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["ordered"], result["ordered"])
        self.assertEqual(response["quantity"], result["quantity"])
        self.assertEqual(response["amount_saved"], result["amount_saved"])
        self.assertEqual(response["price"], result["price"])

class GetAllCartItemU3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/profiles/cartitem/"
        token = {"id_token": "", 'format': 'json'}
        
        result = [
    {
        "id": 3,
        "ordered": False,
        "quantity": "4.00",
        "created_at": "2020-08-03T05:54:45.088582Z",
        "updated_at": "2020-08-03T05:54:45.088582Z",
        "amount_saved": "480.00",
        "price": "1200.00",
        "active": True,
        "user": 3,
        "product": 2
    },
    {
        "id": 4,
        "ordered": False,
        "quantity": "6.00",
        "created_at": "2020-08-03T05:55:16.808235Z",
        "updated_at": "2020-08-03T05:55:16.808235Z",
        "amount_saved": "300.00",
        "price": "1020.00",
        "active": True,
        "user": 3,
        "product": 3
    }
]
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ')
        response_data = requests.get(url,params = token)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_200_OK)
        self.assertEqual(response[0]["ordered"], result[0]["ordered"])
        self.assertEqual(response[0]["quantity"], result[0]["quantity"])
        self.assertEqual(response[0]["amount_saved"], result[0]["amount_saved"])
        self.assertEqual(response[0]["price"], result[0]["price"])
        self.assertEqual(response[1]["ordered"], result[1]["ordered"])
        self.assertEqual(response[1]["quantity"], result[1]["quantity"])
        self.assertEqual(response[1]["amount_saved"], result[1]["amount_saved"])
        self.assertEqual(response[1]["price"], result[1]["price"])

class GetCartU3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/profiles/cart/"
        token = {"id_token": "", 'format': 'json'}
        
        result = [
    {
        "id": 2,
        "user": 3,
        "ordered": False,
        "cart_items": [
            {
                "id": 3,
                "user": 3,
                "ordered": False,
                "product": {
                    "id": 2,
                    "name": "p2",
                    "category": "c2",
                    "description": "DSzfxg",
                    "image_url": "http://127.0.0.1:8000/products/",
                    "regular_price": "420.00",
                    "discount_price": "300.00",
                    "active": True,
                    "popular": True,
                    "stock": "30.00",
                    "taxable": True,
                    "created_at": "2020-08-02T06:54:42.152192Z",
                    "updated_at": "2020-08-02T06:54:42.152192Z"
                },
                "quantity": "4.00",
                "created_at": "2020-08-03T05:54:45.088582Z",
                "updated_at": "2020-08-03T05:54:45.088582Z",
                "amount_saved": "480.00",
                "price": "1200.00"
            },
            {
                "id": 4,
                "user": 3,
                "ordered": False,
                "product": {
                    "id": 3,
                    "name": "p3",
                    "category": "c1",
                    "description": "sdfg",
                    "image_url": "http://127.0.0.1:8000/products/",
                    "regular_price": "220.00",
                    "discount_price": "170.00",
                    "active": True,
                    "popular": False,
                    "stock": "60.00",
                    "taxable": True,
                    "created_at": "2020-08-02T06:54:59.248283Z",
                    "updated_at": "2020-08-02T06:54:59.248283Z"
                },
                "quantity": "6.00",
                "created_at": "2020-08-03T05:55:16.808235Z",
                "updated_at": "2020-08-03T05:55:16.808235Z",
                "amount_saved": "300.00",
                "price": "1020.00"
            }
        ],
        "total_price": "2220.00"
    }
]

        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ')
        response_data = requests.get(url,params = token)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_200_OK)
        self.assertEqual(response[0]["cart_items"][0]["ordered"], result[0]["cart_items"][0]["ordered"])
        self.assertEqual(response[0]["cart_items"][0]["quantity"], result[0]["cart_items"][0]["quantity"])
        self.assertEqual(response[0]["cart_items"][0]["amount_saved"], result[0]["cart_items"][0]["amount_saved"])
        self.assertEqual(response[0]["cart_items"][0]["price"], result[0]["cart_items"][0]["price"])
        self.assertEqual(response[0]["cart_items"][1]["ordered"], result[0]["cart_items"][1]["ordered"])
        self.assertEqual(response[0]["cart_items"][1]["quantity"], result[0]["cart_items"][1]["quantity"])
        self.assertEqual(response[0]["cart_items"][1]["amount_saved"], result[0]["cart_items"][1]["amount_saved"])
        self.assertEqual(response[0]["cart_items"][1]["price"], result[0]["cart_items"][1]["price"])
        self.assertEqual(response[0]["total_price"], result[0]["total_price"])
################################################################################

class PlaceOrderU2(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1:8000/orders/orders/"
        token = {"id_token": id_token_1, 'format': 'json'}
        data = {
    "user": 2,
    "address": 1,
    "coupon": "garden"
}
        
        result = {
    "id": 3,
    "order_id": "order_FMBS27JtA1aIxE",
    "payment_status": "ORDERED",
    "ordered": True,
    "completed": False,
    "tax": "288.00",
    "delivery_fee": "10.00",
    "coupon": "garden",
    "coupon_discount": "800.00",
    "cart_price": "1600.00",
    "total_price": "1098.00",
    "order_items": "{\"id\": 1, \"user\": 2, \"ordered\": False, \"cart_items\": [{\"id\": 1, \"user\": 2, \"ordered\": False, \"product\": {\"id\": 1, \"name\": \"p1\", \"category\": \"c1\", \"description\": \"dasfghjghk\", \"image_url\": \"http://127.0.0.1:8000/products\", \"regular_price\": \"250.00\", \"discount_price\": \"200.00\", \"active\": True, \"popular\": False, \"stock\": \"500.00\", \"taxable\": True, \"created_at\": \"2020-08-02T06:54:10.452425Z\", \"updated_at\": \"2020-08-02T06:54:10.452425Z\"}, \"quantity\": \"5.00\", \"created_at\": \"2020-08-03T05:39:23.582210Z\", \"updated_at\": \"2020-08-03T05:39:23.582210Z\", \"amount_saved\": \"250.00\", \"price\": \"1000.00\"}, {\"id\": 2, \"user\": 2, \"ordered\": False, \"product\": {\"id\": 2, \"name\": \"p2\", \"category\": \"c2\", \"description\": \"DSzfxg\", \"image_url\": \"http://127.0.0.1:8000/products/\", \"regular_price\": \"420.00\", \"discount_price\": \"300.00\", \"active\": True, \"popular\": True, \"stock\": \"30.00\", \"taxable\": True, \"created_at\": \"2020-08-02T06:54:42.152192Z\", \"updated_at\": \"2020-08-02T06:54:42.152192Z\"}, \"quantity\": \"2.00\", \"created_at\": \"2020-08-03T05:40:30.414370Z\", \"updated_at\": \"2020-08-03T05:40:30.414370Z\", \"amount_saved\": \"240.00\", \"price\": \"600.00\"}], \"total_price\": \"1600.00\"}",
    "created_at": "2020-08-03T06:01:48.262229Z",
    "updated_at": "2020-08-03T06:01:48.263258Z",
    "user": 2,
    "order_cart": 1,
    "address": 1
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["payment_status"], result["payment_status"])
        self.assertEqual(response["ordered"], result["ordered"])
        self.assertEqual(response["completed"], result["completed"])
        self.assertEqual(response["delivery_fee"], result["delivery_fee"])
        self.assertEqual(response["coupon"], result["coupon"])
        self.assertEqual(response["coupon_discount"], result["coupon_discount"])
        self.assertEqual(response["cart_price"], result["cart_price"])
        self.assertEqual(response["total_price"], result["total_price"])
        

class PlaceOrderU3(APITestCase):
    def test(self):
  
        url = "http://127.0.0.1"":8000/orders/orders/"
        token = {"id_token": "", 'format': 'json'}
        data = {
    "user": 3,
    "address": 2
}
        
        result = {
    "id": 1,
    "order_id": "order_FMBOmLk7Os8uAz",
    "payment_status": "ORDERED",
    "ordered": True,
    "completed": False,
    "tax": "400.00",
    "delivery_fee": "10.00",
    "coupon": None,
    "coupon_discount": None,
    "cart_price": "2220.00",
    "total_price": "2630.00",
    "order_items": "{\"id\": 2, \"user\": 3, \"ordered\": False, \"cart_items\": [{\"id\": 3, \"user\": 3, \"ordered\": False, \"product\": {\"id\": 2, \"name\": \"p2\", \"category\": \"c2\", \"description\": \"DSzfxg\", \"image_url\": \"http://127.0.0.1:8000/products/\", \"regular_price\": \"420.00\", \"discount_price\": \"300.00\", \"active\": True, \"popular\": True, \"stock\": \"30.00\", \"taxable\": True, \"created_at\": \"2020-08-02T06:54:42.152192Z\", \"updated_at\": \"2020-08-02T06:54:42.152192Z\"}, \"quantity\": \"4.00\", \"created_at\": \"2020-08-03T05:54:45.088582Z\", \"updated_at\": \"2020-08-03T05:54:45.088582Z\", \"amount_saved\": \"480.00\", \"price\": \"1200.00\"}, {\"id\": 4, \"user\": 3, \"ordered\": False, \"product\": {\"id\": 3, \"name\": \"p3\", \"category\": \"c1\", \"description\": \"sdfg\", \"image_url\": \"http://127.0.0.1:8000/products/\", \"regular_price\": \"220.00\", \"discount_price\": \"170.00\", \"active\": True, \"popular\": False, \"stock\": \"60.00\", \"taxable\": True, \"created_at\": \"2020-08-02T06:54:59.248283Z\", \"updated_at\": \"2020-08-02T06:54:59.248283Z\"}, \"quantity\": \"6.00\", \"created_at\": \"2020-08-03T05:55:16.808235Z\", \"updated_at\": \"2020-08-03T05:55:16.808235Z\", \"amount_saved\": \"300.00\", \"price\": \"1020.00\"}], \"total_price\": \"2220.00\"}",
    "created_at": "2020-08-03T05:58:44.870920Z",
    "updated_at": "2020-08-03T05:58:44.870920Z",
    "user": 3,
    "order_cart": 2,
    "address": 2
}
        newHeaders = {'Content-type': 'application/json'}
        #self.client.credentials(id_token='eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ')
        response_data = requests.post(url,params = token , json =data, headers=newHeaders)
        response = response_data.json()
        self.assertEqual(response_data.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response["payment_status"], result["payment_status"])
        self.assertEqual(response["ordered"], result["ordered"])
        self.assertEqual(response["completed"], result["completed"])
        self.assertEqual(response["delivery_fee"], result["delivery_fee"])
        self.assertEqual(response["coupon"], result["coupon"])
        self.assertEqual(response["coupon_discount"], result["coupon_discount"])
        self.assertEqual(response["cart_price"], result["cart_price"])
        self.assertEqual(response["total_price"], result["total_price"])
