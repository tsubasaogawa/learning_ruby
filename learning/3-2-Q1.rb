# encoding: cp932

def emit(out)
  out.put("anata", "neko", "funda")
  out.put("watashi", nil, "naita")
end

class Out_standard
  def put(s, o, v)
    print("#{s} ha ")
    if o != nil
      print("#{o} wo ")
    end
    print("#{v}\n")
  end
end

class Out_tagged
  def put(s, o, v)
    print("<subject>#{s}</subject>")
    if o != nil
      print("<object>#{o}</object>")
    end
    print("<predicate>#{v}</predicate>\n")
  end
end

class Out_transformed
  def put(s, o, v)
    print("#{s}, ")
    if o != nil
      print("#{o} ")
    end
    print("#{v}\n")
  end
end

a = Out_standard.new
b = Out_tagged.new
c = Out_transformed.new

emit(a)
emit(b)
emit(c)
