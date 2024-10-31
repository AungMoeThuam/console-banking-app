require 'time'
def parse_time time
  parsed_time = Time.strptime(time, "%Y%m%d%H%M%S")
  return parsed_time.strftime("%Y-%m-%d %I:%M %p")
end

def get_current_time
  return Time.now.strftime("%Y%m%d%H%M%S")
end
