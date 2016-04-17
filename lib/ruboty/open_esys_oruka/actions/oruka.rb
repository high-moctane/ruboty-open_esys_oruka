require "active_support"
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
          if (result = scan(member_list)).value?(true)
            header + "\n" +
              result.keep_if { |k, v| v }.keys.join("\n") +
              "\nがいます(｀･ω･´)"
          else
            header + "誰もいません(´･ω･｀)"
          end
        end

        def conf
          path = File.expand_path(ENV["OPENESYS_ORUKA_CONF"])
          YAML.load_file(path)
        end

        def header
          "#{Time.now.strftime "%R:%S"} 現在、OE室には"
        end

        def hcitool_name(btaddr)
          `hcitool name #{btaddr}`
        end

        def exist?(btaddr)
          case hcitool_name(btaddr)
          when "" then false
          else true
          end
        end

        def scan(list)
          list.map { |k, v| [k, exist?(v)] }.to_h
        end

        def secret
          path = File.expand_path(ENV["OPENESYS_ORUKA_KEY_FILE"])
          open(path, &:read)
        end

        def encryptor
          ::ActiveSupport::MessageEncryptor.new(secret, cipher: "aes-256-cbc")
        end

        def decrypt(message)
          encryptor.decrypt_and_verify(message)
        end

        def member_list
          conf.map { |k, v| [k, decrypt(v)] }.to_h
        end
      end
    end
  end
end
