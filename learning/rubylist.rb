# encoding: cp932

class RubyList
  # �F�������閽��
  FUNC = ["module", "class", "def", "if", "elsif", "else", "while", "begin", "rescue", "ensure", "do", "end"]

  def execute(query)
    resp = "<html><body><form method='post'>" # �o��HTML

    # �L���ȃN�G�����Ȃ��Ƃ��A�t�@�C���ꗗ���o�͂���
    if !query or !query["filename"]
      resp << "<select name='filename'>"

      files = Dir::glob("./*.rb")
      files.sort.each do |file|
        resp << "<option>#{file}</option>"
      end
      resp << "</select><input type='submit'>"

    # filename�L�[�Ɏ������t�@�C����ǂݍ��݁A�F�����\��
    else
      resp << "<pre>"
      filename = encode(query["filename"])
      puts "open: #{filename}"
      File.open(filename, "r") do |f|
        while line = f.gets
          FUNC.each do |func|
            next if !line.index(func)
            puts "hit: #{func} in #{line}"
            line = line.gsub("#{func}", "<span style='color:blue'>#{func}</span>")
          end
          if line.index("#")
            line = line.gsub("#", "<span style='color:green'>#")
            line << "</span>"
          end
          resp << line
        end
      end
      resp << "</pre>"
      resp << "<input type='submit' value='back'>"
    end
    resp << "</form></body></html>"
  end
end
