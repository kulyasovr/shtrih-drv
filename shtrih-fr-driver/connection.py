import serial
import socket


class Connection(object):

    def __init__(self, com, s):
        self.com = com
        self.s = s
        self.connection_type = ''
        self.connection_type = ''
        self.mode = 'clean'
        # self.mode = 'soft'

    def connect_tcp(self, ip, port):
        self.connection_type = 'tcp'
        try:
            self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.s.connect((ip, port))
            self.con_in = self.s.recv
            self.con_out = self.s.send
            return self.s
        except socket.error as msg:
            print("Ошибка! Не могу подключиться к кассе: ", msg)

    def connect_serial(self, port):
        self.connection_type = 'serial'
        try:
            self.com = serial.Serial(port, 115200, timeout=0.003)
            self.con_in = self.com.read
            self.con_out = self.com.write
            return self.com
        except serial.SerialException as msg:
            print("Ошибка! Не могу подключиться к кассе: ", msg)

    def disconnect(self):
        if self.connection_type == 'serial':
            self.com.close()
        elif self.connection_type == 'tcp':
            self.s.close()

