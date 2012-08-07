module Logger
  include_package 'org.apache.log4j.Logger'

    def log_msg(msg,level=debug)
     @@logger.info(formatted_date + " DEBUG: " + msg)
    end

    def formatted_date
      sprintf("%.0f/%.2f/%.2f %.2f:%.2f:%.2f",Time.now.year.to_s,Time.now.day.to_s,\
      Time.now.mon.to_s, Time.now.hour.to_s,
      Time.now.min.to_s, Time.now.sec.to_s)
    end
end
