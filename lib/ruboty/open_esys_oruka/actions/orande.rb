module Ruboty
  module OpenEsysOruka
    module Actions
      class Orande < Ruboty::Actions::Base
        def call
          message.reply(orande)
        rescue => e
          message.reply(e.backtrace)
        end

        private

        def orande
          if exist?
            leave
            success_message
          else
            error_message
          end
        end

        def table
          brain      = message.robot.brain
          brain.data[:open_esys_oruka] ||= {}
          brain.data[:open_esys_oruka][:oru_list] ||= {
            timestamp: nil,
            member: [],
          }
        end

        def search_member
          table[:member].select { |i| i.name = message[:member_name] }
        end

        def exist?
          search_member.empty?.!
        end

        def leave
          table[:member].delete_if { |i| i.name = message[:member_name] }
        end

        def success_message
          "#{message[:member_name]} の退出処理が完了しました(｀･ω･´)"
        end

        def error_message
          <<-"EOS"
#{message[:member_name]} はもともと在室していなかったようです(´･ω･｀)
もしかしたら名前が間違っているかもしれません(´･ω･｀)
          EOS
        end
      end
    end
  end
end
