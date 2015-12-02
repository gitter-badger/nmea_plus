require_relative 'vdm_msg'

module NMEAPlus
  module Message
    module AIS
      module VDMPayload

        # Base class for "Class B CS Position Report" messages (18 and 19)
        class VDMMsgClassBCSPosition < NMEAPlus::Message::AIS::VDMPayload::VDMMsg

          payload_reader :speed_over_ground, 46, 10, :_U, 1
          payload_reader :position_10m_accuracy?, 56, 1, :_b

          # @!parse attr_reader :longitude
          # @return [Float]
          def longitude
            _I(57, 28, 4) / 60
          end

          # @!parse attr_reader :latitude
          # @return [Float]
          def latitude
            _U(85, 27, 4) / 60
          end

          payload_reader :course_over_ground, 112, 12, :_U, 1

          # @!parse attr_reader :true_heading
          # @return [Float]
          def true_heading
            ret = _u(124, 9)
            return nil if ret == 511  # means "not available"
            ret
          end

          payload_reader :time_stamp, 133, 6, :_u

        end

        class VDMMsg18 < VDMMsgClassBCSPosition
          payload_reader :cs_unit?, 141, 1, :_b
          payload_reader :display?, 142, 1, :_b
          payload_reader :dsc?, 143, 1, :_b
          payload_reader :band?, 144, 1, :_b
          payload_reader :accept_message_22?, 145, 1, :_b
          payload_reader :assigned?, 146, 1, :_b
          payload_reader :raim?, 147, 1, :_b
        end

        class VDMMsg19 < VDMMsgClassBCSPosition
          payload_reader :name, 143, 120, :_t
          payload_reader :ship_cargo_type, 263, 8, :_e
          payload_reader :ship_dimension_to_bow, 271, 9, :_u
          payload_reader :ship_dimension_to_stern, 280, 9, :_u
          payload_reader :ship_dimension_to_port, 289, 6, :_u
          payload_reader :ship_dimension_to_starboard, 295, 6, :_u
          payload_reader :epfd_type, 301, 4, :_e
          payload_reader :raim?, 305, 1, :_b
          payload_reader :dte?, 306, 1, :_b
          payload_reader :assigned?, 307, 1, :_b

          # @!parse attr_reader :ship_cargo_type_description
          # @return [String] Cargo type description
          def ship_cargo_type_description
            get_ship_cargo_type_description(ship_cargo_type)
          end

        end

      end
    end
  end
end
