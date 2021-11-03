import os
from os.path import exists


class Log:

    def __init__(self, log_file_name: str = None):
        self.log_file_name = log_file_name

        if self.log_file_name is not None and exists(log_file_name):
            os.remove(log_file_name)

        if self.log_file_name is not None:
            f = open(log_file_name, 'x')
            f.close()

        self.content = ''

    def add(self, content):
        if self.log_file_name is not None:
            self.content += content

            with open(self.log_file_name, "a") as f:
                f.write(content)

    def write(self, content):
        pass
