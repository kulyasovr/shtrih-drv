import serial
import socket


class Connection(object):

    def __init__(self, com):
        self.com = com
        self.connection_type = 'serial'
        # self.connection_type = 'tcp'
        # self.mode = 'clean'
        self.mode = 'soft'

    def connect(self):
        try:
            if self.connection_type == 'serial':
                self.com = serial.Serial('COM11', 115200, timeout=0.003)
                self.con_in = self.com.read
                self.con_out = self.com.write
                return self.com
            elif self.connection_type == 'tcp':
                self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                # self.s.connect(('192.168.137.111', 7778))
                self.s.connect(('192.168.1.9', 7778))
                self.con_in = self.s.recv
                self.con_out = self.s.send
                return self.s
        except serial.SerialException:
            print("Не могу подключиться к кассе.")

    def disconnect(self):
        if self.connection_type == 'serial':
            self.com.close()
        elif self.connection_type == 'tcp':
            self.s.close()
