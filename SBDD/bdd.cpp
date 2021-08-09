#include <string>
#include <iostream>

#include "bdd.h"

BDD::BDD(bool constant)
{
	nextNum_ = 2;
	TableStr tableStr;
	tableStr.index = tableStr.left = tableStr.right = -1;
	table_.insert(std::pair<int, TableStr>(constant ? 1 : 0, tableStr));
}

BDD::BDD(const BDD &bdd)
{
	table_ = bdd.table_;
	fName_ = bdd.fName_;
	fRoot_ = bdd.fRoot_;
	nextNum_ = bdd.nextNum_;
	vars_ = bdd.vars_;
}

bool BDD::member(const TableStr &tableStr)
{
	auto iter = table_.begin();
	auto end = table_.end();
	for (; iter != end; ++iter) {
		if (iter->second == tableStr) {
			return true;
		}
	}
	return false;
}

int BDD::lookup(const TableStr &tableStr)
{
	auto iter = table_.begin();
	auto end = table_.end();
	for (; iter != end; ++iter) {
		if (iter->second == tableStr) {
			return iter->first;
		}
	}
	return -1;
}

int BDD::insert(const TableStr &tableStr)
{
	table_.insert(std::pair<int, TableStr>(nextNum_, tableStr));
	nextNum_++;
	return nextNum_ - 1;
}

int BDD::makeNode(int index, int left, int right)
{
	if (left == right) {
		return left;
	}
	else {
		int res = -1;
		res = lookup(TableStr(index, left, right));
		if (res != -1) {
			return res;
		}
		else
		{
			return insert(TableStr(index, left, right));
		}
	}
}

void BDD::show(std::ostream &stream)
{
	stream << "BDD:\n";
	stream << fName_ << ":\n";
	auto iter = table_.begin();
	auto end = table_.end();
	for (; iter != end; ++iter) {
		stream << iter->first << " -> " << iter->second.index << "(" + (iter->second.index != -1 ? vars_[iter->second.index] : "-1") + ")" << "   " << iter->second.left << "   " << iter->second.right << "\n";
	}
	stream << "\n";
}

BDD BDD::apply(BDD &bdd2, OP op)
{
	// Помимо самой таблицы необходимо заполнить:
	BDD result;
	result.fName_ = "f";
	TableStr str;
	str.index = str.left = str.right = -1;
	result.table_.insert(std::pair<int, TableStr>(0, str));
	result.table_.insert(std::pair<int, TableStr>(1, str));
	G_.clear();
	result.fRoot_ = applyPrivate(result, bdd2, op, fRoot_, bdd2.fRoot_);
	result.nextNum_ = result.fRoot_ + 1;
	result.vars_ = vars_;
	return result;
}

int BDD::applyPrivate(BDD &result, BDD &bdd2, OP op, int u1, int u2)
{
	if (G_.count(u1) && G_[u1].count(u2)) {
		return G_[u1][u2];
	}
	else {
		int u = -1;
		if ((u1 == 0 || u1 == 1) && (u2 == 0 || u2 == 1)) {
			u = operation(u1, u2, op);
		}
		else {
			if (table_[u1].index == bdd2.table_[u2].index) {
				u = result.makeNode(table_[u1].index, applyPrivate(result, bdd2, op, table_[u1].left, bdd2.table_[u2].left),
					applyPrivate(result, bdd2, op, table_[u1].right, bdd2.table_[u2].right));
			}
			else {
				if ((table_[u1].index == -1 ? bdd2.vars_.size() : table_[u1].index) < (bdd2.table_[u2].index == -1 ? bdd2.vars_.size() : bdd2.table_[u2].index)) {
					u = result.makeNode(table_[u1].index, applyPrivate(result, bdd2, op, table_[u1].left, u2),
						applyPrivate(result, bdd2, op, table_[u1].right, u2));
				}
				else {
					u = result.makeNode(bdd2.table_[u2].index, applyPrivate(result, bdd2, op, u1, bdd2.table_[u2].left),
						applyPrivate(result, bdd2, op, u1, bdd2.table_[u2].right));
				}
			}
		}
		if (!G_.count(u1)) {
			G_.insert(std::pair<int, std::map<int, int>>(u1, std::map<int, int>()));
		}
		G_[u1].insert(std::pair<int, int>(u2, u));
		return u;
	}
}

int BDD::operation(int op1, int op2, OP op)
{
	if (op == OP::Or) {
		if (op1 == 1 || op2 == 1) {
			return 1;
		}
		else {
			return 0;
		}
	}
	if (op == OP::And) {
		if (op1 == 1 && op2 == 1) {
			return 1;
		}
		else {
			return 0;
		}
	}
	if (op == OP::Xor) {
		if (op1 != op2) {
			return 1;
		}
		else {
			return 0;
		}
	}
	return 0;
}