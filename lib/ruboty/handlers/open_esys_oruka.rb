require "ruboty/open_esys_oruka/actions/oruka"
require "ruboty/open_esys_oruka/actions/member_list"

module Ruboty
  module Handlers
    # OpenEsys Oruka function
    class OpenEsysOruka < Base
      on(
        /(oruka|(お|オ)(る|ル)(か|カ))\z/i,
        name: 'oruka',
        description: 'ちょっと時間かかるのは勘弁な(｀･ω･´)'
      )

      on(
        /oruka (list|リスト)\z/i,
        name: "member_list",
        description: "oruka コマンドで監視できるメンバーのリスト(｀･ω･´)"
      )

      env(:OPENESYS_ORUKA_CONF, "absolute path of config file.")

      def oruka(message)
        Ruboty::OpenEsysOruka::Actions::Oruka.new(message).call
      end

      def member_list(message)
        Ruboty::OpenEsysOruka::Actions::MemberList.new(message).call
      end
    end
  end
end
