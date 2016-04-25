require "ruboty/open_esys_oruka/actions/oruka"
require "ruboty/open_esys_oruka/actions/member_list"
require "ruboty/open_esys_oruka/actions/orude"
require "ruboty/open_esys_oruka/actions/orande"
require "ruboty/open_esys_oruka/actions/refresh"

module Ruboty
  module Handlers
    # OpenEsys Oruka function
    class OpenEsysOruka < Base
      on(
        /(oruka|おるか)\z/i,
        name: 'oruka',
        description: 'ちょっと時間かかるのは勘弁な(｀･ω･´)'
      )

      on(
        /(oruka|おるか) (list|リスト)\z/i,
        name: "member_list",
        description: "oruka コマンドで監視できるメンバーのリスト(｀･ω･´)"
      )

      on(
        /(orude|おるで) (?<member_name>.+?) (?<exit_time>\d{4})\z/i,
        name: "orude",
        description: "手動でおるで(｀･ω･´) （名前 4桁で退出予定時間）"
      )

      on(
        /(orande|おらんで) (?<member_name>.+?)\z/i,
        name: "orande",
        description: "手動で退出(｀･ω･´) （名前）"
      )

      on(
        /(oruka|おるか) refresh\z/i,
        name: "refresh",
        description: "メンバーの在室状況を更新する（表示はしない）(｀･ω･´)"
      )

      env(:OPENESYS_ORUKA_CONF, "absolute path of config file.")
      env(:OPENESYS_ORUKA_KEY_FILE, "absolute path of key file.")

      def oruka(message)
        Ruboty::OpenEsysOruka::Actions::Oruka.new(message).call
      end

      def member_list(message)
        Ruboty::OpenEsysOruka::Actions::MemberList.new(message).call
      end

      def orude(message)
        Ruboty::OpenEsysOruka::Actions::Orude.new(message).call
      end

      def orande(message)
        Ruboty::OpenEsysOruka::Actions::Orande.new(message).call
      end

      def refresh(message)
        Ruboty::OpenEsysOruka::Actions::Refresh.new(message).call
      end
    end
  end
end
