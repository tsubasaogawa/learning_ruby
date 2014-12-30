# encoding: cp932

require "socket"

TCPSocket.open("codezine.jp", 80) do |socket|
  socket.write("GET /rss/new/20/index.xml HTTP/1.0\r\n")
  socket.write("\r\n")
  File.open("codezine-news.txt", "w") do |file|
    file.write(socket.read())
  end
end
