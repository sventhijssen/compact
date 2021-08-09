#pragma once

#include <map>
#include <vector>

#include "TableStr.h"
#include "bdd.h"
#include "uniData.h"


class SBDD
{
public:
	// ≈сли constant = false, то будет создан SBDD = 0, иначе 1.
	SBDD(bool constant = false);
	SBDD(const SBDD &sbdd);

	// Ѕазовые операции.
	// —уществует ли данные узел в таблице.
	bool member(const TableStr &tableStr);
	// ¬озвращает номер узла в таблице, если такого узла нет то -1.
	int lookup(const TableStr &tableStr);
	// ¬ставл€ет узел в таблицу и возвращает его номер.
	int insert(const TableStr &tableStr);
	// —оздаем и добавл€ем если можно новый узел.
	int makeNode(int index, int left, int right);

	void build(const UniData &data);

	void out(std::ostream &stream) const;

	std::map<int, TableStr> table() const { return table_; }
	std::vector<std::string> fNames() const { return fNames_; }
	std::vector<int> fRoot() const { return fRoot_; }
	std::vector<std::string> vars() const { return vars_; }

	BDD bdd(const std::string &fName);

	void addBdd(const BDD &bdd);

private:
	void buildFunctionPrivate(const BoolFunction &function);
	int buildPrivate(BoolFunction function, int index);

	BoolFunction setZero(BoolFunction function, int index);
	BoolFunction setOne(BoolFunction function, int index);

	void bddPrivate(BDD &bdd, int index);

private:
	std::map<int, TableStr> table_;
	std::vector<std::string> fNames_;
	std::vector<int> fRoot_;
	std::vector<std::string> vars_;
	int nextNum_;

};	// class SBDD
