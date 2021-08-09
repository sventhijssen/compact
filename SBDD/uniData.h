#pragma once

#include <string>
#include <vector>
#include <map>

class PLA;
class BoolFormula;

class BoolFunction
{
public:
	std::vector<std::string> cubes_;

	bool isZero();
	bool isOne();
};

class UniData
{
public:
	UniData() {}

	void fromPLA(const PLA &pla);
	void fromBF(const BoolFormula &bf);
	
	std::map<std::string, BoolFunction> functions() const { return functions_; }
	BoolFunction function(const std::string &fName);

	void show(std::ostream &stream);

	std::vector<std::string> vars() const { return vars_; }
	
private:
	std::map<std::string, BoolFunction> functions_;
	std::vector<std::string> vars_;
};