require "vagrant"

module VagrantPlugins
  module RsyncBlitz
    module Errors
      class VagrantRsyncBlitzError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_rsync_blitz.errors")
      end

      class OSNotSupportedError < VagrantRsyncBlitzError
        error_key(:os_not_supported)
      end

      class Vagrant15RequiredError < VagrantRsyncBlitzError
        error_key(:vagrant_15_required)
      end
    end
  end
end
