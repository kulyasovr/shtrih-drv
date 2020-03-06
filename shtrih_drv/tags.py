from handlers import FunctionSave
import re
import time
import exepts


def tel_email_match(arg):
    if tel_match(arg) or email_match(arg):
        print(arg)
        return arg


def tel_match(arg):
    if re.match(r'\+\d+$', arg):
        return arg


def number_match(arg):
    if re.match(r'\d+$', arg):
        return arg


def cashier_match(arg):
    if re.match(r'КАССИР \w+$', arg):
        return arg


def tlv_length(tlv, max_length):
    if type(tlv) == float:
        tlv = str(int(tlv*100))
    if len(tlv) <= max_length:
        return True


def email_match(arg):
    if re.match(r'\w+@\w+\.\w+$', arg):
        return arg


def inn_match(arg):
    if re.match(r'\d{10}$', arg) or re.match(r'\d{12}$', arg):
        return arg


def vln_match(arg):
    return (int(arg * 100)).to_bytes(6, byteorder='little')


def date_match(date):
    byte = int(time.mktime((date[0], date[1], date[2], 0, 0, 0, 0, 0, 0)))
    return byte.to_bytes(4, byteorder='little')


tag_type = {
    1005: (('строка', 256, None),),
    1008: (('строка', 64, FunctionSave(tel_email_match)),),
    1016: (('строка', 12, FunctionSave(inn_match)),),
    1021: (('строка', 64, FunctionSave(cashier_match)),),
    1026: (('строка', 64, None),),
    1044: (('строка', 24, None),),
    1057: (('байт', 1, None),), # отправка в виде b''
    1073: (('строка', 19, FunctionSave(tel_match)),),
    1074: (('строка', 19, FunctionSave(tel_match)),),
    1075: (('строка', 19, FunctionSave(tel_match)),),
    1117: (('строка', 64, FunctionSave(email_match)),),
    1126: (('байт', 1, None),),
    1171: (('строка', 19, FunctionSave(tel_match)),),
    1192: (('строка', 16, None),),
    1193: (('байт', 1, None),),
    1203: (('строка', 12, None),),
    1207: (('байт', 1, None),),
    15000: (('строка', 256, None),),
    15001: (('строка', 256, None),),
    15002: (('строка', 256, None),),
    1177: (('строка', 256, None),),
    1178: (('date', 4, FunctionSave(date_match)),),
    1179: (('строка', 32, None),),
    1227: (('строка', 256, None),),
    1228: (('строка', 19, FunctionSave(inn_match)),),
    1229: (('vln', 19, FunctionSave(vln_match)),),
    1230: (('строка', 3, FunctionSave(number_match)),),
    1231: (('строка', 32, None),),
    16000: (('строка', 64, None),),
    16015: (('строка', 64, None),),
    1198: (('vln', 19, FunctionSave(vln_match)),),
    1191: (('строка', 64, None),),
    1197: (('строка', 16, None),),
    #1162: (('строка', 8, None),),
    1222: (('байт', 1, None),),
    1226: (('строка', 12, FunctionSave(inn_match)),),
    1225: (('строка', 256, None),),
}


def tag(name, body):
    if name in tag_type:
        tag_description = tag_type.get(name)
        for tag_format, length, func in tag_description:
            tlv_length(body, length)
            if tag_format == 'строка':
                if func is None:
                    return bytes(body.encode('cp866'))
                else:
                    try:
                        return bytes(func(body).encode('cp866'))
                    except:
                        raise exepts.IncorrectTagValue('Неверное значение тега')
            elif tag_format == 'байт':
                return body
            else:
                return func(body)
