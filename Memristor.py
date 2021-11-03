from Literal import Literal


class Memristor:

    def __init__(self, row: int, column: int, literal: Literal):
        self.row = row
        self.column = column
        self.literal = literal

    def __str__(self):
        return str(self.literal)

    def __repr__(self):
        return str(self.literal)
