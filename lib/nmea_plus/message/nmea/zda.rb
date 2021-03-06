require_relative "base_nmea"

module NMEAPlus
  module Message
    module NMEA
      # ZDA - Time & Date - UTC, day, month, year and local time zone
      class ZDA < NMEAPlus::Message::NMEA::NMEAMessage

        # @!parse attr_reader :utc_time
        # @return [Time]
        def utc_time
          re_format = /(\d{2})(\d{2})(\d{2}(\.\d+)?)/
          hms = re_format.match(@fields[1])
          begin
            tz_h = @fields[5].to_i
            tz = "%s%0.02d:%0.02d" % [tz_h >= 0 ? '+' : '', tz_h, @fields[6].to_i]
            Time.new(@fields[4].to_i, @fields[3].to_i, @fields[2].to_i,
                     hms[1].to_i, hms[2].to_i, hms[3].to_f, tz)
          rescue
            nil
          end
        end
      end
    end
  end
end
