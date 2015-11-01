require_relative "base_nmea"

module NMEAPlus
  module Message
    module NMEA
      class HSC < NMEAPlus::Message::NMEA::NMEAMessage
        field_reader :true_heading_degrees, 1, :_float
        field_reader :magnetic_heading_degrees, 3, :_float
      end
    end
  end
end