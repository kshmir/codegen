require 'active_support'

module Codegen
	module Sources
		class Base
			include ActiveSupport::Callbacks
			class << self
				attr_accessor :convert_to
			end

			def self.converts_to type
				if type.is_a? Symbol
					self.convert_to = type
				else
					self.convert_to = type.map { |t|  t.to_s.underscore.to_sym }
				end
			end

			define_callbacks :check_valid
			set_callback :check_valid, :before, :convert!

			def check_valid params
				self.convert_to.include? params[:type]
			end

			def convert!
		    run_callbacks :convert! do
		      convert
		    end
		  end
		end
	end
end