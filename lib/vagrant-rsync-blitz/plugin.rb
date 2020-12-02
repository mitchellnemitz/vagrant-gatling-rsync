begin
  require "vagrant"
rescue LoadError
  raise "The vagrant-rsync-blitz plugin must be run within Vagrant."
end

module VagrantPlugins
  module RsyncBlitz
    class Plugin < Vagrant.plugin(2)
      name "Rsync Blitz"
      description <<-DESC
      Rsync large project directories to your Vagrant VM without using many resources on the host.
      DESC

      # This initializes the internationalization strings.
      def self.setup_i18n
        I18n.load_path << File.expand_path("locales/en.yml", RsyncBlitz.source_root)
        I18n.reload!
      end

      action_hook "startup-rsync" do |hook|
        setup_i18n
        require_relative "action/startup_rsync"
        hook.after Vagrant::Action::Builtin::SyncedFolders, StartupRsync
      end

      command "rsync-blitz" do
        setup_i18n

        require_relative "command/rsync_auto"
        RsyncBlitzAuto
      end

      config "blitz" do
        require_relative "config"
        Config
      end
    end
  end
end
