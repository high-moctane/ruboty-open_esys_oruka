require "ruboty/open_esys_oruka/bluetooth"
require "ruboty/open_esys_oruka/member"
require "ruboty/open_esys_oruka/version"
require "ruboty/handlers/open_esys_oruka"

module Ruboty
  module OpenEsysOruka
    class << self
      NAMESPACE = :open_esys_oruka

      def table
        robot.brain.data[NAMESPACE] ||= {}
      end
    end
  end
end
