# coding: cp932

require "socket"
require "uri"

module WebFramework
	def self.main()
		TCPServer.open(8000) do |server|
			loop do
				sock = server.accept
				data = ""
				begin
					data << sock.read(1)
				end while !data.index("\r\n\r\n")
				method, uri, v = data[0...data.index("\r\n")].scan(/[^\s]+/)
				metadata = header(data[data.index("\r\n") + 2..-3])
				query = nil
				if metadata["Content-Length"]
					query = form(sock.read(metadata["Content-Length"].to_i))
				end
				stat, resp = execute_appl(uri, query)
				sock.write("HTTP/1.1 #{stat}\r\n")
				sock.write("Content-Type: text/html; charset=Windows-31J\r\n")
				sock.write("Content-Length: #{resp.bytesize}\r\n")
				sock.write("Connection: close\r\n")
				sock.write("\r\n")
				sock.write(resp)
				sock.close
			end
		end
	end
	
	def self.execute_appl(uri, query)
		if uri == "/quit"
			puts "program quit"
			exit(0)
		elsif uri == "/"
			return "200 OK", ""
		else
			begin
				app = uri[1..-1]
				require("./#{app.downcase}")
			rescue LoadError
				return "404 Not found", "#{app}が見つかりません"
			end
		end
		begin
			obj = eval(app).new
			obj.extend(WebFramework)
			resp = obj.execute(query)
		rescue
			resp = "#{app}でエラーが発生しました"
			resp << "<br />#{encode($!.message)}<br />"
			resp << $!.backtrace.join("<br />")
		end
		return "200 OK", resp
	end
	
	def self.header(data)
		map = {}
		data.scan(/([^:]+):\s*(.*)\s*\r\n/) do |k, v|
			map[k] = v
		end
		map
	end
	
	def self.form(data)
		map = {}
		data.scan(/([^=]+)=([^&]*)&?/) do |k, v|
			map[URI.decode(k)] = URI.decode(v)
		end
		map
	end
	
	ENCODE_DATA = {"<" => "&lt;", ">" => "&gt;", "&" => "&amp;", "\"" => "&quot;"}
	
	def self.encode(data)
		resp = ""
		data.each_char do |c|
			if ENCODE_DATA[c]
				resp << ENCODE_DATA[c]
			else
				resp << c
			end
		end
		resp.force_encoding("Windows-31J")
	end
	
	private
	def encode(data)
		WebFramework.encode(data)
	end
end

if $0 == __FILE__
	WebFramework.main()
end
