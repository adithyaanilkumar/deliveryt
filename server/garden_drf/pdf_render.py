from  easy_pdf.rendering import render_to_pdf

def output_to_pdf(template_src, context_dict={}):
    content = render_to_pdf(template_src,context_dict)
    return content
'''
from django.http import HttpResponse
from django.template.loader import get_template

from xhtml2pdf import pisa

def render_to_pdf(template_src, context_dict={}):
    template = get_template(template_src)
    html  = template.render(context_dict)
    #result = BytesIO()
    result = StringIO()
    pdf = pisa.pisaDocument(StringIO(html.encode("ISO-8859-1")), result)
    #BytesIO(html.encode("ISO-8859-1")), result
    if not pdf.err:
        return result.getvalue()
    return None
'''