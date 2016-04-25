require "active_support"
require "yaml"

module Ruboty
  module OpenEsysOruka
    module Actions
      class Oruka < Ruboty::Actions::Base
        def call
          message.reply(oruka)
        rescue => e
          message.reply(e.backtrace)
        end

        private

        def oruka
          if    valid?.! then invalid_message
          elsif exist?   then exist_message
          else  no_member_message
          end
        end

        def header
          "#{table[:timestamp].strftime "%R:%S"} 現在、OE室には"
        end

        def table
          ::Ruboty::OpenEsysOruka.table[:oru_list] ||= {
            timestamp: nil,
            member: [],
          }
        end

        def valid?
          table[:timestamp]
        end

        def exist?
          table[:member].empty?.!
        end

        def invalid_message
          "oruka refresh コマンドを実行してください(´･ω･｀)"
        end

        def exist_message
          <<-"EOS"
#{header}
#{table[:member].join("\n")}
が在室しています(｀･ω･´)
          EOS
        end

        def no_member_message
          "#{header}誰もいません(´･ω･｀)"
        end
      end
    end
  end
end
