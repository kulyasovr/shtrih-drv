from handlers import *
import lists


class Answer(object):
    @staticmethod
    def separator(payload):
        result = {}
        if payload[0:1] == b'\xFF':
            command_name = answer_list.get(payload[0:2])
        else:
            command_name = answer_list.get(payload[0:1])
        for desc, section, func in command_name:
            value = func(payload[section])
            result[desc] = value
        print(result, '\n-----------------------------------------')
        return result


answer_list = {
    b'\x10': (
        ('Код ошибки: ', slice(1, 2), FunctionSave(from_bytes)),
        ('Порядковый номер оператора: ', slice(2, 3), FunctionSave(from_bytes)),
        ('Флаги: ', slice(3, 5), FunctionSave(kkt_flag_converse)),
        ('Режим: ', slice(5, 6), FunctionSave(lists.kkt_mode_list.get)),
        ('Подрежим: ', slice(6, 7), FunctionSave(lists.kkt_submode_list.get))
    ),
    b'\x11': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
        ("Версия ПО ККТ: ", slice(3, 5), FunctionSave(decode_software_ver)),
        ("Сборка ПО ККТ: ", slice(5, 7), FunctionSave(from_bytes)),
        ("Дата ПО ККТ: ", slice(7, 10), FunctionSave(date_converse)),
        ("Номер в зале: ", slice(10, 11), FunctionSave(from_bytes)),
        ("Сквозной номер текущего документа: ", slice(11, 13), FunctionSave(from_bytes)),
        ("Флаги: ", slice(13, 15), FunctionSave(kkt_flag_converse)),
        ("Режим:", slice(15, 16), FunctionSave(lists.kkt_mode_list.get)),
        ("Подрежим: ", slice(16, 17), FunctionSave(lists.kkt_submode_list.get)),
        ("Порт ККТ: ", slice(17, 18), FunctionSave(from_bytes)),
        ("Дата: ", slice(25, 28), FunctionSave(date_converse)),
        ("Время: ", slice(28, 31), FunctionSave(time_converse)),
        ("Заводской номер: ", slice(32, 36), FunctionSave(from_bytes)),
        ("Номер последней закрытой смены: ", slice(36, 38), FunctionSave(from_bytes)),
        ("Количество перерегистраций (фискализаций): ", slice(40, 41), FunctionSave(from_bytes)),
        ("Количество оставшихся перерегистраций (фискализаций): ", slice(41, 42), FunctionSave(from_bytes)),
        ("ИНН: ", slice(42, 47), FunctionSave(from_bytes)),
    ),
    b'\x12': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x13': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x17': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x18': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
        ("Сквозной номер документа: ", slice(3, 5), FunctionSave(from_bytes)),
    ),
    b'\x19': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x1E': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
    ),
    b'\x1F': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Значение: ", slice(2, 43), FunctionSave(from_bytes)),
    ),
    b'\x21': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
    ),
    b'\x22': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
    ),
    b'\x23': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
    ),
    b'\x24': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
    ),
    b'\x25': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x26': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Ширина области печати в точках: ", slice(2, 4), FunctionSave(from_bytes)),
        ("Ширина символа с учетом межсимвольного интервала в точках: ", slice(4, 5), FunctionSave(from_bytes)),
        ("Высота символа с учетом межстрочного интервала в точках: ", slice(5, 6), FunctionSave(from_bytes)),
        ("Количество шрифтов в ККТ: ", slice(6, 7), FunctionSave(from_bytes)),
    ),
    b'\x29': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x2B': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x2D': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Название таблицы: ", slice(2, 43), FunctionSave(from_bytes)),
        ("Количество рядов: ", slice(43, 45), FunctionSave(from_bytes)),
        ("Количество полей: ", slice(45, 46), FunctionSave(from_bytes)),
    ),
    b'\x2E': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Название поля: ", slice(2, 42), FunctionSave(from_bytes)),
        ("Тип поля: ", slice(42, 43), FunctionSave(from_bytes)),
    ),
    b'\x2F': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x40': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x41': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x42': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x43': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x44': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x52': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
        ("Сквозной номер документа: ", slice(3, 5), FunctionSave(from_bytes)),
    ),
    b'\x54': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
        ("Сквозной номер документа: ", slice(3, 5), FunctionSave(from_bytes)),
    ),
    b'\x88': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x8C': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\x8D': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xB0': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xC0': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xC1': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xC2': (
        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),
        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xE0': (
        ("sПорядковый номер оператора: ", slice(1, 2), FunctionSave(from_bytes)),
    ),
    b'\xFF\x0C': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xFF\x35': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xFF\x45': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
        ("Сдача: ", slice(3, 8), FunctionSave(from_bytes)),
        ("Номер ФД: ", slice(8, 12), FunctionSave(from_bytes)),
        ("Фискальный признак: ", slice(12, 16), FunctionSave(from_bytes)),
        ("Дата и время: ", slice(16, 21), FunctionSave(from_bytes)),
    ),
    b'\xFF\x46': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xFF\x4A': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
        ("Номер чека: ", slice(3, 5), FunctionSave(from_bytes)),
        ("Номер ФД: ", slice(5, 9), FunctionSave(from_bytes)),
        ("Фискальный признак: ", slice(9, 13), FunctionSave(from_bytes)),
        ("Дата и время: ", slice(13, 18), FunctionSave(from_bytes)),
    ),
    b'\xFF\x4D': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
    b'\xFF\x67': (
        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),
    ),
}
