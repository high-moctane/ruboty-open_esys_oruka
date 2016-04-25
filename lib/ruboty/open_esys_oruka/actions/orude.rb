module Ruboty
  module OpenEsysOruka
    module Actions
      class Orude < Ruboty::Actions::Base
        def call
          message.reply(orude)
        rescue => e
          message.reply(e.message)
        end

        private

        def orude
          if valid?
            register
            success_message
          else
            error_message
          end
        end

        def valid?
          convert_time(message[:exit_time])
        end

        def convert_time(string)
          now = Time.now
          h, m = [string[0..1], string[2..3]].map(&:to_i)
          candidate_today    = Time.new(now.year, now.mon, now.day, h, m)
          candidate_tomorrow = candidate_today + 60 * 60 * 24
          candidate_today > now ? candidate_today : candidate_tomorrow
        rescue ArgumentError => e
          false
        end

        def new_member
          ::Ruboty::OpenEsysOruka::Member.new(message[:member_name], exit_time: convert_time(message[:exit_time]))
        end

        def table
          brain      = message.robot.brain
          brain.data[:open_esys_oruka] ||= {}
          brain.data[:open_esys_oruka][:oru_list] ||= {
            timestamp: nil,
            member: [],
          }
        end

        def register
          table[:member] << new_member
        end

        def success_message
          "#{new_member}の入室を確認しました(｀･ω･´)"
        end

        def error_message
          <<-"EOS"
パラメータが無効です(´･ω･｀)
  名前（半角スペース）退出予定時刻の4桁の数字（24H）
のように書いてください(´･ω･｀)
          EOS
        end
      end
    end
  end
end
