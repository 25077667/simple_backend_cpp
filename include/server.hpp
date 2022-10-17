#ifndef __SERVER_HPP__
#define __SERVER_HPP__
#include <memory>

class Server {
   public:
    Server();
    ~Server();

    void run(int port = 8080) const;

   private:
    struct Impl;
    std::unique_ptr<Impl> pImpl;
};

#endif