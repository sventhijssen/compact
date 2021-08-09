from Literal import Literal
from Memristor import Memristor


class CrossbarMerger:

    def __init__(self):
        self.crossbars = []
        self.rows = []
        self.columns = []

    def add(self, crossbar, rows, columns):
        self.crossbars.append(crossbar)
        self.rows.append(rows)
        self.columns.append(columns)

    def merge(self):
        # Let n be the number of crossbars, thus n = len(self.crossbars)
        # The size of the monolithic crossbar is equal to
        # size = 1 + sum_i=0..(n-1) (size(crossbar_i) - 1)
        # => rows = 1 + sum_i=0..(n-1) (rows(crossbar_i) - 1) = 1 - n + sum_i=0..(n-1) (rows(crossbar_i))
        # => cols = 1 + sum_i=0..(n-1) (cols(crossbar_i) - 1) = 1 - n + sum_i=0..(n-1) (cols(crossbar_i))
        # The condition holds since each crossbar has an input column and an input row
        # as well as an output column and an output row.
        # The input columns and input rows can respectively be merged into one column or row.
        # The output columns and output rows cannot be merged.

        crossbars = self.crossbars
        rows = self.rows
        columns = self.columns

        n = len(crossbars)
        nr_rows = 1 - n + sum(rows)
        nr_cols = 1 - n + sum(columns)

        monolithic = [[Memristor(r, c, Literal('False', False)) for c in range(nr_cols)] for r in range(nr_rows)]

        for i in range(len(crossbars)):
            row_offset = sum(rows[i+1:]) - (n - 2*(i+1))
            col_offset = 1 + sum(columns[:i]) - (i*2)
            crossbar = crossbars[i]

            # Copy each memristor from the subcrossbar to the new monolithic crossbar
            for r in range(1, rows[i]-1):
                for c in range(1, columns[i]-1):
                    memristor = crossbar[r][c]
                    monolithic[r - 1 + row_offset][c - 1 + col_offset] = Memristor(r - 1 + row_offset, c - 1 + col_offset, memristor.literal)

            # Horizontal input and output
            for c in range(1, columns[i]-1):
                # Copy horizontal input row
                memristor = crossbar[rows[i]-1][c]
                monolithic[nr_rows - 1][c - 1 + col_offset] = Memristor(nr_rows - 1, c - 1 + col_offset, memristor.literal)

                # Copy horizontal output row
                memristor = crossbar[0][c]
                monolithic[i][c - 1 + col_offset] = Memristor(i, c - 1 + col_offset, memristor.literal)

            # Vertical input and output
            for r in range(1, rows[i]-1):
                # Copy vertical input row
                memristor = crossbar[r][0]
                monolithic[r - 1 + row_offset][0] = Memristor(r - 1 + row_offset, 0, memristor.literal)

                # Copy vertical output row
                memristor = crossbar[r][columns[i] - 1]
                monolithic[r - 1 + row_offset][nr_cols - i - 1] = Memristor(r - 1 + row_offset, nr_cols - i - 1, memristor.literal)

            # Output voltages
            for k in range(n):
                monolithic[k][nr_cols - 1 - k] = Memristor(k, nr_cols - 1 - k, Literal('True', True))

            # Input voltage
            monolithic[nr_rows - 1][0] = Memristor(nr_rows - 1, 0, Literal('True', True))

        return [monolithic, nr_rows, nr_cols]
