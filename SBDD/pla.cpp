#include <fstream>
#include <ostream>

#include "pla.h"

bool PLA::setData(const std::string &fileName)
{
	std::ifstream file;
	file.open(fileName);
	if (!file.is_open()) {
		clear();
		return false;
	}
	std::string word;
	
	if (file.eof()) {
		clear();
		return false;
	}
	file >> word;
	size_t size = 0;
	while (word[0] == '.') {
		if (word == ".ilb") {
			for (int i = 0; i < i_; ++i) {
				file >> word;
				vars_.push_back(word);
			}
			file >> word;
		}
		if (word == ".ob") {
			for (int i = 0; i < o_; ++i) {
				file >> word;
				funs_.push_back(word);
			}
			file >> word;
		}
		if (word == ".i") {
			file >> i_;
			file >> word;
		}
		if (word == ".o") {
			file >> o_;
			file >> word;
		}
		if (word == ".p") {
			file >> p_;
			file >> word;
		}
		if (file.eof()) {
			clear();
			return false;
		}
	}
	int i = 0;
	while (word != ".e" && i < p_) {
		StrPLA str;
		str.input = word;
		if (file.eof()) {
			clear();
			return false;
		}
		file >> word;
		str.output = word;
		if (file.eof()) {
			clear();
			return false;
		}
		file >> word;
		cubes_.push_back(str);
		++i;
	}
	file.close();

	if (vars_.size() == 0) {
		for (int i = 0; i < i_; ++i) {
			vars_.push_back("x" + std::to_string(i));
		}
	}
	if (funs_.size() == 0) {
		for (int i = 0; i < o_; ++i) {
			vars_.push_back("f" + std::to_string(i));
		}
	}

	return true;
}

void PLA::show(std::ostream &stream)
{
	stream << "PLA:\n";
	stream << ".i " << i_ << "\n";
	stream << ".o " << o_ << "\n";
	stream << ".ilb ";
	for (int i = 0; i < i_; ++i) {
		stream << vars_[i] << " ";
	}
	stream << "\n";
	stream << ".ob ";
	for (int i = 0; i < o_; ++i) {
		stream << funs_[i] << " ";
	}
	stream << "\n";
	stream << ".p " << p_ << "\n\n";
	
	auto iter = cubes_.begin();
	auto end = cubes_.end();
	for (; iter != end; ++iter) {
		stream << iter->input << " " << iter->output << "\n";
	}

	stream << ".e\n\n";
}