from lists import kkt_flags
from io import BytesIO


class FunctionSave(object):
    def __init__(self, *funcs):
        self.funcs = funcs

    def __call__(self, *args, **kwargs):
        if not self.funcs:
            return

        res = self.funcs[-1](*args, **kwargs)
        for func in reversed(self.funcs[:-1]):
            if res is None:
                break
            res = func(res)
        return res


def from_bytes(arg):
    return int.from_bytes(arg, byteorder='little')


def quantity_to_bytes(quantity):
    return (int(quantity*1000000)).to_bytes(6, byteorder='little')


def price_to_bytes(price):
    return (int(price*100)).to_bytes(5, byteorder='little')


def print_beauty_bytes(bytearr):
    print('Ответ ККТ: ')
    print(''.join('x{:02x} '.format(x) for x in bytearr))


def kkt_flag_converse(flags):
    flags_value = {}
    for i in enumerate(kkt_flags):
        result = from_bytes(flags)
        result = "{0:b}".format(result)
        result = result.rjust(13, '0')
        if result[-(i[1]+1)] == '1':
            flags_value[kkt_flags.get(i[1])] = 'да'
        else:
            flags_value[kkt_flags.get(i[1])] = 'нет'
    return flags_value


def decode_software_ver(text):
    text = text.decode('cp1251')
    return text[0]+r'.'+text[1]


def date_converse(date_bytes):
    date = {
        'день': date_bytes[0],
        'месяц': date_bytes[1],
        'год': date_bytes[2]
    }
    return date


def time_converse(time_bytes):
    time = {
        'часы': time_bytes[0],
        'минуты': time_bytes[1],
        'секунды': time_bytes[2]
    }
    return time


def load_bmp():
    with BytesIO() as output:
        from PIL import Image
        with Image.open("000.bmp") as img:
            img.convert('RGB').save(output, 'BMP')
        data = output.getvalue()
        width = int.from_bytes(data[18:22], byteorder='little')
        height = int.from_bytes(data[22:26], byteorder='little')
    data = data[54:(len(data) - 5)]
    return data, width, height
