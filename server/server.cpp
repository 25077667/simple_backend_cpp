#include <filesystem>
#include <handlers/global_handler.hpp>
#include <server.hpp>

struct Server::Impl : public drogon::HttpController<Server::Impl> {
    METHOD_LIST_BEGIN
    METHOD_LIST_END
};

Server::Server() : pImpl{std::make_unique<Server::Impl>()} {
    for (const auto& [path, handler] : my_handler_table)
        drogon::app().registerHandler(path, my_handler(handler));
}

Server::~Server() {}

void Server::run(int port) const {
    if (!std::filesystem::exists(std::filesystem::path("./log/")))
        std::filesystem::create_directories("./log/");

    drogon::app()
        .setLogPath("./log/")
        .setLogLevel(trantor::Logger::kWarn)
        .addListener("0.0.0.0", port)
        .setThreadNum(16)
        .run();
}