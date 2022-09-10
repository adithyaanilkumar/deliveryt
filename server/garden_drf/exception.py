from rest_framework.exceptions import APIException

class ServiceUnavailable(APIException):
    status_code = 503
    default_detail = 'Razorpay Service temporarily unavailable, check request data or try again later.'
    default_code = 'service_unavailable'