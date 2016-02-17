require "ruboty/open_esys_oruka/actions/oruka"

module Ruboty
  module Handlers
    # OpenEsys Oruka function
    class OpenEsysOruka < Base
      on(
        /(oruka|(お|オ)(る|ル)(か|カ))/i,
        name: 'oruka',
        description: 'oruka?'
      )

      env(:OPENESYS_ORUKA_CONF, "absolute path of config file.")

      def oruka(message)
        Ruboty::OpenEsysOruka::Actions::Oruka.new(message).call
      end

    end
  end
end
