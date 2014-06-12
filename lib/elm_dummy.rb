class ElmDummy
  def login(*args)
    puts "login!"
  end

  def remoteRun(dll_name, data)
    puts "remote run #{dll_name} with #{data}"
    12345
  end

  def getStatus(req_id)
    # 面倒だから直接コードを返すことにした
    gacha = rand(100)
    if gacha > 90
      ret = 4
    elsif gacha > 70
      ret = 3
    elsif gacha > 10
      ret = 2
    else
      ret = 1
    end
    puts "status: #{ret}"
    ret
  end

  def logout
    puts "logout"
  end
end
