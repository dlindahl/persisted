module Persisted
  module RecordFinder
    def persisted_record
      @persisted_record ||= existing_record
    end

    def attributes_for_finding
      shared_attrs = self.class.instance_variable_get '@shared_attributes'

      shared_attrs.each_with_object({}){ |k, a| a[k] = @params[k] }
    end

    def existing_record
      self.class.send(:persisted_record_class).where( attributes_for_finding ).first
    end
  end
end