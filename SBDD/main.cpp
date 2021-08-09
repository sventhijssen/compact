#include <iostream>

#include "sbdd.h"
#include "pla.h"
#include "uniData.h"
#include "export.h"
#include "bdd.h"

int main(int argc, char** argv)
{
	PLA pla;
	pla.setData(argv[1]);
	// pla.show(std::cout);

	UniData uniData;
	uniData.fromPLA(pla);
	// uniData.show(std::cout);

	SBDD sbddG;
	sbddG.build(uniData);
	std::string fileName = "sbdd.txt";
	exportToFileSBDD(sbddG, fileName);
	fileName = "sbdd.dot";
	exportToFileDOT(sbddG, fileName);
	// sbddG.out(std::cout);

	return 0;
}