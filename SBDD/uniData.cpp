#include <string>
#include <iostream>

#include "uniData.h"
#include "pla.h"

bool BoolFunction::isZero()
{
	return cubes_.empty();
}

bool BoolFunction::isOne()
{
	if (cubes_.empty()) {
		return false;
	}
	else {
		size_t size = cubes_[0].size();
		std::string cube(size, '-');
		int numC = cubes_.size();
		for (int i = 0; i < numC; ++i) {
			if (cube == cubes_[i]) {
				return true;
			}
		}
	}
	return false;
}

void UniData::fromPLA(const PLA &pla)
{
	functions_.clear();
	// TODO: ChernyshovSV - ���� ����� ����� ������������� ���� ������� (1,2,3,...), ����� �������� �� �������� �����.
	std::vector<StrPLA> cubes = pla.cubes();
	int nFun = pla.o();
	int p = pla.p();
	for (int i = 0; i < nFun; ++i) {
		BoolFunction function;
		for (int j = 0; j < p; ++j) {
			if (cubes[j].output[i] == '1') {
				function.cubes_.push_back(cubes[j].input);
			}
		}
		functions_.insert(std::pair<std::string, BoolFunction>(pla.funs()[i] , function));
	}
	vars_ = pla.vars();
}

BoolFunction UniData::function(const std::string &fName)
{
	if (functions_.count(fName)) {
		return functions_[fName];
	}
	return BoolFunction();
}

void UniData::show(std::ostream &stream)
{
	stream << "UniData:\n";
	auto iter = functions_.begin();
	auto end = functions_.end();
	for (; iter != end; ++iter) {
		stream << "\n";
		stream << iter->first << "\n";
		BoolFunction function = iter->second;
		size_t size = function.cubes_.size();
		for (size_t i = 0; i < size; ++i) {
			stream << function.cubes_[i] << "\n";
		}
	}
	stream << "\n";
}