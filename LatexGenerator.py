import os
import subprocess


class LatexGenerator:

    @staticmethod
    def generate(benchmark_name: str, content: str):
        file_name = benchmark_name + ".tex"
        with open(file_name, 'w') as f:
            f.write(content)
        subprocess.call(["lualatex", file_name], stdout=subprocess.DEVNULL)

        extensions = ["aux", "log", "tex"]
        for extension in extensions:
            file = "{}.{}".format(benchmark_name, extension)
            os.remove(str(file))
