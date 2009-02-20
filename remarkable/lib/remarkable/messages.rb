module Remarkable
  module Messages

    # Provides a default description message. Overwrite it if needed.
    # By default it uses default i18n options, but without the subjects, which
    # usually are not available when description is called.
    #
    def description(options={})
      options = default_i18n_options.merge(options)

      # Remove subject keys
      options.delete(:subject_name)
      options.delete(:subject_inspect)

      Remarkable.t 'description', options
    end

    # Provides a default expectation message. Overwrite it if needed.
    # By default it uses default i18n options.
    #
    def expectation(options={})
      options = default_i18n_options.merge(options)
      Remarkable.t 'expectation', options
    end

    # Provides a default failure message. Overwrite it if needed.
    def failure_message
      Remarkable.t 'remarkable.core.failure_message', :expectation => expectation, :missing => @missing
    end

    # Provides a default negative failure message. Overwrite it if needed.
    def negative_failure_message
      Remarkable.t 'remarkable.core.negative_failure_message', :expectation => expectation
    end

    private

      # Returns the matcher scope in I18n.
      #
      # If the matcher is Remarkable::ActiveRecord::Matchers::ValidatePresenceOfMatcher
      # the default scope will be:
      #
      #   'remarkable.active_record.validate_presence_of'
      #
      def matcher_i18n_scope
        @matcher_i18n_scope ||= self.class.name.to_s.
                                gsub(/::Matchers::/, '::').
                                gsub(/::/, '.').
                                gsub(/Matcher$/, '').
                                gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
                                gsub(/([a-z\d])([A-Z])/,'\1_\2').
                                tr("-", "_").
                                downcase
      end

      # Default i18n options used in expectations, failure_message and
      # negative_failure_message. It provides by default the subject_name and
      # the subject_inspect value. But when used with DSL, it provides a whole
      # bunch of options (check dsl.rb for more information).
      #
      def default_i18n_options
        { :scope => matcher_i18n_scope,
          :subject_name => subject_name,
          :subject_inspect => @subject.inspect
        }
      end
  end
end
