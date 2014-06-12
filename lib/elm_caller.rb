class ElmCaller
  CHECK_INTERVAL = 1

  def initialize(plugin_name, data)
    @plugin_name = plugin_name
    @data = data
  end

  def run
    elm = ElmDummy.new
    elm.login("tekitou")
    req_id = elm.remoteRun(@plugin_name, @data)
    while elm.getStatus(req_id) < 3
      puts "sleepi #{CHECK_INTERVAL}"
      sleep(CHECK_INTERVAL)
    end
    elm.logout
  end
end
