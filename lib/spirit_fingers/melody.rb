require 'pry'

# We're managing the loading of plugins. So don't let pry autoload them.
::Pry.config.should_load_plugins = false

if defined? ::Rails
  STDERR.puts 'JF pry-rails' if ENV['SPIRIT_FINGERS_PLUGIN_DEBUG']
  require 'pry-rails'
end

module SpiritFingers
  autoload :Print,  'spirit_fingers/print'
  autoload :Prompt, 'spirit_fingers/prompt'

  class << self
    @installed = false
    # This modifies pry to play our tune
    def melody!(app = nil)
      return false if @installed

      # Require all of our pry plugins
      require 'spirit_fingers/load_plugins'

      setup_less_colorize
      setup_less_show_raw_unicode
      setup_hirb

      # Use awesome_print for output, but keep pry's pager. If Hirb is
      # enabled, try printing with it first.
      ::SpiritFingers::Print.install!

      # Friendlier prompt - line number, app name, nesting levels look like
      # directory paths.
      #
      # Configuration (like Pry.color) can be changed later or even during console usage.
      ::SpiritFingers::Prompt.install!(app)

      @installed = true
    end
  end
end
