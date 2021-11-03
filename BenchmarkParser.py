from abc import abstractmethod, ABC
from pathlib import Path


class BenchmarkParser(ABC):

    def __init__(self):
        self.file_path = None
        self.benchmark = None
        self.content = ''

    def read_file(self, file_path: Path):
        self.file_path = file_path
        file = open(self.file_path, 'r')
        self.content = file.read()
        file.close()

    @abstractmethod
    def parse(self):
        pass
