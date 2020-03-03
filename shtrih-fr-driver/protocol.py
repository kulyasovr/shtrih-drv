import time
from connection import Connection
import lists
from handlers import *


class Protocol(Connection):

    timeout_rndis = 0.01
    password = b'\x1e\x00\x00\x00'
    # password = b''
    STX = b'\x02'
    ENQ = b'\x05'
    ACK = b'\x06'
    NAC = b'\x15'
    command_body = b''

    def __init__(self):
        Connection.__init__(self, '')

    def control_byte(self, byte_arr):
        """
        рассчет контрольной суммы
        """
        control = 0x00
        for byte in range(0, len(byte_arr)):
            control = control ^ byte_arr[byte]

        return bytes([control])

    def command_formation(self, command_name, command_body):
        """
        склейка команды
        """
        # print(len(command_name), len(self.password), len(command_body))
        length = bytes([len(command_name) + len(self.password) + len(command_body)])
        lrc = self.control_byte(length + command_name + self.password + command_body)
        command_full = self.STX + length + command_name + self.password + command_body + lrc

        return command_full

    def first_require(self):
        """
        инициализация ККТ
        """
        self.con_out(self.ENQ)
        if self.con_in(1) == self.ACK:
            self.kkt_answer()

    def kkt_answer(self):
        """
        обработка ответа ККТ
        """
        stx = self.con_in(1)
        while stx == b'':
            stx = self.con_in(1)
        length = self.con_in(1)
        payload = self.con_in(from_bytes(length))
        lrc = self.con_in(1)

        # print_beauty_bytes(stx + length + payload + lrc)

        if self.mode == 'soft':
            print(f'   принят STX: {stx}\n'
                  f'   принят LENGTH: {length}\n'
                  f'   принят PAYLOAD: {payload}\n'
                  f'   принят LRC: {lrc}\n')

        return payload

    def send_command(self, command):
        """
        отправка команды на ККТ
        """
        self.con_out(command)
        outack = self.con_in(1)
        payload = self.kkt_answer()
        self.con_out(self.ACK)

        return payload

    def command(self, com_name, command_body):
        """
        обработка команды
        """
        print("Команда: ", lists.commands.get(com_name))
        # print(len(command_body))
        payload = self.send_command(self.command_formation(com_name, command_body))
        self.con_in(1)

        if com_name in lists.print_string_list and self.connection_type == 'rndis':
            time.sleep(self.timeout_rndis)
        elif com_name in lists.print_list:
            self.print_status()

        return payload

    def print_status(self):
        """
        ожидание завершения печати
        """
        if self.mode == 'soft':
            payload = self.command(b'\x10', b'')
        else:
            payload = self.send_command(self.command_formation(b'\x10', b''))
            self.con_in(1)
        mode = from_bytes(payload[5:6])
        submode = from_bytes(payload[6:7])
        if mode == 10:
            if submode == 5:
                time.sleep(2)
                self.print_status()
        elif submode == 5:
            time.sleep(0.15)
            self.print_status()
