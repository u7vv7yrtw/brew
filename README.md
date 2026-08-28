# typed: strict
# frozen_string_literal: true

module Homebrew
  # Configuration settings driven by environment variables.
  module EnvConfig
    class << self
      extend T::Sig

      # Returns true if HOMEBREW_NO_AUTO_UPDATE is set.
      sig { returns(T::Boolean) }
      def no_auto_update?
        ENV["HOMEBREW_NO_AUTO_UPDATE"].present?
      end

      # Returns true if HOMEBREW_NO_ANALYTICS is set.
      sig { returns(T::Boolean) }
      def no_analytics?
        ENV["HOMEBREW_NO_ANALYTICS"].present?
      end

      # Returns true if HOMEBREW_VERBOSE is set.
      sig { returns(T::Boolean) }
      def verbose?
        ENV["HOMEBREW_VERBOSE"].present?
      end

      # Returns true if HOMEBREW_DEBUG is set.
      sig { returns(T::Boolean) }
      def debug?
        ENV["HOMEBREW_DEBUG"].present?
      end
    end
  end
end