require "thread"

module Ruboty
  module OpenEsysOruka
    module Actions
      class Refresh < Ruboty::Actions::Base
        def call
          refresh
        rescue => e
          message.reply(e.message)
        end

        private

        def refresh
          Thread.new do
            begin
              kick_member
              bluetooth_scan
              timestamp
            rescue => e
              message.reply(e.message)
            end
          end
        end

        def table
          OpenEsysOruka.table[:oru_list] ||= {
            timestamp: nil,
            member: [],
          }
        end

        def kick_member
          table[:member].select! { |i| i.exist_now? }
        end

        def bluetooth_scan
          Bluetooth.exist_list.each do |name|
            table[:member] << Member.new(name)
          end
        end

        def timestamp
          table[:timestamp] = Time.now
        end
      end
    end
  end
end
