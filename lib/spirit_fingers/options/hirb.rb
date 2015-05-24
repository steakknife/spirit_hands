autoload :Hirb, 'spirit_fingers/hirb'

module SpiritFingers
  class << self
    # Is hirb enabled?
    def hirb
      ::Hirb.enabled?
    end

    # Set whether hirb is enabled (default: false)
    def hirb=(h)
      h = DEFAULT_HIRB if h.nil?
      if hirb != h
        if h
          ::Hirb.enable
        else
          ::Hirb.disable
        end
      end
      @hirb = !!h
    end

    private

    def setup_hirb
      self.hirb = nil unless @hirb
    end
  end

  DEFAULT_HIRB = false

  # Whether to use hirb/unicode when hirb is enabled (default: true)
  mattr_accessor_with_default :hirb_unicode, true
end
