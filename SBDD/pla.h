#pragma once

#include <string>
#include <vector>

struct StrPLA
{
	std::string input;
	std::string output;
};

class PLA
{
public:
	PLA() { clear(); }
	
	bool setData(const std::string &fileName);

	int p() const { return p_; }
	int i() const { return i_; }
	int o() const { return o_; }
	std::vector<std::string> vars() const { return vars_; }
	std::vector<std::string> funs() const { return funs_; }
	std::vector<StrPLA> cubes() const { return cubes_; }

	void clear() { p_ = 0; i_ = 0; o_ = 0; cubes_.clear(); }

	void show(std::ostream &stream);

private:
	int p_;
	int i_;
	int o_;
	std::vector<StrPLA> cubes_;
	std::vector<std::string> vars_;
	std::vector<std::string> funs_;
};