# Source: https://github.com/sventhijssen/pgmtocnf
# Authors: Sven Thijssen and Gillis Hermans

class Literal():
    def __init__(self, name, positive=True):
        super(Literal, self).__init__()
        self.atom = name
        self.positive = positive

    def __str__(self):
        if self.positive:
            return str(self.atom)
        elif self.atom == 'False':
            return str(self.atom)
        else:
            return "\\+" + str(self.atom)

    def __repr__(self):
        if self.positive:
            return str(self.atom)
        elif self.atom == 'False':
            return str(self.atom)
        else:
            return "\\+" + str(self.atom)

    def __eq__(self, other):
        if isinstance(other, Literal):
            return self.atom == other.atom and self.positive == other.positive
        return False

    def __hash__(self):
        return hash(self.atom)

    def negate(self):
        if self.positive:
            return Literal(self.atom, False)
        return Literal(self.atom, True)
