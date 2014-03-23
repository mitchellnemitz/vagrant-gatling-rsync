require "vagrant"

module VagrantPlugins
  module GatlingRsync
    module Errors
      class VagrantGatlingRsyncError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_gatling_rsync.errors")
      end

      class OnlyOSXSupportError < VagrantGatlingRsyncError
        error_key(:only_osx_support)
      end
    end
  end
end
