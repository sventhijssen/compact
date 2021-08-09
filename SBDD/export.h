#pragma once

#include <string>

class SBDD;

bool exportToFileSBDD(const SBDD &sbddG, std::string &fileName);

bool exportToFileDOT(const SBDD &sbddG, std::string &fileName);