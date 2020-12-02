require "vagrant-rsync-blitz/plugin"
require "pathname"

module VagrantPlugins
  module RsyncBlitz
    lib_path = Pathname.new(File.expand_path("../vagrant-rsync-blitz", __FILE__))
    autoload :Errors, lib_path.join("errors")
    autoload :ListenOSX, lib_path.join("listen/listenosx")
    autoload :ListenLinux, lib_path.join("listen/listenlinux")
    autoload :ListenWindows, lib_path.join("listen/listenwindows")

    # This returns the path to the source of this plugin.
    #
    # @return [Pathname]
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end
