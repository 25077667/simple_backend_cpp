#ifndef __HANDLER_PING_HPP__
#define __HANDLER_PING_HPP__

#include <drogon/HttpSimpleController.h>
#include <coroutine>

using drogon::HttpRequestPtr;
using drogon::HttpResponse;
using drogon::HttpResponsePtr;
using drogon::Task;

Task<HttpResponsePtr> ping(HttpRequestPtr reqp);

#endif