from z3 import Not, And, Or, Bool, Xor, If


class Z3Converter:

    @staticmethod
    def verilog_to_z3(lst):
        """
        Returns a formula in Verilog to a formula compatible with Z3.
        :param lst:
        :return:
        """
        if not lst:
            return Or()

        if isinstance(lst, str):
            if lst[0] == '~':
                return Not(Bool(lst[1:]))
            return Bool(lst)
        if len(lst) == 1:
            return Z3Converter.verilog_to_z3(lst[0])
        elif len(lst) >= 3 and lst[1] == '^':
            expressions = [lst[i] for i in range(0, len(lst), 2)]
            z3_expressions = list(map(lambda e: Z3Converter.verilog_to_z3(e), expressions))
            # left = lst[0]
            # right = lst[2]
            return Xor(*z3_expressions)
        elif len(lst) >= 3 and lst[1] == '&':
            expressions = [lst[i] for i in range(0, len(lst), 2)]
            z3_expressions = list(map(lambda e: Z3Converter.verilog_to_z3(e), expressions))
            return And(*z3_expressions)
        elif len(lst) >= 3 and lst[1] == '|':
            expressions = [lst[i] for i in range(0, len(lst), 2)]
            z3_expressions = list(map(lambda e: Z3Converter.verilog_to_z3(e), expressions))
            return Or(*z3_expressions)
        elif len(lst) >= 5 and lst[1] == '?':
            cond = lst[0]
            true_stmt = lst[2]
            false_stmt = lst[4]
            return If(Z3Converter.verilog_to_z3(cond), Z3Converter.verilog_to_z3(true_stmt), Z3Converter.verilog_to_z3(false_stmt), ctx=None)
        return
