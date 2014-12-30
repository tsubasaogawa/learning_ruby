# encoding: cp932

require "socket"
require "uri"

# ���b�Z�[�W�w�b�_����͂��ăn�b�V���ɒǉ�
def header(data)
  map = {}
  data.scan(/([^:]+):\s*(.+)\s*\r\n/) do |k, v|
    map[k] = v
  end
  map
end

# ��M�f�[�^�����Ƃ�3�̃Z�N�V�����ɕ���
def split_sockdata(data)
  head, body = data.split("\r\n\r\n", 2)
  req_line, msg_head = head.split("\r\n", 2)
  msg_head << "\r\n"
  return req_line, msg_head, body
end

TCPSocket.open("codezine.jp", 80) do |socket|
  socket.write("GET /rss/new/20/index.xml HTTP/1.0\r\n")
  socket.write("\r\n")
  data = socket.read
  
  req_line, msg_head, body = split_sockdata(data)
  metadata = header(msg_head)
  
  # Moved Temporary��
  if req_line =~ /30(?:1|2)/ and metadata["Location"]
    mth = metadata["Location"].match(/http:\/\/([^\/]+)(.*)/)
    host, path = mth[1], mth[2]
	
	# Location�œ����V����URI����ɐڑ�������
    TCPSocket.open(host, 80) do |socket2|
      socket2.write("GET #{path} HTTP/1.0\r\n\r\n")
      data2 = socket2.read
      req2, msg2, body2 = split_sockdata(data2)

      File.open("codezine-news.txt", "w") do |f|
        f.write(body2)
      end
    end
  end
  
  # OK��
  elsif req_line =~ /20./
    File.open("codezine-news.txt", "w") do |f|
      f.write(body)
    end
  end
end
