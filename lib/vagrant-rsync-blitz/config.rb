require "vagrant"

module VagrantPlugins
  module RsyncBlitz
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :autostart
      attr_accessor :latency
      attr_accessor :time_format

      def initialize
        @autostart = UNSET_VALUE
        @latency = UNSET_VALUE
        @time_format = UNSET_VALUE
      end

      def finalize!
        @autostart = false if @autostart == UNSET_VALUE
        @latency = 2.0 if @latency == UNSET_VALUE
        @time_format = "%I:%M:%S %p" if @time_format == UNSET_VALUE
      end

      def validate(machine)
        errors = _detected_errors

        if @latency == UNSET_VALUE
          return
        elsif not @latency.is_a? Numeric
          @latency = 2.0
          errors << "Latency must be a number, setting to 2.0"
        elsif @latency < 0.2
          @latency = 0.2
          errors << "Latency must not be too low, setting to 0.2 seconds"
        end

        { "blitz" => errors }
      end
    end
  end
end
