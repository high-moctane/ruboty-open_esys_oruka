require "thread"
require "yaml"

module Ruboty
  module OpenEsysOruka
    module Bluetooth

      def scan(list = member_list)
        list.map { |k, v| [k, exist?(v)] }.to_h
      end

      def exist_list(list = member_list)
        scan(list).keep_if { |k, v| v }.keys
      end

      private

      def conf
        path = File.expand_path(ENV["OPENESYS_ORUKA_CONF"])
        YAML.load_file(path)
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