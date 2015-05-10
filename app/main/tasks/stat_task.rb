class StatTask < Volt::Task
  def show_stats
    {
      ruby_version:     RUBY_VERSION,
      ruby_description: RUBY_DESCRIPTION,
      ruby_platform:    RUBY_PLATFORM
    }
  end
end
