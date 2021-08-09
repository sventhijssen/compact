#pragma once

#include <map>
#include <vector>
#include <iostream>

#include "TableStr.h"

class SBDD;

enum OP {
	Or,
	And,
	Xor
};

class BDD
{
	friend SBDD;
public:
	// ���� constant = false, �� ����� ������ SBDD = 0, ����� 1.
	BDD(bool constant = false);
	BDD(const BDD &bdd);

	// ������� ��������.
	// ���������� �� ������ ���� � �������.
	bool member(const TableStr &tableStr);
	// ���������� ����� ���� � �������, ���� ������ ���� ��� �� -1.
	int lookup(const TableStr &tableStr);
	// ��������� ���� � ������� � ���������� ��� �����.
	int insert(const TableStr &tableStr);
	// ������� � ��������� ���� ����� ����� ����.
	int makeNode(int index, int left, int right);

	void show(std::ostream &stream);

	BDD apply(BDD &bdd2, OP op);

	void setName(const std::string &name) { fName_ = name; }
	std::string name() const { return fName_; }

private:
	int applyPrivate(BDD &result, BDD &bdd2, OP op, int u1, int u2);
	int operation(int op1, int op2, OP op);

private:
	std::map<int, TableStr> table_;
	std::string fName_;
	int fRoot_;
	int nextNum_;
	std::vector<std::string> vars_;

	std::map<int, std::map<int, int>> G_;
};