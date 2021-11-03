import subprocess


class FileMover:

    @staticmethod
    def move(from_file, to_file):
        subprocess.call(['mv', from_file, to_file], stdout=subprocess.DEVNULL)
