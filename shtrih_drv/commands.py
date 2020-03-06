from protocol import Protocol
from answers import Answer
from handlers import price_to_bytes, load_bmp, quantity_to_bytes
from tags import tag


class Commands(Protocol):
    def __init__(self):
        Protocol.__init__(self)

    def short_state(self):
        """
        10h Короткий запрос состояния
        """
        return Answer.separator(self.command(
            b'\x10',
            b''
        ))

    def long_state(self):
        """
        11h Запрос состояния ККТ
        """
        return Answer.separator(self.command(
            b'\x11',
            b''
        ))

    def fat_string_print(self, text, flags=2):
        """
        12h Печать жирной строки(шрифт 2)
        """
        return Answer.separator(self.command(
            b'\x12',
            bytes([flags]) +
            bytes(text.encode('cp1251'))
        ))

    def beep(self):
        """
        13h Гудок
        """
        return Answer.separator(self.command(
            b'\x13',
            b''
        ))

    def tech_reset(self):
        """
        16h Технологическое обнуление
        """
        pass

    def print_string(self, text):
        """
        17h Печать стандартной строки (шрифт 1)
        """
        return Answer.separator(self.command(
            b'\x17',
            b'\x02' +
            bytes(text.encode('cp1251'))
        ))

    def print_header(self, text, number=1):
        """
        18h Печать заголовка документа
        """
        return Answer.separator(self.command(
            b'\x18',
            bytes(text.encode('cp1251')).ljust(30, b'\x00') +
            number.to_bytes(2, byteorder='little')
        ))

    def test_print(self, period=1):
        """
        19h Тестовый прогон
        """
        return Answer.separator(self.command(
            b'\x19',
            bytes([period])
        ))

    def table_write(self, variable, table, field, column=1):
        """
        1Eh Запись таблицы
        """
        if self.table_field_struct(table, field).get('Тип поля: ') == 0:
            # variable = bytes([variable])
            variable = variable.to_bytes(2, byteorder='little')
        else:
            variable = bytes(variable.encode('cp1251'))
        return Answer.separator(self.command(
            b'\x1E',
            bytes([table]) +
            column.to_bytes(2, byteorder='little') +
            bytes([field]) +
            variable
        ))

    def table_read(self):
        """
        1Fh Чтение таблицы
        """
        return Answer.separator(self.command(
            b'\x1F',
            b''
        ))

    def time_prog(self, hour, minute, sec):
        """
        21h Программирование времени
        """
        return Answer.separator(self.command(
            b'\x21',
            bytes([hour]) +
            bytes([minute]) +
            bytes([sec])
        ))

    def date_prog(self, year, month, day):
        """
        22h Программирование даты
        """
        return Answer.separator(self.command(
            b'\x22',
            bytes([day]) +
            bytes([month]) +
            bytes([year])
        ))

    def date_prog_accept(self, year, month, day):
        """
        23h Подтверждение программирования даты
        """
        return Answer.separator(self.command(
            b'\x23',
            bytes([day]) +
            bytes([month]) +
            bytes([year])
        ))

    def table_init(self):
        """
        24h Инициализация таблиц начальными значениями
        """
        return Answer.separator(self.command(
            b'\x24',
            b''
        ))

    def cut(self, cut_type=0):
        """
        25h Отрезка чека
        """
        return Answer.separator(self.command(
            b'\x25',
            bytes([cut_type])
        ))

    def read_font_properties(self, font):
        """
        26h	Прочитать параметры шрифта
        """
        return Answer.separator(self.command(
            b'\x26',
            bytes([font])
        ))

    def move(self, string_quantity, flags=1):
        """
        29h Протяжка
        """
        return Answer.separator(self.command(
            b'\x29',
            bytes([flags]) +
            bytes([string_quantity])
        ))

    def test_print_stop(self):
        """
        2Bh Прерывание тестового прогона
        """
        return Answer.separator(self.command(
            b'\x2B',
            b''
        ))

    def table_struct(self, table):
        """
        2Dh Запрос структуры таблицы
        """
        return Answer.separator(self.command(
            b'\x2D',
            bytes([table])
        ))

    def table_field_struct(self, table, field):
        """
        2Eh Запрос структуры поля
        """
        return Answer.separator(self.command(
            b'\x2E',
            bytes([table]) +
            bytes([field])
        ))

    def print_default_font_string(self, font, text, flags=2):
        """
        2Fh Печать строки данным шрифтом
        """
        return Answer.separator(self.command(
            b'\x2F',
            bytes([flags]) +
            bytes([font]) +
            bytes(text.encode('cp1251'))
        ))

    def report_no_close(self):
        """
        40h Суточный отчет без гашения
        """
        return Answer.separator(self.command(
            b'\x40',
            b''
        ))

    def close_session(self):
        """
        41h Суточный отчет с гашением
        """
        return Answer.separator(self.command(
            b'\x41',
            b''
        ))

    def department_report(self):
        """
        42h Отчет по отделам
        """
        return Answer.separator(self.command(
            b'\x42',
            b''
        ))

    def tax_report(self):
        """
        43h Отчет по налогам
        """
        return Answer.separator(self.command(
            b'\x43',
            b''
        ))

    def cashier_report(self):
        """
        44h Отчет по кассирам
        """
        return Answer.separator(self.command(
            b'\x44',
            b''
        ))

    # 4Eh Загрузка графики-5121
    # 4Dh Печать графики-512 с масштабированием1

    def cliche(self):
        """
        52h Печать клише
        """
        return Answer.separator(self.command(
            b'\x52',
            b''
        ))

    def print_advertising(self):
        """
        54h Печать рекламного текста
        """
        return Answer.separator(self.command(
            b'\x54',
            b''
        ))

    def check_cancellation(self):
        """
        88h Аннулирование чека
        """
        return Answer.separator(self.command(
            b'\x88',
            b''
        ))

    def print_copy(self):
        """
        8Ch Печать копии чека (Повтор документа)
        """
        return Answer.separator(self.command(
            b'\x8C',
            b''
        ))

    def open_check(self, doc_type=0):
        """
        8Dh Открыть чек
        """
        return Answer.separator(self.command(
            b'\x8D',
            bytes([doc_type])
        ))

    def continue_print(self):
        """
        B0h Продолжение печати
        """
        return Answer.separator(self.command(
            b'\xB0',
            b''
        ))

    def graph_load(self, graphic_data):
        """
        С0h Загрузка графики (1 строка)
        """
        return Answer.separator(self.command(
            b'\xC0',
            graphic_data
        ))

    def graph_full_load(self):
        """
        Полная загрузка графики
        """
        data, width, height = load_bmp()
        for i in range(height):
            strin = ''
            command = data[:(width * 3)]
            for j in range(0, len(command), 3):
                if command[j] == 255:
                    strin += '1'
                else:
                    strin += '0'
            data = data[(width * 3 + 1):]
            com = int(strin, 2).to_bytes(40, byteorder='little')
            com_body = bytes([i+1]) + com
            self.graph_load(com_body)

    def graph_print(self, first_line=1, last_line=200):
        """
        С1h Печать графики
        """
        return Answer.separator(self.command(
            b'\xC1',
            bytes([first_line]) +
            bytes([last_line])
        ))

    def ean_13(self, code):
        """
        С2h Печать штрих-кода EAN-13
        """
        return Answer.separator(self.command(
            b'\xC2',
            code.to_bytes(5, byteorder='little')
        ))

    def open_session(self):
        """
        E0h Открыть смену
        """
        return Answer.separator(self.command(
            b'\xE0',
            b''
        ))

    # FF01h	Запрос статуса ФН
    # FF02h	Запрос номера ФН
    # FF03h	Запрос срока действия ФН
    # FF04h	Запрос версии ФН
    # FF07h	Сброс состояния ФН
    # FF08h	Отменить документ в ФН

    def tlv_send(self, tag_name, body):
        """
        FF0Ch Передать произвольную TLV структуру
        """
        return Answer.separator(self.command(
            b'\xFF\x0C',
            tag_name.to_bytes(2, byteorder='little') +
            len(body).to_bytes(2, byteorder='little') +
            tag(tag_name, body)
        ))

    def open_correction(self):
        """
        FF35h Начать формирование чека коррекции
        """
        return Answer.separator(self.command(
            b'\xFF\x35',
            b''
        ))

    def close_check_v2(self, s1, text, s2=0, s3=0, s4=0, s5=0,
                       s6=0, s7=0, s8=0, s9=0, s10=0, s11=0,
                       s12=0, s13=0, s14=0, s15=0, s16=0,
                       okrug=0, tax1=0, tax2=0, otax3=0,
                       otax4=0, tax5=0, tax6=0, nalog=1):
        """
        FF45h Закрытие чека расширенное вариант №2
        """
        return Answer.separator(self.command(
            b'\xFF\x45',
            price_to_bytes(s1) +
            price_to_bytes(s2) +
            price_to_bytes(s3) +
            price_to_bytes(s4) +
            price_to_bytes(s5) +
            price_to_bytes(s6) +
            price_to_bytes(s7) +
            price_to_bytes(s8) +
            price_to_bytes(s9) +
            price_to_bytes(s10) +
            price_to_bytes(s11) +
            price_to_bytes(s12) +
            price_to_bytes(s13) +
            price_to_bytes(s14) +
            price_to_bytes(s15) +
            price_to_bytes(s16) +
            okrug.to_bytes(1, byteorder='big') +
            price_to_bytes(tax1) +
            price_to_bytes(tax2) +
            price_to_bytes(otax3) +
            price_to_bytes(otax4) +
            price_to_bytes(tax5) +
            price_to_bytes(tax6) +
            nalog.to_bytes(1, byteorder='big') +
            bytes(text.encode('cp1251'))
        ))

    def operation_v2(self, quantity, price, name, tax_rate=1, doc_type=1,
                     oper_sum=10995116277.75, tax=10995116277.75,
                     section=4, sposob=1, predmet=11):
        """
        FF46h Операция V2
        """
        return Answer.separator(self.command(
            b'\xFF\x46',
            doc_type.to_bytes(1, byteorder='big') +
            quantity_to_bytes(quantity) +
            price_to_bytes(price) +
            price_to_bytes(oper_sum) +
            price_to_bytes(tax) +
            tax_rate.to_bytes(1, byteorder='big') +
            section.to_bytes(1, byteorder='big') +
            sposob.to_bytes(1, byteorder='big') +
            predmet.to_bytes(1, byteorder='big') +
            bytes(name.encode('cp1251'))
        ))

    def correction_close(self, summa, type=0, priznak=1,
                         summa_nal=1, sum_card=2, sum_pred=3,
                         sum_post=4, sum_vstrech=5, sum_20=6,
                         sum_10=7, sum_0=8, sum_bez=9,
                         sum_20_120=10, sum_10_110=11, sist_nalog=3):
        """
        FF4Ah Сформировать чек коррекции V2
        """
        return Answer.separator(self.command(
            b'\xFF\x4A',
            bytes([type]) +
            bytes([priznak]) +
            price_to_bytes(summa) +
            price_to_bytes(summa_nal) +
            price_to_bytes(sum_card) +
            price_to_bytes(sum_pred) +
            price_to_bytes(sum_post) +
            price_to_bytes(sum_vstrech) +
            price_to_bytes(sum_20) +
            price_to_bytes(sum_10) +
            price_to_bytes(sum_0) +
            price_to_bytes(sum_bez) +
            price_to_bytes(sum_20_120) +
            price_to_bytes(sum_10_110) +
            bytes([sist_nalog])
        ))

    def tlv_oper_send(self, tag_name, body):
        """
        FF4Dh Передать произвольную TLV структуру привязанную к операции
        """
        return Answer.separator(self.command(
            b'\xFF\x4D',
            tag_name.to_bytes(2, byteorder='little') +
            len(body).to_bytes(2, byteorder='little') +
            tag(tag_name, body)
        ))

    def marking(self, code):
        """
        FF67 Привязка маркированного товара к позиции
        """
        return Answer.separator(self.command(
            b'\xFF\x67',
            bytes([len(code)]) +
            bytes(code.encode('cp1251'))
        ))

