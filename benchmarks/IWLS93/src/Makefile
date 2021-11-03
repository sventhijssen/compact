#
# Builds and installs base libraries plus the three
# programs e2fmt esim and erprt
#

def:;  XCFLAGS="`getcflags`" $(MAKE) all

install all:;
	cd util; make
	cd edifparse; make
	cd netlist; make
	cd e2fmt; make install
	cd esim; make install
	cd erprt; make install

clean:;
	cd util; make clean
	cd edifparse; make clean
	cd netlist; make clean
	cd e2fmt; make clean
	cd esim; make clean
	cd erprt; make clean
