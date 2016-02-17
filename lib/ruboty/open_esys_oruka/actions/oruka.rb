require "open_esys-oruka"
require "yaml"

module Ruboty
  module OpenEsysOruka
    module Actions
      class Oruka < Ruboty::Actions::Base
        def call
          message.reply(oruka)
        rescue => e
          message.reply(e.message)
        end

        private
        def oruka
          if (result = scan).value?(true)
            header + " " + result.keys.join("、") + " がいます(｀･ω･´)"
          else
            header + "誰もいません(´･ω･｀)"
          end
        end

        def conf
          YAML.load_file(ENV["OPENESYS_ORUKA_CONF"])
        end

        def scan
          OpenEsys::Oruka.scan(conf)
        end

        def header
          "#{Time.now.strftime "%R:%S"} 現在、OE室には"
        end
      end
    end
  end
end
