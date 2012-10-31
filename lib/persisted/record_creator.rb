module Persisted
  module RecordCreator
    def persisted_record
      @persisted_record ||= super || create_record
    end

    def attributes_for_creation
      attrs = self.class.persisted_record_class.accessible_attributes - [''] # No idea where there is a blank string in there...

      attrs.each_with_object({}) { |k, a| a[k] = @params[k] }
    end

    def create_record
      self.class.persisted_record_class.create attributes_for_creation
    end
  end
end