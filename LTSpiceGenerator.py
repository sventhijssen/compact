from typing import List

from Memristor import Memristor


class LTSpiceGenerator:

    @staticmethod
    def write_circuit(rows: int, columns: int, output_variables: List[str], matrix_instance: List[List[Memristor]]):

        file_name = 'circuit.cir'

        r_out = 100

        with open(file_name, 'w') as f:
            f.write('* Circuit analysis based on Yakopcic\n')
            f.write('.subckt mem_dev TE BE xo=0.5 XSV=40\n')
            f.write('.PARAM a1=0.2 a2=0.2 b=0.05 Vp=1.1 Vn=1.1 Ap=1.9e9 An=1.9e9 xp=0.675 xn=0.675 alphap=0.01 alphan=0.01 eta=1\n')
            f.write('.FUNC wp(V) = \'(xp-V)/(1-xp)+1\'\n')
            f.write('.FUNC wn(V) = \'V/(1-xn)\'\n')
            f.write('.FUNC G(V) = \'IF(V <= Vp, IF(V >= -1*Vn, 0, -1*An*(exp(-1*V)+(-1*exp(Vn)))), Ap*(exp(V)+(-1*exp(Vp))))\'\n')
            f.write('.FUNC F(V1,V2) = \'IF(eta*V1 >= 0, IF(V2 >= xp, exp(-1*alphap*(V2-xp))*wp(V2) ,1), IF(V2 <= (1-xn), exp(alphan*(V2+xn-1))*wn(V2) ,1))\'\n')
            f.write('.FUNC IVRel(V1,V2) = \'IF(V1 >= 0, a1*V2*sinh(b*V1), a2*V2*sinh(b*V1))\'\n')
            f.write('Cx XSV 0 \'1\'\n')
            f.write('.ic V(XSV) = xo\n')
            f.write('Gx 0 XSV value=\'eta*F(V(TE,BE),V(XSV,0))*G(V(TE,BE))\'\n')
            f.write('Gm TE BE value = \'IVRel(V(TE,BE),V(XSV,0))\'\n')
            f.write('.ends mem_dev\n')
            f.write('\n')

            # Begin memristor crossbar
            for i in range(len(matrix_instance)):
                for j in range(len(matrix_instance[i])):
                    if matrix_instance[i][j].literal.positive:
                        xo = '1.0'
                    else:
                        xo = '0.00001'
                    f.write('X_{}_{} m{} n{} mem_dev xo={}\n'.format(i, j, i, j, xo))
            # End memristor crossbar

            f.write('V1 m{} 0 1\n'.format(rows-1))

            for i in range(len(output_variables)):
                f.write('Rout{} m{} 0 {}\n'.format(i, i, r_out))
            f.write('.tran 0.1ms startup\n')
            f.write('.end\n')

            f.close()
