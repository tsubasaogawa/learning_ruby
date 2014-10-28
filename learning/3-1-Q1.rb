# encoding: cp932

# 電話帳を管理するプログラム

def get_entry()
  while true
    puts("please enter your name")
    name = gets().chomp()
    return nil if name.size == 0
	puts("please enter your phone number")
	phone = gets().chomp()
	puts("Are you sure to submit name: #{name}, number: #{phone} (Y/n)?")
	ans = gets().chomp()
	if ans.size == 0 || ans == "Y" || ans == "y"
	  return {"name" => name, "phone" => phone}
	end
  end
end

directory = nil
begin
  File.open("directory.data", "rb") do |f|
    directory = Marshal.load(f)
  end
rescue
  directory = {}
end
while entry = get_entry()
  directory[entry["name"]] = entry
end
puts(directory)
File.open("directory.data", "wb") do |f|
  Marshal.dump(directory, f)
end