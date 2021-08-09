#include <fstream>

#include "sbdd.h"
#include "export.h"

bool exportToFileSBDD(const SBDD &sbddG, std::string &fileName)
{
	std::ofstream file;
	file.open(fileName);
	if (file.is_open()) {
		sbddG.out(file);
		file.close();
		return true;
	}
	return false;
}

bool exportToFileDOT(const SBDD &sbddG, std::string &fileName)
{
	std::ofstream file;
	file.open(fileName);
	if (file.is_open()) {
		
		std::map<int, TableStr> table = sbddG.table();
		std::vector<std::string> fNames = sbddG.fNames();
		std::vector<int> fRoot = sbddG.fRoot();

		file << "graph sbdd { \n";
		size_t sizeFN = fNames.size();
		for (size_t i = 0; i < sizeFN; ++i) {
			file << fNames[i] << "[shape=\"plaintext\"];\n";
			file << fNames[i] << " -- " << std::to_string(fRoot[i]) << ";\n";
		}
		file << "1" << "[shape=\"box\"];\n";
		file << "0" << "[shape=\"box\"];\n";
		auto iter = table.begin();
		auto end = table.end();
		for (; iter != end; ++iter) {
			if (iter->first != 0 && iter->first != 1) {
				file << std::to_string(iter->first) << "[label=\"" + sbddG.vars()[iter->second.index] + "\"];\n";
			}
		}
		iter = table.begin();
		for (; iter != end; ++iter) {
			if (iter->first != 0 && iter->first != 1) {
				file << std::to_string(iter->first) << " -- " << std::to_string(iter->second.left) << " [style=\"dotted\"];\n";
				file << std::to_string(iter->first) << " -- " << std::to_string(iter->second.right) << ";\n";
			}
		}
		file << " }";

		file.close();
		return true;
	}
	return false;
}