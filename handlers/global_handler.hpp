#ifndef __GLOBAL_HNADLER_HPP__
#define __GLOBAL_HNADLER_HPP__
#include <drogon/drogon.h>
#include <functional>
#include <vector>

// ------ Insert your header here ------
#include "ping.hpp"
// ------ Insert your header here ------

using my_handler = std::function<Task<HttpResponsePtr>(HttpRequestPtr)>;

const std::vector<std::pair<std::string, my_handler>> my_handler_table = {
    /* ------ Insert your handler function here ------ */
    {"/ping", ping},
    /* ------ Insert your handler function here ------ */
};

#endif