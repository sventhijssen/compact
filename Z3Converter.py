from pyparsing import Suppress, Forward, Word, Group, ZeroOrMore, alphanums, oneOf, Literal
from z3 import Bool, is_app_of, Z3_OP_XOR, Z3_OP_UNINTERPRETED, is_const, is_not, AstRef, is_and, is_or, ExprRef


class AstRefKey:
    def __init__(self, n):
        self.n = n

    def __hash__(self):
        return self.n.hash()

    def __eq__(self, other):
        return self.n.eq(other.n)

    def __repr__(self):
        return str(self.n)


class Z3Converter:

    @staticmethod
    def verilog_to_tree(verilog_formula: str):
        # Begin Source
        # URL: https://stackoverflow.com/questions/37925803/parserelement-enablepackrat-doesnt-make-infixnotation-faster
        # Author: PaulMcG
        # Published on: June 20, 2016
        # Accessed on: July 15, 2020
        # Begin Source (2): https://stackoverflow.com/questions/23879784/parse-mathematical-expressions-with-pyparsing
        # Author: PaulMcG
        # Published on: May 20, 2014
        # Visited on: July 15, 2020
        LPAR, RPAR = map(Suppress, '()')
        expr = Forward()
        variable = Word(alphanums + '_~' '[' ']')
        nested = variable | Group(LPAR + expr + RPAR)
        binary_op = nested + ZeroOrMore(oneOf('^ | &') + nested)
        ternary_op = nested + Literal('?') + nested + Literal(':') + nested
        formula_expr = ternary_op | binary_op
        expr <<= formula_expr
        verilog_tree = [expr.parseString(verilog_formula).asList()]
        # End Source

        return verilog_tree

    @staticmethod
    def _is_xor(a):
        return is_app_of(a, Z3_OP_XOR)

    @staticmethod
    def _askey(n):
        assert isinstance(n, AstRef)
        return AstRefKey(n)

    @staticmethod
    def _collect(f: Bool) -> str:
        if f is None:
            return ""
        if is_const(f):
            if f.decl().kind() == Z3_OP_UNINTERPRETED:
                return str(Z3Converter._askey(f))
            else:
                return str(f)
        elif is_not(f):
            s = "~"
            for c in f.children():
                s += Z3Converter._collect(c)
            return s
        elif is_and(f):
            return "(" + " & ".join([str(Z3Converter._collect(c)) for c in f.children()]) + ")"
        elif is_or(f):
            return "(" + " | ".join([str(Z3Converter._collect(c)) for c in f.children()]) + ")"
        elif Z3Converter._is_xor(f):
            return "(" + " ^ ".join([str(Z3Converter._collect(c)) for c in f.children()]) + ")"
        elif isinstance(f, ExprRef): # IF statement
            children = list(map(lambda e: Z3Converter._collect(e), f.children()))
            return "(({}) ? ({}) : ({}))".format(children[0], children[1], children[2])
        else:
            raise Exception("Unexpected operator.")
