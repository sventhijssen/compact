import re


class InstanceFileReader:

    def __init__(self, simulation_file_name: str):
        self.simulation_file_name = simulation_file_name
        file = open(self.simulation_file_name, 'r')
        self.content = file.read()
        file.close()

    def parse(self):
        instance = dict()
        raw_instance = re.findall(r'([\w\d\[\]]+)\s+([01])', self.content)
        for pair in raw_instance:
            input_variable = pair[0]
            value = pair[1]
            instance[input_variable] = bool(int(value))
        return instance
