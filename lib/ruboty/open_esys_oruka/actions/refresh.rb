require "thread"

module Ruboty
  module OpenEsysOruka
    module Actions
      class Refresh < Ruboty::Actions::Base
        include ::Ruboty::OpenEsysOruka::Bluetooth
        include ::Ruboty::OpenEsysOruka::Member

        def call
          # refresh
          message.reply(refresh)
        rescue => e
          message.reply(e.message)
        end

        private

        def refresh
          kick_member
          bluetooth_scan
          timestamp
          "powa"
        end

        def table
          brain      = message.robot.brain
          brain.data[:open_esys_oruka] ||= {}
          brain.data[:open_esys_oruka][:oru_list] ||= {
            timestamp: nil,
            member: [],
          }
        end

        def kick_member
          table[:member].select! { |i| i.exist_now? }
        end

        def bluetooth_scan
          ::Ruboty::OpenEsysOruka::Bluetooth.exist_list.each do |name|
            table[:member] << ::Ruboty::OpenEsysOruka::Member.new(name)
          end
        end

        def timestamp
          table[:timestamp] = Time.now
        end
      end
    end
  end
end
