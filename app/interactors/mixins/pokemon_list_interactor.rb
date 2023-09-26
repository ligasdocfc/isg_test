# frozen_string_literal: true

module Mixins
  module IsgTestInteractor
    extend ActiveSupport::Concern

    class MissingAttributesError < StandardError; end
    class MethodOverrideError < StandardError; end

    included do
      include Interactor
      before :validate_required_attrs, :validate_overridden_methods, :delegate_attrs_to_context
    end

    class_methods do
      def attributes(*attrs)
        singleton_class.instance_variable_set(:@required_attrs, attrs)
      end

      def required_attrs
        singleton_class.instance_variable_get(:@required_attrs) || []
      end
    end

    private

    def validate_required_attrs
      missing_attrs = self.class.required_attrs.reject { |attr| context.to_h.key?(attr) }
      raise MissingAttributesError, "Missing required attrs: #{missing_attrs.join(', ')}" if missing_attrs.any?
    end

    def delegate_attrs_to_context
      context.to_h.each_key { |key| define_singleton_method(key) { context[key] } }
    end

    def validate_overridden_methods
      user_methods = self.class.instance_methods(false)
      protected_methods = context.to_h.keys & user_methods

      return if protected_methods.empty?

      raise MethodOverrideError, "#{protected_methods.join(', ')} cannot be overridden"
    end
  end
end
