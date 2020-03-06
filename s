[33mcommit 300ad5963adf164e988b976d654e8eaa725d5255[m[33m ([m[1;36mHEAD -> [m[1;32mmaster[m[33m, [m[1;33mtag: v0.1.0[m[33m, [m[1;31mrk/master[m[33m)[m
Author: kulyasovr <kulyasovrom@gmail.com>
Date:   Tue Mar 3 13:14:05 2020 +0300

    Version 0.1.0 release

[1mdiff --git a/shtrih-fr-driver/answers.py b/shtrih-fr-driver/answers.py[m
[1mnew file mode 100644[m
[1mindex 0000000..ebd7e19[m
[1m--- /dev/null[m
[1m+++ b/shtrih-fr-driver/answers.py[m
[36m@@ -0,0 +1,220 @@[m
[32m+[m[32mfrom handlers import *[m
[32m+[m[32mimport lists[m
[32m+[m
[32m+[m
[32m+[m[32mclass Answer(object):[m
[32m+[m[32m    @staticmethod[m
[32m+[m[32m    def separator(payload):[m
[32m+[m[32m        result = {}[m
[32m+[m[32m        # print(payload[0:1])[m
[32m+[m[32m        # print(payload[0:2])[m
[32m+[m[32m        if payload[0:1] == b'\xFF':[m
[32m+[m[32m            # print('1111111111')[m
[32m+[m[32m            command_name = answer_list.get(payload[0:2])[m
[32m+[m[32m        # elif payload[0:1] == b'\xFE':[m
[32m+[m[32m        #     print('2222222222')[m
[32m+[m[32m        #     command_name = answer_list.get(payload[0:2])[m
[32m+[m[32m        else:[m
[32m+[m[32m            # print('3333333333')[m
[32m+[m[32m            command_name = answer_list.get(payload[0:1])[m
[32m+[m[32m        # print(command_name)[m
[32m+[m[32m        for desc, section, func in command_name:[m
[32m+[m[32m            value = func(payload[section])[m
[32m+[m[32m            result[desc] = value[m
[32m+[m[32m        print(result, '\n-----------------------------------------')[m
[32m+[m[32m        return result[m
[32m+[m
[32m+[m
[32m+[m[32manswer_list = {[m
[32m+[m[32m    b'\x10': ([m
[32m+[m[32m        ('Код ошибки: ', slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ('Порядковый номер оператора: ', slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ('Флаги: ', slice(3, 5), FunctionSave(kkt_flag_converse)),[m
[32m+[m[32m        ('Режим: ', slice(5, 6), FunctionSave(lists.kkt_mode_dict.get)),[m
[32m+[m[32m        ('Подрежим: ', slice(6, 7), FunctionSave(lists.kkt_submode_dict.get))[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x11': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Версия ПО ККТ: ", slice(3, 5), FunctionSave(decode_software_ver)),[m
[32m+[m[32m        ("Сборка ПО ККТ: ", slice(5, 7), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Дата ПО ККТ: ", slice(7, 10), FunctionSave(date_converse)),[m
[32m+[m[32m        ("Номер в зале: ", slice(10, 11), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Сквозной номер текущего документа: ", slice(11, 13), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Флаги: ", slice(13, 15), FunctionSave(kkt_flag_converse)),[m
[32m+[m[32m        ("Режим:", slice(15, 16), FunctionSave(lists.kkt_mode_dict.get)),[m
[32m+[m[32m        ("Подрежим: ", slice(16, 17), FunctionSave(lists.kkt_submode_dict.get)),[m
[32m+[m[32m        ("Порт ККТ: ", slice(17, 18), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Дата: ", slice(25, 28), FunctionSave(date_converse)),[m
[32m+[m[32m        ("Время: ", slice(28, 31), FunctionSave(time_converse)),[m
[32m+[m[32m        ("Заводской номер: ", slice(32, 36), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Номер последней закрытой смены: ", slice(36, 38), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Количество перерегистраций (фискализаций): ", slice(40, 41), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Количество оставшихся перерегистраций (фискализаций): ", slice(41, 42), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("ИНН: ", slice(42, 47), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x12': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x13': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x17': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x18': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Сквозной номер документа: ", slice(3, 5), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x19': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x1E': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x1F': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Значение: ", slice(2, 43), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x21': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x22': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x23': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x24': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x25': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x26': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Ширина области печати в точках: ", slice(2, 4), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Ширина символа с учетом межсимвольного интервала в точках: ", slice(4, 5), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Высота символа с учетом межстрочного интервала в точках: ", slice(5, 6), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Количество шрифтов в ККТ: ", slice(6, 7), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x29': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x2B': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x2D': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Название таблицы: ", slice(2, 43), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Количество рядов: ", slice(43, 45), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Количество полей: ", slice(45, 46), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x2E': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Название поля: ", slice(2, 42), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Тип поля: ", slice(42, 43), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x2F': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x40': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x41': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x42': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x43': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x44': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x52': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Сквозной номер документа: ", slice(3, 5), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x54': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Сквозной номер документа: ", slice(3, 5), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x88': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x8C': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\x8D': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xB0': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xC0': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xC1': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xC2': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Порядковый номер оператора: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xE0': ([m
[32m+[m[32m        ("sПорядковый номер оператора: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFF\x0C': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFF\x35': ([m
[32m+[m[32m        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFF\x45': ([m
[32m+[m[32m        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Сдача: ", slice(3, 8), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Номер ФД: ", slice(8, 12), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Фискальный признак: ", slice(12, 16), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Дата и время: ", slice(16, 21), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFF\x46': ([m
[32m+[m[32m        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFF\x4A': ([m
[32m+[m[32m        ("Код ошибки: ", slice(2, 3), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Номер чека: ", slice(3, 5), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Номер ФД: ", slice(5, 9), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Фискальный признак: ", slice(9, 13), FunctionSave(from_bytes)),[m
[32m+[m[32m        ("Дата и время: ", slice(13, 18), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFF\x4D': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m    b'\xFE': ([m
[32m+[m[32m        ("Код ошибки: ", slice(1, 2), FunctionSave(from_bytes)),[m
[32m+[m[32m    ),[m
[32m+[m[32m}[m
[1mdiff --git a/shtrih-fr-driver/commands.py b/shtrih-fr-driver/commands.py[m
[1mnew file mode 100644[m
[1mindex 0000000..4853f72[m
[1m--- /dev/null[m
[1m+++ b/shtrih-fr-driver/commands.py[m
[36m@@ -0,0 +1,495 @@[m
[32m+[m[32mfrom protocol import Protocol[m
[32m+[m[32mfrom answers import Answer[m
[32m+[m[32mfrom handlers import price_to_bytes, load_bmp, quantity_to_bytes[m
[32m+[m[32mfrom tags import tag[m
[32m+[m
[32m+[m
[32m+[m[32mclass Commands(Protocol):[m
[32m+[m[32m    def __init__(self):[m
[32m+[m[32m        Protocol.__init__(self)[m
[32m+[m
[32m+[m[32m    def short_state(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        10h Короткий запрос состояния[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x10',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def long_state(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        11h Запрос состояния ККТ[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x11',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def fat_string_print(self, text, flags=2):[m
[32m+[m[32m        """[m
[32m+[m[32m        12h Печать жирной строки(шрифт 2)[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x12',[m
[32m+[m[32m            bytes([flags]) +[m
[32m+[m[32m            bytes(text.encode('cp1251'))[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def beep(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        13h Гудок[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x13',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def tech_reset(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        16h Технологическое обнуление[m
[32m+[m[32m        """[m
[32m+[m[32m        pass[m
[32m+[m
[32m+[m[32m    def print_string(self, text):[m
[32m+[m[32m        """[m
[32m+[m[32m        17h Печать стандартной строки (шрифт 1)[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x17',[m
[32m+[m[32m            b'\x02' +[m
[32m+[m[32m            bytes(text.encode('cp1251'))[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def print_header(self, zagolovok, number=1):[m
[32m+[m[32m        """[m
[32m+[m[32m        18h Печать заголовка документа[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x18',[m
[32m+[m[32m            bytes(zagolovok.encode('cp1251')).ljust(30, b'\x00') +[m
[32m+[m[32m            number.to_bytes(2, byteorder='little')[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def test_print(self, period=1):[m
[32m+[m[32m        """[m
[32m+[m[32m        19h Тестовый прогон[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x19',[m
[32m+[m[32m            bytes([period])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def table_write(self, variable, table, field, column=1):[m
[32m+[m[32m        """[m
[32m+[m[32m        1Eh Запись таблицы[m
[32m+[m[32m        """[m
[32m+[m[32m        if self.table_field_struct(table, field).get('Тип поля: ') == 0:[m
[32m+[m[32m            # variable = bytes([variable])[m
[32m+[m[32m            variable = variable.to_bytes(2, byteorder='little')[m
[32m+[m[32m        else:[m
[32m+[m[32m            variable = bytes(variable.encode('cp1251'))[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x1E',[m
[32m+[m[32m            bytes([table]) +[m
[32m+[m[32m            column.to_bytes(2, byteorder='little') +[m
[32m+[m[32m            bytes([field]) +[m
[32m+[m[32m            variable[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def table_read(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        1Fh Чтение таблицы[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x1F',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def time_prog(self, hour, minute, sec):[m
[32m+[m[32m        """[m
[32m+[m[32m        21h Программирование времени[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x21',[m
[32m+[m[32m            bytes([hour]) +[m
[32m+[m[32m            bytes([minute]) +[m
[32m+[m[32m            bytes([sec])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def date_prog(self, year, month, day):[m
[32m+[m[32m        """[m
[32m+[m[32m        22h Программирование даты[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x22',[m
[32m+[m[32m            bytes([day]) +[m
[32m+[m[32m            bytes([month]) +[m
[32m+[m[32m            bytes([year])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def date_prog_accept(self, year, month, day):[m
[32m+[m[32m        """[m
[32m+[m[32m        23h Подтверждение программирования даты[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x23',[m
[32m+[m[32m            bytes([day]) +[m
[32m+[m[32m            bytes([month]) +[m
[32m+[m[32m            bytes([year])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def table_init(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        24h Инициализация таблиц начальными значениями[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x24',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def cut(self, cut_type=0):[m
[32m+[m[32m        """[m
[32m+[m[32m        25h Отрезка чека[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x25',[m
[32m+[m[32m            bytes([cut_type])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def read_font_properties(self, font):[m
[32m+[m[32m        """[m
[32m+[m[32m        26h	Прочитать параметры шрифта[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x26',[m
[32m+[m[32m            bytes([font])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def move(self, string_quantity, flags=1):[m
[32m+[m[32m        """[m
[32m+[m[32m        29h Протяжка[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x29',[m
[32m+[m[32m            bytes([flags]) +[m
[32m+[m[32m            bytes([string_quantity])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def test_print_stop(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        2Bh Прерывание тестового прогона[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x2B',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def table_struct(self, table):[m
[32m+[m[32m        """[m
[32m+[m[32m        2Dh Запрос структуры таблицы[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x2D',[m
[32m+[m[32m            bytes([table])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def table_field_struct(self, table, field):[m
[32m+[m[32m        """[m
[32m+[m[32m        2Eh Запрос структуры поля[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x2E',[m
[32m+[m[32m            bytes([table]) +[m
[32m+[m[32m            bytes([field])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def print_default_font_string(self, font, text, flags=2):[m
[32m+[m[32m        """[m
[32m+[m[32m        2Fh Печать строки данным шрифтом[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x2F',[m
[32m+[m[32m            bytes([flags]) +[m
[32m+[m[32m            bytes([font]) +[m
[32m+[m[32m            bytes(text.encode('cp1251'))[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def report_no_close(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        40h Суточный отчет без гашения[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x40',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def close_session(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        41h Суточный отчет с гашением[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x41',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def department_report(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        42h Отчет по отделам[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x42',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def tax_report(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        43h Отчет по налогам[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x43',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def cashier_report(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        44h Отчет по кассирам[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x44',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    # 4Eh Загрузка графики-5121[m
[32m+[m[32m    # 4Dh Печать графики-512 с масштабированием1[m
[32m+[m
[32m+[m[32m    def cliche(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        52h Печать клише[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x52',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def print_advertising(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        54h Печать рекламного текста[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x54',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def check_cancellation(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        88h Аннулирование чека[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x88',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def print_copy(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        8Ch Печать копии чека (Повтор документа)[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x8C',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def open_check(self, doc_type=0):[m
[32m+[m[32m        """[m
[32m+[m[32m        8Dh Открыть чек[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\x8D',[m
[32m+[m[32m            bytes([doc_type])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def continue_print(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        B0h Продолжение печати[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xB0',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def graph_load(self, graphic_data):[m
[32m+[m[32m        """[m
[32m+[m[32m        С0h Загрузка графики (1 строка)[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xC0',[m
[32m+[m[32m            graphic_data[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def graph_full_load(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        Полная загрузка графики[m
[32m+[m[32m        """[m
[32m+[m[32m        data, width, height = load_bmp()[m
[32m+[m[32m        for i in range(height):[m
[32m+[m[32m            strin = ''[m
[32m+[m[32m            command = data[:(width * 3)][m
[32m+[m[32m            for j in range(0, len(command), 3):[m
[32m+[m[32m                if command[j] == 255:[m
[32m+[m[32m                    strin += '1'[m
[32m+[m[32m                else:[m
[32m+[m[32m                    strin += '0'[m
[32m+[m[32m            data = data[(width * 3 + 1):][m
[32m+[m[32m            com = int(strin, 2).to_bytes(40, byteorder='little')[m
[32m+[m[32m            com_body = bytes([i+1]) + com[m
[32m+[m[32m            self.graph_load(com_body)[m
[32m+[m
[32m+[m[32m    def graph_print(self, first_line=1, last_line=200):[m
[32m+[m[32m        """[m
[32m+[m[32m        С1h Печать графики[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xC1',[m
[32m+[m[32m            bytes([first_line]) +[m
[32m+[m[32m            bytes([last_line])[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def ean_13(self, code):[m
[32m+[m[32m        """[m
[32m+[m[32m        С2h Печать штрих-кода EAN-13[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xC2',[m
[32m+[m[32m            code.to_bytes(5, byteorder='little')[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def open_session(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        E0h Открыть смену[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xE0',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    # FF01h	Запрос статуса ФН[m
[32m+[m[32m    # FF02h	Запрос номера ФН[m
[32m+[m[32m    # FF03h	Запрос срока действия ФН[m
[32m+[m[32m    # FF04h	Запрос версии ФН[m
[32m+[m[32m    # FF07h	Сброс состояния ФН[m
[32m+[m[32m    # FF08h	Отменить документ в ФН[m
[32m+[m
[32m+[m[32m    def tlv_send(self, tag_name, body):[m
[32m+[m[32m        """[m
[32m+[m[32m        FF0Ch Передать произвольную TLV структуру[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xFF\x0C',[m
[32m+[m[32m            tag_name.to_bytes(2, byteorder='little') +[m
[32m+[m[32m            len(body).to_bytes(2, byteorder='little') +[m
[32m+[m[32m            tag(tag_name, body)[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def open_correction(self):[m
[32m+[m[32m        """[m
[32m+[m[32m        FF35h Начать формирование чека коррекции[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xFF\x35',[m
[32m+[m[32m            b''[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def close_check_v2(self, s1, text, s2=0, s3=0, s4=0, s5=0,[m
[32m+[m[32m                       s6=0, s7=0, s8=0, s9=0, s10=0, s11=0,[m
[32m+[m[32m                       s12=0, s13=0, s14=0, s15=0, s16=0,[m
[32m+[m[32m                       okrug=0, tax1=0, tax2=0, otax3=0,[m
[32m+[m[32m                       otax4=0, tax5=0, tax6=0, nalog=1):[m
[32m+[m[32m        """[m
[32m+[m[32m        FF45h Закрытие чека расширенное вариант №2[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xFF\x45',[m
[32m+[m[32m            price_to_bytes(s1) +[m
[32m+[m[32m            price_to_bytes(s2) +[m
[32m+[m[32m            price_to_bytes(s3) +[m
[32m+[m[32m            price_to_bytes(s4) +[m
[32m+[m[32m            price_to_bytes(s5) +[m
[32m+[m[32m            price_to_bytes(s6) +[m
[32m+[m[32m            price_to_bytes(s7) +[m
[32m+[m[32m            price_to_bytes(s8) +[m
[32m+[m[32m            price_to_bytes(s9) +[m
[32m+[m[32m            price_to_bytes(s10) +[m
[32m+[m[32m            price_to_bytes(s11) +[m
[32m+[m[32m            price_to_bytes(s12) +[m
[32m+[m[32m            price_to_bytes(s13) +[m
[32m+[m[32m            price_to_bytes(s14) +[m
[32m+[m[32m            price_to_bytes(s15) +[m
[32m+[m[32m            price_to_bytes(s16) +[m
[32m+[m[32m            okrug.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            price_to_bytes(tax1) +[m
[32m+[m[32m            price_to_bytes(tax2) +[m
[32m+[m[32m            price_to_bytes(otax3) +[m
[32m+[m[32m            price_to_bytes(otax4) +[m
[32m+[m[32m            price_to_bytes(tax5) +[m
[32m+[m[32m            price_to_bytes(tax6) +[m
[32m+[m[32m            nalog.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            bytes(text.encode('cp1251'))[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def operation_v2(self, quantity, price, name, doc_type=1,[m
[32m+[m[32m                     oper_sum=10995116277.75, tax=10995116277.75,[m
[32m+[m[32m                     tax_rate=1, section=4, sposob=1, predmet=1):[m
[32m+[m[32m        """[m
[32m+[m[32m        FF46h Операция V2[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xFF\x46',[m
[32m+[m[32m            doc_type.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            quantity_to_bytes(quantity) +[m
[32m+[m[32m            price_to_bytes(price) +[m
[32m+[m[32m            price_to_bytes(oper_sum) +[m
[32m+[m[32m            price_to_bytes(tax) +[m
[32m+[m[32m            tax_rate.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            section.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            sposob.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            predmet.to_bytes(1, byteorder='big') +[m
[32m+[m[32m            bytes(name.encode('cp1251'))[m
[32m+[m[32m        ))[m
[32m+[m
[32m+[m[32m    def correction_close(self, summa, type=0, priznak=1,[m
[32m+[m[32m                         summa_nal=1, sum_card=2, sum_pred=3,[m
[32m+[m[32m                         sum_post=4, sum_vstrech=5, sum_20=6,[m
[32m+[m[32m                         sum_10=7, sum_0=8, sum_bez=9,[m
[32m+[m[32m                         sum_20_120=10, sum_10_110=11, sist_nalog=3):[m
[32m+[m[32m        """[m
[32m+[m[32m        FF4Ah Сформировать чек коррекции V2[m
[32m+[m[32m        """[m
[32m+[m[32m        return Answer.separator(self.command([m
[32m+[m[32m            b'\xFF\x4A',[m
[32m+[m[32m            bytes([type]) +[m
[32m+[m[32m            bytes([priznak]) +[m
[32m+[m[32m            price_to_bytes(summa) +[m
[32m+[m[32m            price_to_bytes(summa_nal) +[m
[32m+[m[32m            price_to_bytes(sum_card) +[m
[32m+[m[32m            price_to_bytes(sum_pred) +[m
[32m+[m[32m            price_to_bytes(sum_post) +[m
[32m+[m[32m            price_to_bytes(sum_vstrech) +[m
[32m+[m[32m            price_to_bytes(sum_20) +[m
[32m+[m[32m            price_to_bytes(sum_10) +[m
[32m+[m[32m            price_to_bytes(sum_0) +[m
[32m+[m[32m            price_to_bytes(sum_bez) +[m
[32m+[m[32m       