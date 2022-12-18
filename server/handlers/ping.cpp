#include "ping.hpp"

Task<HttpResponsePtr> ping(HttpRequestPtr reqp) {
    auto resp = HttpResponse::newHttpResponse();
    resp->setBody("Pong");
    co_return resp;
};