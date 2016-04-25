module Ruboty
  module OpenEsysOruka
    class Member
      attr_reader :name, :status, :exit_time

      def initialize(name, exit_time: nil)
        @name      = name
        @exit_time = exit_time
      end

      def to_s
        "#{name}" + (exit_time ? to_s_exit_time : "")
      end

      def exist_now?(now = Time.now)
        exit_time && exit_time > Time.now
      end

      private

      def to_s_exit_time
        "（退出予定時刻：#{exit_time.strftime("%R")}）"
      end
    end
  end
end
