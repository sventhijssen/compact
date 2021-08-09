#pragma once

// —труктура дл€ представлени€ строчки таблицы.
struct TableStr {
	int index;
	int left;
	int right;

	TableStr(int i = -1, int l = -1, int r = -1) { index = i; left = l; right = r; }

	bool operator == (const TableStr &tableStr)
	{
		if (index == tableStr.index && left == tableStr.left && right == tableStr.right) {
			return true;
		}
		else
			return false;
	}
};