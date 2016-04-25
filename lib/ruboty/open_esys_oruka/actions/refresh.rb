require "thread"

module Ruboty
  module OpenEsysOruka
    module Actions
      class Refresh < Ruboty::Actions::Base
        def call
          refresh
        rescue => e
          message.reply(e.backtrace)
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
          ::Ruboty::OpenEsysOruka.table[:oru_list] ||= {
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
