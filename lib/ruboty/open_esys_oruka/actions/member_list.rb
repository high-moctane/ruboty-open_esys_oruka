require "yaml"

module Ruboty
  module OpenEsysOruka
    module Actions
      class MemberList < Ruboty::Actions::Base
        def call
          message.reply(member_list)
        rescue => e
          message.reply(e.message)
        end

        private

        def oruka
          if (config = conf).empty?
            header +
              "おるか機能で監視できるメンバーはいません(´･ω･｀)\n"
          else
            header +
              "おるか機能で\n" +
              config.keys.join("\n") +
              "\nを監視できます(｀･ω･´)"
          end
        end

        def conf
          path = File.expand_path(ENV["OPENESYS_ORUKA_CONF"])
          YAML.load_file(path)
        end

        def header
          "#{Time.now.strftime "%R:%S"} 現在、"
        end
      end
    end
  end
end
