require 'active_support/concern'

require 'persisted/version'
require 'persisted/record_creator'
require 'persisted/record_finder'

# Adds persistence to a Ruby Object
module Persisted
  extend ActiveSupport::Concern

  include RecordFinder
  include RecordCreator

  def persisted_record=( record )
    @persisted_record = record
  end

  def method_missing( method_name, *args )
    if persisted_record.respond_to? method_name
      persisted_record.send method_name, *args
    else
      super
    end
  end

  def respond_to_missing?( method_name, include_private = false )
    super || persisted_record.respond_to?( method_name )
  end

  module ClassMethods
    attr_accessor :persisted_record_class

    # Instructs the persistence layer which ORM-backed class to use to persist
    # the model.
    #
    # Usage:
    #   persist_with :user, attributes: %w{username password}
    #
    # Configuration options:
    # attributes: An array of shared attributes between models used for DB
    #             interactions. Basically, use this to find the appropriate record.
    #             Defaults to ['id']
    def persist_with( model_name, options = {} )
      self.persisted_record_class = model_name.to_s.camelize.constantize

      if options && options.is_a?( Hash )
        options.symbolize_keys!

        if options[:attributes].is_a?( Array )
          options[:attributes] ||= ['id']

          @shared_attributes = options[:attributes]
        end
      else
        raise ArgumentError, 'An array of shared attributes must be supplied as the :attributes option of the configuration hash'
      end
    end

    def method_missing( method_name, *args )
      if respond_to_missing? method_name
        persisted_record_class.send method_name, *args
      else
        super
      end
    end

    def respond_to_missing?( method_name, include_private = false )
      persisted_record_class.respond_to? method_name
    end
  end
end